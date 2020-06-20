CREATE TABLE public.meteocat_xdde_requests
(
   year integer,
   month integer,
   day integer,
   hour integer,
   result_code integer NOT NULL DEFAULT 200,
   number_of_lightnings integer NOT NULL DEFAULT 0,
   ts timestamp with time zone DEFAULT (now() at time zone 'utc'),
   CONSTRAINT pk_xdde_requests PRIMARY KEY (year, month, day, hour)
)
WITH (
  OIDS = FALSE
)
;
ALTER TABLE public.meteocat_xdde_requests
  OWNER TO gisfireuser
;


CREATE TABLE public.meteocat_lightnings
(
  _id bigint,
  _data timestamp with time zone NOT NULL,
  _correntPic double precision NOT NULL,
  _chi2 double precision NOT NULL,
  _ellipse_eixMajor double precision NOT NULL,
  _ellipse_eixMenor double precision NOT NULL,
  _ellipse_angle double precision NOT NULL,
  _numSensors integer NOT NULL,
  _nuvolTerra boolean NOT NULL,
  _idMunicipi integer NOT NULL,
  _coordenades_latitud double precision NOT NULL,
  _coordenades_longitud double precision NOT NULL,
  ts timestamp with time zone DEFAULT (now() at time zone 'utc'),
  CONSTRAINT pk_lightnings PRIMARY KEY (_id)
)
WITH (
  OIDS = FALSE
)
;
ALTER TABLE public.meteocat_lightnings
  OWNER TO gisfireuser
;
SELECT AddGeometryColumn ('public', 'lightnings', 'geom', 4258, 'POINT', 2)
;
