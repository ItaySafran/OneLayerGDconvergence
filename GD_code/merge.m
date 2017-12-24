clear;
cd('results');
for kV = 5:20
    for kW = kV:1:min(kV+2,20)
        WbadMerged = [];  
        objValsMerged = [];
        for i = 1:10
            Wbad = [];
            objVals = [];
            s = ['exp-' num2str(kV) '-' num2str(kW) '-' num2str(i) '.mat'];
            display(s);
            if exist(s,'file')
                load(s);
                if size(Wbad,1)>0
                    WbadMerged = cat(3,WbadMerged,Wbad); 
                    objValsMerged = [objValsMerged objVals];
                end;
            end
        end
        Wbad = WbadMerged; 
        objVals = objValsMerged;
        starget = ['exp-' num2str(kV) '-' num2str(kW) '.mat'];
        save(starget,'Wbad','objVals');
    end
end
cd('..')
