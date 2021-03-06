DROP TABLE IF EXISTS "Tempo";
CREATE TABLE [Tempo]
(
    [TempoId] INTEGER  NOT NULL,
    [Time] NVARCHAR(160)  NOT NULL,
    [CotturaId] INTEGER ,
    [PesoId] INTEGER,
    [AlimentoId] INTEGER NOT NULL,
    CONSTRAINT [PK_Tempo] PRIMARY KEY  ([TempoId]),
    FOREIGN KEY ([CotturaId]) REFERENCES [Cottura] ([CotturaId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([PesoId]) REFERENCES [Peso] ([PesoId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([AlimentoId]) REFERENCES [Alimento] ([AlimentoId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);
INSERT INTO "Tempo" VALUES(1,'25',1,NULL,1);
INSERT INTO "Tempo" VALUES(2,'50',2,NULL,1);
INSERT INTO "Tempo" VALUES(3,'6',3,1,1);
INSERT INTO "Tempo" VALUES(4,'10',3,2,1);
INSERT INTO "Tempo" VALUES(5,'17',3,3,1);
INSERT INTO "Tempo" VALUES(6,'40',1,NULL,2);
INSERT INTO "Tempo" VALUES(7,'90',2,NULL,2);
INSERT INTO "Tempo" VALUES(8,'5',3,1,2);
INSERT INTO "Tempo" VALUES(9,'8',3,2,2);
INSERT INTO "Tempo" VALUES(10,'14',3,3,2);
INSERT INTO "Tempo" VALUES(11,'5',3,1,3);
INSERT INTO "Tempo" VALUES(12,'8',3,2,3);
INSERT INTO "Tempo" VALUES(13,'14',3,3,3);
