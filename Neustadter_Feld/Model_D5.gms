Set
ii Set of potential stations and current stations. Stations 1=R1.. 32=R32 33=North  /1*33/

i(ii) Set of Potential stations ;


i(ii)$(ord(ii)<32)=Yes;

alias(i,j);
alias(ii,jj);


Parameters
Coverage(ii,ii)
distance(ii,ii);



$call GDXXRW.EXE "C:\Users\chitr\OneDrive\Uddhav Working\Germany\OVGU\SEM-2\Master Seminar\Common Files\Gams_Files\Neustadter_Feld_2\Matrix_Neustadter_Feld.xlsx" par=Coverage rng=Data!b2:aj35 rdim=1 cdim= 1  
$GDXIN Matrix_Neustadter_Feld.gdx
$load Coverage
$GDXIN


* Distance between potential locations
distance(ii,jj)$(ord(ii)<ord(jj) and ord(ii)<33 and ord(jj)<33 and Coverage(ii,jj)>0)=0.266;

* Distance between potential locations and current stations
distance("4","33")=0.261;
distance("5","33")=0.205;


distance(ii,jj)=max(distance(ii,jj),distance(jj,ii));



Binary Variables

X(ii) 1 if the tram station is stablish in circle i 0 otherwise
y(ii,jj) 1 if station i serves circle j 0 otherwise;


Free Variable
Z value of the obejective function
;


Display coverage;
*$Exit


Equation Obje_function;
Obje_function.. Z=e= sum((ii,jj)$(distance(ii,jj)>0 and ord(jj)>32 and ord(ii)<33),distance(ii,jj)*X(ii))+sum((ii,jj)$(distance(ii,jj)>0),distance(ii,jj)*y(ii,jj));

Equation coverageConstraint(jj);
coverageConstraint(jj)$(i(jj)).. sum(ii$(Coverage(ii,jj)>0 and i(ii) ),Y(ii,jj))=g= 1;

Equation numberLocation;
numberLocation.. sum(ii$(i(ii)),X(ii))=l=6;

Equation matching;
matching(ii,jj)$(i(ii) and i(jj)).. y(ii,jj)-x(ii)=l=0;

model FLP /all/;
solve FLP min z using mip;
display x.l, distance;

