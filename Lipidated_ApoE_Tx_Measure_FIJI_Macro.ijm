//This is an .ijm written to run in FIJI
//Katelyn Baker, University of Colorado Anschutz - Laboratory of Dr. Kimberley Bruce
//2025
//https://github.com/katelynb-sci


macro "Lipidated_ApoE_Tx_Measure"{
    count = 1;
    setBatchMode(true);
    
    //phalloidin
    file1= getDirectory("phalloidinlocation");
    list1= getFileList(file1); 
    n1=lengthOf(list1);
    
    //dapi
    file2= getDirectory("dapilocation");
    list2= getFileList(file2); 
    n2=lengthOf(list2);
    
    //popc
    file3= getDirectory("popclocation");
    list3= getFileList(file3); 
    n3=lengthOf(list3);
    
    
    //cell mask
   maskfile = getDirectory("cellmasklocation");
    listmask= getFileList(maskfile); 
    n4 = lengthOf(listmask);
    
    
    //where to save output
    filedir = getDirectory("outputlocation");
    
      small = n1;
    if(small<n2)
    small = n2;

    for(i=0;i<small;i++){
    
      name_mask = "_cellmask";
      name_phal = "_phalloidin";
      data_phal = "phall_data.csv";
      data_popc = "popc_data.csv";
      dapimask = "dapi";
	  dapidata = "dapi_data.csv";
	  popcmask = "in_cell_popc";
	  popc = "popc";
	  dapi = "dapi";
      
     
     
      m = "Mask of ";

      

//Channel 1 --> clean up phalloidin + actually getting phalloidin info
open(maskfile+listmask[i]);
run("Analyze Particles...", "size=200-Infinity show=Masks display include summarize overlay add");
open(file1+list1[i]);
run("Enhance Contrast", "saturated=0.30");
run("Sharpen");
run("Green");
run("From ROI Manager");
saveAs("tiff", filedir + list1[i] + name_phal);
saveAs("png", filedir + list1[i] + name_phal);
run("Clear Results");
run("Select All");
run("Set Measurements...", "area mean min perimeter bounding shape feret's integrated display redirect=None decimal=3");
roiManager("Measure");
selectWindow("Results");
saveAs("Results", filedir + list1[i] + data_phal); 

      
//Channel 2 --> Dapi
open(file2+list2[i]);
run("Sharpen");
run("Enhance Contrast...", "saturated=0.1");
run("Blue");
saveAs("tiff", filedir + list2[i] + dapi);
setAutoThreshold("Li dark");
run("Convert to Mask");
run("Watershed");
run("From ROI Manager");
saveAs("Tiff", filedir + list2[i] + dapimask);
run("Clear Results");
run("Select All");
run("Set Measurements...", "min display redirect=None decimal=3");
roiManager("Measure");
selectWindow("Results");
saveAs("Results", filedir + list2[i] + dapidata);      

      
//Channel 3 --> POPC
open(file3+list3[i]);
run("Min...", "value=205");
run("Max...", "value=555");
run("Subtract Background...", "rolling=25");
run("Red");
saveAs("Tiff", filedir + list3[i] + popc);
saveAs("png", filedir + list3[i] + popc);

run("From ROI Manager");
saveAs("Tiff", filedir + list3[i] + popcmask);
saveAs("png", filedir + list3[i] + popcmask);
run("Clear Results");
run("Select All");
run("Set Measurements...", "area mean min integrated display redirect=None decimal=3");
roiManager("Measure");
selectWindow("Results");
saveAs("Results", filedir + list3[i] + data_popc);
run("Select All");
roiManager("delete");  

      count++;
      
    }
}
