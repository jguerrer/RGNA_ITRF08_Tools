# RGNA_ITRF08_Tools
INEGI ITRF08 2010 tools, written on Octave(Matlab compatible) to  work with GPS reference stations for MEXICO within the North American tectonic plate only. Other plates or regions are not considered. This work started because the official transformation tool from INEGI no longer exists and some people report is not working.

Two steps are involved when working with reference stations from INEGI RGNA.

1) The reference stations from the RGNA(Red Geodesica Nacional Actiba) which are defined in IRTF08 epoch 2010, must be translated to the current epoch,   assigning them as the known coordinates for the INEGI reference stations when  prostprocessing the GPS data. 

2) Once the GPS data is postprocessed and results are computed for the current epoch, they must be transformed back to the official reference frame, i.e. ITRF08 epoch 2010 and reported accordingly.
See :
http://www.inegi.org.mx/geo/contenidos/geodesia/?_file=/geo/contenidos/geodesia/doc/proc_riguroso_v4_4.pdf

Why this two step process

Example:

  Today is 2016, September 9,  so the current epoch is 2016.254
  INEGI RGNA stations are set at epoch 2010.

  If I perform a GNSS survey today, all the data is collected on epoch 2016.254.
  
  All my reference stations must be transformed/translated from 2010 to the current epoch, 2016.254, and the epoch difference is more than 6 years. Some stations register movements of more than 1cm per year so 6 years mean 6 cm difference average with respect to the reference epoch 2010.
  
  If you are serious about milimeter precision in Horizontal and Vertical axis, then you must perform this rigurous process accordingly to INEGI. If decimiter accuracy is enough, then forget all about this and feel free to do whatever. Official proyects must follow this guidelines as everything shuold be reported in ITRF08, not current epoch.
  
  Despite the official procedure, all the stations move at different velocities than reported and some are reported as bad horizontal/vertical reference stations due the non continous displacements. I include some documents in spanish regarding the technical details of RGNA stations and their inconsistencies.
  
  If you have historical information for a known reference point, you can track its own displacement over the years and compute its velocity. Such cases are not considered for me or this tools, so  good luck.
  Good luck.
  
  IMPORTANT NOTES:
  The reported "Geoidal height of the antennas is "ellipsoidal height", and the final height must be transformed accordingly to orthometric height using GGM10. Please do not use your internal GPS height model as its geoidal model may not be compatible with GGM10.
  
  
  References
  
  El Geoide Gravimétrico Mexicano 2010
  http://internet.contenidos.inegi.org.mx/contenidos/productos//prod_serv/contenidos/espanol/bvinegi/productos/nueva_estruc/702825073374.pdf
  
  Calendario GPS y Coordenadas de las Estaciones Geodesicas IRTF08 Epoca 2010. Actualizada a los nuevos equipos y antenas.
  http://www.inegi.org.mx/geo/contenidos/geodesia/doc/cale2016_itrf2008.pdf
  LAst Access Sept 2016
  
  Obtencion de coordenadas GPS en ITRF y su relacion con WGS84 y NAD27
  http://www.inegi.org.mx/geo/contenidos/geodesia/doc/posicionamiento_gps_itrf.pdf
  LAst Access Sept 2016

  Procesamiento de Datos GPS Considerando Deformaciones del Marco Geodésico en el Tiempo, Mayo 2012
  http://www.inegi.org.mx/geo/contenidos/geodesia/?_file=/geo/contenidos/geodesia/doc/proc_riguroso_v4_4.pdf
  Last Access Sept 2016
