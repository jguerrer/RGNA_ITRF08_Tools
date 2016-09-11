
# Programa para convertir coordenadas de geodesicas y alturas a cartesianas
#consideramos GRS80
#  a semieje mayor elipsoide   6 378 137
#  e2 es la primera excentricidad al cuadrado (0.006 694 380 022 90),
#-- X= (v + h)cos(phi)cos(lambda)


clear all;


estacion_i=1;

ano=2016
dia_del_ano_aprox=135
d_t=(ano + (dia_del_ano_aprox/365))  - 2010



epoca_nueva= ano + (dia_del_ano_aprox)/365;

uno = ones(25,1);



%lat=179584.7352;
%lon=-6048080.6609
%alt_geo=2010447.3576;

###############
##Cuidado, los angulos son en grados (360) , no en radianes


#GRS80
a=6378137;
e2=0.00669438002290;
FL=0.003352810681183637418;#version wikipedia
%f=0.00335281068118;#version inegi


### la verificacion se realiza con la documentacion de INEGI
#XA = 179584.7352
#YA = -6048080.6609
#ZA = 2010447.3576

###################### ahora hay que transladar las coordenadas usando la super formula
#   X_B=X_A + delta_tVx, es decir un desplazamiento lineal en tres ejes en ECF

#--los desplazamientos son  en metros por año
est=[
"CHET";
"CHI3";
"COL2";
"CULC";
"HER2";
"ICAM";
"ICEP";
"IMIE";
"IMIP";
"IDGO";
"IITJ";
"INEG";
"IPAZ";
"LPAZ";
"MERI";
"MEXI";
"MTY2";
"OAX2",
"TAMP";
"TOL2";
"UGTO";
"UQRO";
"USLP";
"UVER";
"VIL2"];

estaciones=cellstr(est);
vel=[
-0.0080 ,0.0022 	,-0.0004; 
-0.0120 ,0.0011 	,-0.0061; 
-0.0047 ,-0.0015 	,-0.0013; 
-0.0123 ,0.0011 	,-0.0072; 
-0.0126 ,0.0009 	,-0.0067; 
-0.0080 ,0.0018 	,-0.0013; 
-0.0067 ,0.0021 	,-0.0020; 
-0.0112 ,0.0014 	,-0.0058; 
-0.0104 ,0.0024 	,-0.0068; 
-0.0316 ,0.0284 	,0.0171 ;	
-0.0125 ,0.0005 	,-0.0055; 
-0.0018 ,0.0321 	,-0.0172; 
-0.0420 ,0.0259 	,0.0179 ;	
-0.0420 ,0.0259 	,0.0179 ;	
-0.0085 ,0.0008 	,-0.0002; 
-0.0208 ,0.0129 	,0.0154 ;	
-0.0106 ,0.0010 	,-0.0040; 
-0.0038 ,-0.0004 	,0.0027 ;	
-0.0095 ,0.0009 	,-0.0032; 
-0.0063 ,0.0018 	,-0.0024; 
-0.0090 ,-0.0002 	,-0.0027; 
-0.0079 ,0.0010 	,-0.0038; 
-0.0090 ,0.0019 	,-0.0024; 
-0.0061 ,0.0046 	,-0.0029; 
-0.0079 ,0.0021 	,-0.0003];


coords_estaciones=[
-88.2992248916667       ,18.4952767805556,		2.955000000000000	;
-106.086739963889       ,28.6621925722222,		1413.186999999999900	;
-103.701883911111       ,19.2444429833333,		528.783999999999990	;
-107.412596566667       ,24.7950853944444,		36.137999999999998	;
-110.967215583333       ,29.0925467888889,		186.949000000000010	;
-90.5274727972222       ,19.8534574666667,		2.587000000000000	;
-98.1875976194444       ,19.0330235416667,		2150.327000000000200	;
-104.607078519444       ,24.0674531,			1863.116000000000000	;
-103.446039552778       ,20.6845054472222,		1656.986000000000100	;
-116.616336844444       ,31.8618602972222,		-22.222000000000001	;
-106.445868297222       ,31.74493255,			1113.428000000000100	;
-102.284203419444       ,21.8561535555556,		1887.823000000000100	;
-110.330744294444       ,24.14527215,			-14.835000000000001	;
-93.1217624027778       ,16.7494259944444,		551.777000000000040	;
-102.612723652778       ,22.7781443194444,		2427.672999999999800	;
-89.6203175666667       ,20.9800454055556,		7.863000000000000	;
-100.312906319444       ,25.7155065888889,		521.740999999999990	;
-96.7167395138889       ,17.0783399527778,		1607.261999999999900	;
-97.86402745		        ,22.2783209444444,		21.050000000000001	;
-99.6434723555556       ,19.2932342972222,		2651.730000000000000	;
-101.271664572222       ,21.0027096,			2062.282000000000200	;
-100.412692713889       ,20.5911382583333,		1817.973000000000000	;
-101.015668730556       ,22.1442330222222,		1892.857999999999900	;
-96.1143541805556       ,19.165466675,			3.212000000000000	;
-92.9310985666667       ,17.9904106611111,		27.744000000000000	;
] ;


#lo primero es realizar una conversion de las coordenadas de la estacion a cartesianas, pero requerimos calcular v y h
sprintf("********  Geodesicas 2 cartesianas *****************")


lambda=coords_estaciones(:,1);#lon
phi=coords_estaciones(:,2);#lat
h=coords_estaciones(:,3);#guardamos las alturas

lambda_a=lambda;
phi_a=phi;
h_a=h;

v= a./ ( (ones(25,1)-e2.*sind(phi).^2  ).^0.5);

X_A=(v+h).*cosd(phi).*cosd(lambda);
Y_A=(v+h).*cosd(phi).*sind(lambda);
Z_A=(((ones(25,1)-e2).*v)  + h  ).*sind(phi);

sprintf("ESTACION %s",estaciones{estacion_i})
###############
##############

grad_lon = fix(lambda_a(estacion_i,1));
min_lon = fix( (lambda_a(estacion_i,1) - grad_lon)*60);
seg_lon = (lambda_a(estacion_i,1) - grad_lon - (min_lon/60.0))*3600;



sprintf("Geodesicas Epoca 2010 Lon %.4f", lambda_a(estacion_i,1) )  
sprintf("Geodesicas Epoca 2010 Lon %.0f %.0f %.5f", grad_lon, abs(min_lon), abs(seg_lon))  

################ hay que revisar los calculos de la latitud


grad_lat = fix(phi_a(estacion_i,1));
min_lat = fix((phi_a(estacion_i,1)  - grad_lat)*60);
seg_lat = (phi_a(estacion_i,1) - grad_lat - (min_lat/60.0)) *3600;

sprintf("Geodesicas Epoca 2010 LAT %.10f", phi_a(estacion_i,1))  
sprintf("Geodesicas Epoca 2010 LAT %.0f %.0f %.4f ",  grad_lat,abs(min_lat), abs(seg_lat))

################################################

sprintf("Geodesicas Epoca 2010 H %.4f",  h_a(estacion_i,1))  



######################
######################


sprintf("EPOCA 2010 X_A %.4f",X_A(1,1))  
sprintf("EPOCA 2010 Y_A %.4f",Y_A(1,1))  
sprintf("EPOCA 2010 Z_A %.4f",Z_A(1,1)) 

#alt_geo= 2.955;

#lat_g=18.0;
#lat_m=29.0;
#lat_s= 42.99641;

#lon_g= 88.0;1
#lon_m= 17.0 ;
#lon_s=57.20961;

#lat= lat_g + lat_m/60 + lat_s/3600;
#lon= lon_g + lon_m/60 + lon_s/3600;
#lon=lon*-1;


#######################################
#Hasta aqui todo concuerda, 
# Ahora desplazamos las coordenadas de las estaciones por la velocidad de las placas



X_B=X_A + d_t*vel(:,1);
Y_B=Y_A + d_t*vel(:,2);
Z_B=Z_A + d_t*vel(:,3);

sprintf("Epoca %.4f x_b  %.4f",epoca_nueva,  X_B(1,1))  
sprintf("Epoca %.4f y_b %.4f",epoca_nueva, Y_B(1,1)) 
sprintf("Epoca %.4f z_b %.4f",epoca_nueva, Z_B(1,1))  


#######################################

#Ahora transformamos las coordenadas de cartesianas a Geodesicas



#desde xyz2plh agregamos unos calculos magicos

sprintf("******** CArtesianas 2 geodesicas *****************")
A=a
B=A*(1-FL)
## hay que revisar si el valor de z es menor a cero, ponerle a b un negativo, pero para mexico creo no hay pex

## intermediate values for latttude

r=(X_B.^2 + Y_B.^2).^0.5
e=(B*Z_B - ones(25,1)*(A*A - B*B )   ) ./ (A*r)
f=(B*Z_B + ones(25,1)*(A*A - B*B )   ) ./ (A*r)

### solution to some equation


p=(4.0/3.0)*(e.*f + ones(25,1))
q= 2.0*(e.*e - f.*f)
d=p.*p.*p + q.*q

### nos falta una condifcional
## si d es negativo hacemos algo, pero suponemos no pasa nada por ahora


v= (   (d.^0.5) - q ).^(1/3)  - (   (d.^0.5) + q ).^(1/3)

## caso negativo
#v= 2.0 *( (-1*p).^0.5).*(cos(acos(q./ (p.*((-1*p).^0.5))) )./3.0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g= ((e.*e + v).^0.5 + e) ./2.0
t= ((g.*g + (f- v.*g)./(2.0.*g -e ) ).^0.5 )- g

phi_b=atan(  (A.*(ones(25,1)- t.*t))./(2.0*B.*t))

########## height above ellipsoid

height=(r - A.*t).*cos(phi_b) + (Z_B - B).*sin(phi_b)

#############################
## ahora lo mas dificil, la latitud al este

zlong= atan2(Y_B,X_B)## ??? que es esto

lambda_b=zlong;


rad_2_deg=180.0/pi;

phi_b=phi_b*rad_2_deg;
lambda_b=lambda_b*rad_2_deg;

h_b=height;

################################
#sprintf("  %.10f" ,X_B(1,1))
#sprintf("  %.10f" ,Y_B(1,1))
#sprintf("  %.10f" ,Z_B(1,1))

for k = 1:25

estacion_i=k;

###############


grad_lon = fix(lambda_b(estacion_i,1));
min_lon = fix( (lambda_b(estacion_i,1) - grad_lon)*60);
seg_lon = (lambda_b(estacion_i,1) - grad_lon - (min_lon/60.0))*3600;


sprintf("----------------------")

sprintf("ESTACION %s",estaciones{estacion_i})

#sprintf("Geodesicas Epoca Nueva Lon %.4f", lambda_b(estacion_i,1) )  
sprintf("Geodesicas Epoca %.4f Lon %.0f %.0f %.6f", epoca_nueva,  grad_lon, abs(min_lon), abs(seg_lon))  

################ hay que revisar los calculos de la latitud


grad_lat = fix(phi_b(estacion_i,1));
min_lat = fix((phi_b(estacion_i,1)  - grad_lat)*60);
seg_lat = (phi_b(estacion_i,1) - grad_lat - (min_lat/60.0)) *3600;

#sprintf("Geodesicas Epoca Nueva LAT %.10f", phi_b(estacion_i,1))  
sprintf("Geodesicas Epoca %.4f LAT %.0f %.0f %.6f ",epoca_nueva,  grad_lat,abs(min_lat), abs(seg_lat))

################################################

sprintf("Geodesicas Epoca %.4f %.4f", epoca_nueva, h_b(estacion_i,1))  


end 
#### el resultado debe ser 
#18 29 42.99643
#88 17 57.20990
#2.952    ## debe de bajar con respecto a la original


##############################################################
##############################################################
##############################################################
#############################################################
# Ahora se requiere usar una transformacion para regresar el o los puntos  a ITRF2008 epoca 2010


