
function decompile {

    cfr_path=~/java_tools/cfr-0.149.jar    
    find $1 -name "*[.jarclass]" \
    | xargs  java -jar $cfr_path --outputdir $2

}

decompile $1 $2
