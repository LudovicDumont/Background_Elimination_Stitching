//Nicolas Levacher
// 2018-08
// Macro name:  Background elimination + stitching
// Goal : Enhance the quality of the images and stitch them if necessary 

// Information pop-up for the user :
showMessage("Parameters","<html><b>Be sure that your images are saved like this:</b><br>-1 file with the images to treat<br>-1 with the image of the white field<br>-1 with the image the black field");

////////////////////////////
//Declaration of variables//
////////////////////////////

//Selection of the original parent folder path:
directoryOri = getDirectory("Select parent folder of your image file");


//Dialog box creation with 5 fields to fill:
Dialog.create("Configuration");

Dialog.addChoice("Images format:", newArray(".TIF", ".JPG")); //Images format to treat 
Dialog.addString("Acquired Images:","");
Dialog.addString("Bright Field Image:","");  
Dialog.addString("Black Field Images:","");
Dialog.addCheckbox("Stitching",false);

Dialog.show();

//Information extraction
Echantillon = Dialog.getString();
CF = Dialog.getString();
DF = Dialog.getString(); 
Stitch= Dialog.getCheckbox();
directoryExt = Dialog.getChoice(); //Image format to treat and to save

directoryOri1=directoryOri + Echantillon; //File path to the acquired images (sample)
directoryOri2=directoryOri + CF; //File path to the white field images
directoryOri3=directoryOri + DF; //File path to the black field images

// Names of the directory files

files1 = getFileList(directoryOri1);
files2 = getFileList(directoryOri2);
files3 = getFileList(directoryOri3);

//Saving path selection

directorySave = directoryOri + File.separator + "\Results"; //Saving folder creation
File.makeDirectory(directorySave);
 
//Estimated time for treatment displaying: 

 if(files1.length==0){message1="Temps estime 00:00:00";
	 showMessage(message1);
 }else{if(files1.length==2){message2=" Estimated Time : 00:00:10";
	 showMessage(message2);
 }else{if(files1.length==3){message3=" Estimated Time : 00:00:20";
	 showMessage(message3);
 }else{if(files1.length==4){message4=" Estimated Time : 00:00:30";
	 showMessage(message4);
 }else{if(files1.length==5){message5=" Estimated Time : 00:00:45";
	 showMessage(message5);
 }else{if(files1.length==6){message6=" Estimated Time : 00:01:00";
	 showMessage(message6);
 }else{if(files1.length==7){message7=" Estimated Time : 00:01:15";
	 showMessage(message7);
 }else{if(files1.length==8){message8=" Estimated Time : 00:01:30";
	 showMessage(message8);
 }else{if(files1.length==9){message9=" Estimated Time : 00:02:00";
	 showMessage(message9);
 }else{if(files1.length==10){message10=" Estimated Time : 00:02:15";
	 showMessage(message10);
 }else{if(files1.length==11){message11=" Estimated Time : 00:03:00";
	 showMessage(message11);
 }else{if(files1.length==12){message12=" Estimated Time : 00:03:45";
	 showMessage(message12);
 }else{if(files1.length==13){message13=" Estimated Time : 00:04:15";
	 showMessage(message13);
 }else{if(files1.length==14){message14=" Estimated Time : 00:04:30";
	 showMessage(message14);
 }else{if(files1.length==15){message15=" Estimated Time : 00:05:15";
	 showMessage(message15);
 }else{if(files1.length==16){message16=" Estimated Time : 00:05:45";
	 showMessage(message16);
 }else{if(files1.length==17){message17=" Estimated Time : 00:06:30";
	 showMessage(message17);
 }else{if(files1.length==18){message18=" Estimated Time : 00:07:20";
	 showMessage(message18);
 }else{if(files1.length==19){message19=" Estimated Time : 00:08:15";
	 showMessage(message19);
 }else{if(files1.length==20){message20=" Estimated Time : 00:09:00";
	 showMessage(message20);
 }else{if(files1.length==21){message21=" Estimated Time : 00:10:00";
	 showMessage(message21);
}else{if(files1.length==22){message22=" Estimated Time : 00:11:00";
	 showMessage(message22);
}else{if(files1.length==23){message23=" Estimated Time : 00:12:00";
	 showMessage(message23);
}else{if(files1.length==24){message24=" Estimated Time : 00:13:00";
 showMessage(message24);
}else{if(files1.length==25){message25=" Estimated Time : 00:14:00";
	 showMessage(message25);
}else{if(files1.length==26){message26=" Estimated Time : 00:15:15";
	 showMessage(message26);
}else{if(files1.length==27){message27=" Estimated Time : 00:16:30";
	 showMessage(message27);
}else{if(files1.length==28){message28=" Estimated Time : 00:17:45";
	 showMessage(message28);
}else{if(files1.length==29){message29=" Estimated Time : 00:19:00";
	 showMessage(message29);
}else{if(files1.length==30){message30=" Estimated Time : 00:20:15";
	 showMessage(message30);
}else{if(files1.length>=31){message31=" Estimated Time : higher than 00:31:00";
	 showMessage(message31);
 }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}};

//Return the right file format in the saveAs function:
		if (directoryExt == ".JPG") {       
			sExt = "Jpeg";
		}else {
			sExt = "Tiff";
		}

i=0;
j=0; 
k=0;

//Start of the treatment loop 
do{endsWith(files1[i],directoryExt); 
	
Echantillon = files1[i];
CF=files2[j];
DF=files3[k];

pathOri1 = directoryOri1 + File.separator + files1[i]; //Access path to the images
pathOri2 = directoryOri2 + File.separator + files2[j]; //Access path the clear field images
pathOri3 = directoryOri3 + File.separator + files3[k]; //Access path the dark field images

pathDest = directorySave + File.separator +  files1[i]; //Saving path destination 


//Opens the 3 different image files 
open(pathOri1);
open(pathOri2);
open(pathOri3);


///////////////////
//Image treatment//
///////////////////

//Image rename
imageCalculator("Subtract create", CF,DF);
selectWindow("Result of "+CF);
rename("Divisor");
imageCalculator("Subtract create", Echantillon,DF);
selectWindow("Result of "+Echantillon);
rename("Numerator");

//Calculation of the corrected image
run("Calculator Plus", "i1=Numerator i2=Divisor operation=[Divide: i2 = (i1/i2) x k1 + k2] k1=255 k2=0 create");

//Close unecessary images 
selectWindow("Divisor");
close();
selectWindow("Numerator");
close();

// Select, rename and save the corrected image
selectWindow("Result");
rename("Corrected");
saveAs(sExt,pathDest);
i++;
//j++;
//k++;
run("Close All"); 

} while(i < files1.length); //condition

//If the stitching if filled in the initial checkbox:
if(Stitch){
	
//Source file automatically refound
directoryOri4 = directoryOri + File.separator + "\Results";
File.makeDirectory(directoryOri4);

//File creation nemed StitchResult
directorySave1 = directoryOri + File.separator + "\StitchResult";
File.makeDirectory(directorySave1);  
pathDest1=directorySave1 + File.separator + "\StitchedImage"; //Saving path 

//Stitching
run("Stitch Directory with Images (unknown configuration)", "image_directory=[&directoryOri4] output_file_name=ImageStitchee rgb_order=rgb channels_for_registration=[Red, Green and Blue] fusion_method=[Linear Blending] fusion_alpha=1.50 regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50");
saveAs(sExt,pathDest1);//Saving

};
showMessage("Image treatment over"); //End message