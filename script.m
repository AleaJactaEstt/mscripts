function isCorrect = toPythonArray(fileName)
    eval(fileName(1:length(fileName)-2));
    mArrays = whos;
    isCorrect = false;
    newFileName = fileName(1:length(fileName)-2) + ".py";
    fileId = fopen(newFileName, 'w');
    if fileId == -1
        return 
    end
     
    for i=1:length(mArrays)-1
        currentString = "[";
        currentArray = eval(mArrays(i).name);
        mArrays(i).name
        sizeArray = size(currentArray);
        if sizeArray(1) == 1  
            currentString = currentString + currentArray(1);
            for j = 2:length(currentArray)
                currentString = currentString + " , " + currentArray(j);
            end
            currentString = currentString + "]";
        else
            for j = 2:sizeArray(1)
                subArray = "[" + currentArray(j, 1);
                for k = 2:sizeArray(2)
                    subArray = subArray + " , " + currentArray(j, k);
                end
                currentString = currentString + " , " + subArray + "]";
            end
            currentString = extractBefore(currentString, 2) + extractAfter(currentString, 4);
            currentString = currentString + "]";
        end
        fprintf(fileId, mArrays(i).name + " = " + currentString + "\n\n");
    end
    isCorrect = true;
end