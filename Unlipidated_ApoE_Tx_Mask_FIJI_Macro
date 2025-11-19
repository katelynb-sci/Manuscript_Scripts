//This is an .ijm written to run in FIJI
//Katelyn Baker, University of Colorado Anschutz - Laboratory of Dr. Kimberley Bruce
//2025

macro "Unlipidated_ApoE_Tx_Mask"{
    count = 1;
    setBatchMode(true);
    
    //phalloidin
    file1= getDirectory("phalloidin_images_location");
    list1= getFileList(file1); 
    n1=lengthOf(list1);
    
    //dapi
    file2= getDirectory("dapi_images_location");
    list2= getFileList(file2); 
    n2=lengthOf(list2);

    
    //where to save mask
    filemask = getDirectory("mask_images_location");
    list3= getFileList(filemask); 
    
    
      small = n1;
    if(small<n2)
    small = n2;

    for(i=0;i<small;i++){
    
      name_mask = "_cellmask";
      name_phal = "_phalloidin";

      
      
// Channel 1 --> Phalloidin MASK
      open(file1+list1[i]);
//run("Brightness/Contrast...");
run("Sharpen");
run("Enhance Contrast...", "saturated=0.90 normalize");
setAutoThreshold("Triangle dark");
//run("Threshold...");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Close-");
run("Despeckle");
run("Despeckle");
saveAs("Tiff", filemask + list1[i] + name_mask);
// here is where you should manually put in your separating lines using black brush at TWO PIXEL width
      count++;
    }
}
