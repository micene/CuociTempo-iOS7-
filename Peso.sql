DROP TABLE IF EXISTS "Peso";
CREATE TABLE [Peso]
(
    [PesoId] INTEGER  NOT NULL,
    [Weight] INTEGER  NOT NULL,
    CONSTRAINT [PK_Peso] PRIMARY KEY  ([PesoId])
);
INSERT INTO "Peso" VALUES(1,250);
INSERT INTO "Peso" VALUES(2,500);
INSERT INTO "Peso" VALUES(3,1000);
