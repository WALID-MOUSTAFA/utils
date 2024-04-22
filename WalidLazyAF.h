#include <iostream>
#include "SDL2/SDL.h"

//this is an object orianted bootstrap wrapper for creating SDL application using c++
//in order to bootstrap an SDL app, first you have to  publicly derive a class from WalidLazyAF
//base class and follow the following steps:
//1- you have to pass a the window title, width and height to the base constructor.
//2- override two important functions, first: onInit, the newly defined function gets invoked
//only once as soon as the app constructed successfully. second: onUpdate, the defiend function
//gets invoked every iteration in the main loop, the double parameter passed to the function
//is the app elpased time.
//3- create a new instance of your derived class and call the method start() on it;
//the app should be constructed and running smoothly.
//the base class has the important and basic attributes that an SDL app needs, such as a
//the pointer of the window shown and the renderer assosiated with this window 

class WalidLazyAF {

public:
	
	SDL_Window* window;

	SDL_Renderer* renderer;

	SDL_Event event;

	bool is_running= true;
	
	WalidLazyAF(std::string win_title, int win_w, int win_h);	

	~WalidLazyAF();

	void start();

	virtual bool onInit()= 0;

	virtual bool onUpdate(double elpasedTime)= 0;	

	
private:

	bool constructAppLoop();

	int loopDelay=10;
	
};


WalidLazyAF::WalidLazyAF(std::string win_title, int win_w, int win_h)
{

	SDL_Init(SDL_INIT_EVERYTHING);
	this->window= SDL_CreateWindow(win_title.c_str(),
				       SDL_WINDOWPOS_UNDEFINED,
				       SDL_WINDOWPOS_UNDEFINED,
				       win_w,
				       win_h,
				       SDL_WINDOW_RESIZABLE);
	this->renderer= SDL_CreateRenderer(this->window, -1, 0);
	
}

bool
WalidLazyAF::constructAppLoop()
{
	while(this->is_running) {
		SDL_PollEvent(&this->event);
		switch(this->event.type){
		case SDL_QUIT:
			is_running= false;
			break;
		}
		

		this->onUpdate(SDL_GetTicks());
		
		SDL_RenderPresent(this->renderer);
		SDL_Delay(this->loopDelay);
	}


	return true;
} 

bool
WalidLazyAF::onInit()
{
	return true;
}

bool
WalidLazyAF::onUpdate(double elpasedTime)
{
	return true;
}

void
WalidLazyAF::start()
{
	this->onInit();
	this->constructAppLoop();
}



WalidLazyAF::~WalidLazyAF()
{
	SDL_DestroyWindow(this->window);
	SDL_DestroyRenderer(this->renderer);
}
