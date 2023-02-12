Set
ii Set of potential stations and current stations. Stations 1=R1.. 61=R61 62=West and 63= East /1*63/

i(ii) Set of Potential stations ;


i(ii)$(ord(ii)<62)=Yes;

alias(i,j);
alias(ii,jj);


Parameters
Coverage(ii,ii)
distance(ii,ii);



$call GDXXRW.EXE "C:\Users\chitr\OneDrive\Uddhav Working\Germany\OVGU\SEM-2\Master Seminar\Common Files\Gams_Files\Ottersleben\Matrix_Ottersleben.xlsx" par=Coverage rng=Data!b2:bm65 rdim=1 cdim= 1  
$GDXIN Matrix_Ottersleben.gdx
$load Coverage
$GDXIN


* Distance between potential locations
distance(ii,jj)$(ord(ii)<ord(jj) and ord(ii)<62 and ord(jj)<62 and Coverage(ii,jj)>0)=0.266;

* Distance between potential locations and current stations
distance("1","62")=1.3;
distance("2","62")=1.16;
distance("3","62")=1.22;
distance("4","62")=1.38;
distance("5","62")=1.3;
distance("35","63")=1.0;
distance("44","63")=1.39;
distance("52","63")=1.55;
distance("59","63")=1.77;

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
Obje_function.. Z=e= sum((ii,jj)$(distance(ii,jj)>0 and ord(jj)>61 and ord(ii)<62),distance(ii,jj)*X(ii))+sum((ii,jj)$(distance(ii,jj)>0),distance(ii,jj)*y(ii,jj));

Equation coverageConstraint(jj);
coverageConstraint(jj)$(i(jj)).. sum(ii$(Coverage(ii,jj)>0 and i(ii) ),Y(ii,jj))=g= 1;

Equation numberLocation;
numberLocation.. sum(ii$(i(ii)),X(ii))=l=11;

Equation matching;
matching(ii,jj)$(i(ii) and i(jj)).. y(ii,jj)-x(ii)=l=0;

model FLP /all/;
solve FLP min z using mip;
display x.l, distance;

