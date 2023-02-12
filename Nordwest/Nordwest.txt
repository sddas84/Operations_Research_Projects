Set
ii Set of potential stations and current stations. Stations 1=R1.. 39=R39 40=Southwest and 41= West /1*41/

i(ii) Set of Potential stations ;


i(ii)$(ord(ii)<40)=Yes;

alias(i,j);
alias(ii,jj);


Parameters
Coverage(ii,ii)
distance(ii,ii);



$call GDXXRW.EXE "C:\Users\chitr\OneDrive\Uddhav Working\Germany\OVGU\SEM-2\Master Seminar\Uddhav\Gams_testing_7\Matrix_Nordwest.xlsx" par=Coverage rng=Data!b2:aq43 rdim=1 cdim= 1  
$GDXIN Matrix_Nordwest.gdx
$load Coverage
$GDXIN


* Distance between potential locations
distance(ii,jj)$(ord(ii)<ord(jj) and ord(ii)<40 and ord(jj)<40 and Coverage(ii,jj)>0)=0.266;

* Distance between potential locations and current stations
distance("21","40")=0.502;
distance("30","40")=0.460;
distance("1","41")=0.889;
distance("11","41")=0.889;


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
Obje_function.. Z=e= sum((ii,jj)$(distance(ii,jj)>0 and ord(jj)>40 and ord(ii)<41),distance(ii,jj)*X(ii))+sum((ii,jj)$(distance(ii,jj)>0),distance(ii,jj)*y(ii,jj));

Equation coverageConstraint(jj);
coverageConstraint(jj)$(i(jj)).. sum(ii$(Coverage(ii,jj)>0 and i(ii) ),Y(ii,jj))=g= 1;

Equation numberLocation;
numberLocation.. sum(ii$(i(ii)),X(ii))=l=7;

Equation matching;
matching(ii,jj)$(i(ii) and i(jj)).. y(ii,jj)-x(ii)=l=0;

model FLP /all/;
solve FLP min z using mip;
display x.l, distance;

