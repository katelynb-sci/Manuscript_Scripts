//This is an .ijm written to run in FIJI
//Katelyn Baker, University of Colorado Anschutz - Laboratory of Dr. Kimberley Bruce
//2025
//https://github.com/katelynb-sci

macro "APOE_Unlipidated_Plate_2"{
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
    
    //bodipy
    file3= getDirectory("bodipylocation");
    list3= getFileList(file3); 
    n3=lengthOf(list3);
    
    
    //cell mask
   maskfile = getDirectory("cellmasklocation");
    listmask= getFileList(maskfile); 
    n4 = lengthOf(listmask);
    
    
    //where to save mask/roi
    filedir = getDirectory("outputlocation");
    
      small = n1;
    if(small<n2)
    small = n2;

    for(i=0;i<small;i++){
    
      name_mask = "_cellmask";
      name_phal = "_phalloidin";
      data_phal = "phall_data.csv";
      data_bodipy = "bodipy_data.csv";
      dapimask = "dapi";
	  dapidata = "dapi_data.csv";
	 bodipymask = "in_cell_bodipy";
	  bodipy = "bodipy";
	  dapi = "dapi";
      roi = "roiset.zip";
     
     
      m = "Mask of ";

      

//Channel 1 --> clean up phalloidin + actually getting phalloidin info
open(maskfile+listmask[i]);
run("Analyze Particles...", "size=200-Infinity show=Masks display include summarize overlay add");
roiManager("Save", filedir + listmask[i] + roi);
open(file1+list1[i]);
run("Sharpen");
run("Cyan");
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

      
//Channel 3 --> BODIPY
open(file3+list3[i]);
run("Subtract Background...", "rolling=20");
run("Sharpen");
run("Magenta");
saveAs("Tiff", filedir + list3[i] + bodipy);
saveAs("png", filedir + list3[i] + bodipy);
run("From ROI Manager");
saveAs("Tiff", filedir + list3[i] + bodipymask);
saveAs("png", filedir + list3[i] + bodipymask);
run("Clear Results");
run("Select All");
run("Set Measurements...", "area mean min integrated display redirect=None decimal=3");
roiManager("Measure");
selectWindow("Results");
saveAs("Results", filedir + list3[i] + data_bodipy);
run("Select All");
roiManager("delete"); 

      count++;
      
    }
}
