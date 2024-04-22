//take a list of predicates and return q query

package com.conscripts.services;

import com.conscripts.domain.Conscript;
import jakarta.persistence.EntityManager;
import jakarta.persistence.criteria.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Component
public class CustomQueryBuilder<T> {
    private EntityManager entityManager;
    private CriteriaBuilder criteriaBuilder;
    private Map<String, Map<String, Object>> inputs;
    private CriteriaQuery<T> query;
    private List<Predicate> predicateList;
    private Root<T> root;

    private Class<T> type;

    public void setType(Class<T> type) {
        this.type = type;
        this.query= this.criteriaBuilder.createQuery(type);
        this.root = this.query.from(this.type);
    }


    @Autowired
    public CustomQueryBuilder(EntityManager entityManager) {
        this.criteriaBuilder = entityManager.getCriteriaBuilder();
        this.predicateList = new ArrayList<>();
    }


    public void setInputs(Map<String, Map<String, Object>> inputs) {
        this.inputs = inputs;
    }

  

    private void constructLikes(Map<String, Object> likes) {
	for (var entry : likes.entrySet()){
            if(entry.getValue().toString().length() == 0
	       || entry.getValue().toString() == null || entry.getValue().toString() == "null") continue;
            if(entry.getKey().contains(".")) {
                String[] parts = entry.getKey().split("\\.");
		Path<String> nestedPath = this.root.get(parts[0]);
		for (int i= 1; i < parts.length; i++) {
		    nestedPath = nestedPath.get(parts[i]);
		}
                this.predicateList
		    .add(this.criteriaBuilder.like(nestedPath,
						   "%"+entry.getValue().toString()+"%"));
            } else {
		this.predicateList
                    .add(this.criteriaBuilder.
			 like(this.root
			      .get(entry.getKey()), "%" + entry.getValue().toString() + "%"));
	    }
        }
    }

    private void constructEquals(Map<String, Object> equals) {
	for (var entry : equals.entrySet()){
            if(entry.getValue() == null || entry.getValue().toString().length() == 0
	        || entry.getValue() == null || entry.getValue() == "null") continue;
            if(entry.getKey().contains(".")) {
                String[] parts = entry.getKey().split("\\.");
		Path<String> nestedPath = this.root.get(parts[0]);
		for (int i= 1; i < parts.length; i++) {
		    nestedPath = nestedPath.get(parts[i]);
		}
                this.predicateList
		    .add(this.criteriaBuilder.equal(nestedPath,
                            entry.getValue()));
            } else {
		this.predicateList
                    .add(this.criteriaBuilder.
			 equal(this.root
			      .get(entry.getKey()),  entry.getValue()));
	    }
        }
    }

    //the object is list
    private void constructMulti(Map<String, Object> mutli) {
	for (var entry : mutli.entrySet()){
	    if(entry.getValue() == null) continue;
            if(((List<Object>)entry.getValue()).size() == 0
	        || entry.getValue() == null || entry.getValue() == "null") continue;
            if(entry.getKey().contains(".")) {
                String[] parts = entry.getKey().split("\\.");
		Path<String> nestedPath = this.root.get(parts[0]);
		for (int i= 1; i < parts.length; i++) {
		    nestedPath = nestedPath.get(parts[i]);
		}
                this.predicateList
		    .add(nestedPath.in(((List<?>) entry.getValue()).toArray()));
            } else {
                Object[] arr = ((List<?>) entry.getValue()).toArray();
		this.predicateList
                    .add(this.root.get(entry.getKey()).in(arr));
	    }
        }
    }
    
    private void constructPredicateList() {
	this.predicateList.clear();
        Map<String, Object> likes = this.inputs.get("likes");
		Map<String, Object> equals = this.inputs.get("equals");
		Map<String, Object> multi = this.inputs.get("multi");

	this.constructLikes(likes);
	this.constructMulti(multi);
	this.constructEquals(equals);
    }

    public CriteriaQuery<T> getQuery() {
        this.constructPredicateList();
       Predicate finalPredicate = this.criteriaBuilder
                .and(this.predicateList.toArray(new Predicate[this.predicateList.size()]));
        this.query.where(finalPredicate);
        return this.query;
    }
}
