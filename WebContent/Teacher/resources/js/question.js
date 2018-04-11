// JavaScript Document
var aDiv=document.getElementsByTagName("div");
var aTd=document.getElementsByTagName("td");
var aBtn=document.getElementsByTagName("button");
var aDiv_myDiv = [];
var aTd_myTd = [];
var aBtn_myBtn = [];

for(i=0,j=0;i<aDiv.length;i++){
	if(aDiv[i].className=="white_content"){
		aDiv_myDiv[j]=aDiv[i];
		j++;
	}
}
for(i=0,j=0;i<aTd.length;i++){
	if(aTd[i].className=="question_td"){
		aTd_myTd[j]=aTd[i];
		j++;
	}
}
for(i=0,j=0;i<aBtn.length;i++){
	if(aBtn[i].className=="question_btn"){
		aBtn_myBtn[j]=aBtn[i];
		j++;
	}
}
for(i=0;i<aTd_myTd.length;i++){
	 aTd_myTd[i].index=i;
	aTd_myTd[i].onclick =function(){
		for(j=0;j<aTd_myTd.length;j++){
			aDiv_myDiv[j].style.display="none";	
		}
		var high=110+this.index*100;
		aDiv_myDiv[this.index].style.top=high+"px";
		aDiv_myDiv[this.index].style.display="block";
	}
}
for(i=0;i<aBtn_myBtn.length;i++){
	aBtn_myBtn[i].index=i;
	aBtn_myBtn[i].onclick =function(){
			aDiv_myDiv[this.index].style.display="none";
	}
}