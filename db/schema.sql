DROP DATABASE IF EXISTS Factory;

CREATE DATABASE Factory;

USE Factory;

CREATE TABLE Client (
    cnpj        DECIMAL(8)      UNSIGNED NOT NULL,
    name        VARCHAR(40)     NOT NULL DEFAULT 'NONAME',
    address     VARCHAR(55),
    startTime   DATE,

    PRIMARY KEY(cnpj)
);

CREATE TABLE Product (
    code        DECIMAL(4)      UNSIGNED NOT NULL,
    name        VARCHAR(40)		DEFAULT 'NONAME',
    price       DECIMAL(5,2)    DEFAULT 0 NOT NULL CHECK (price >= 0),

    PRIMARY KEY(code)
);

CREATE TABLE RawMaterial (
    code        DECIMAL(4)      UNSIGNED NOT NULL,
    name        VARCHAR(40)		DEFAULT 'NONAME',
    price       DECIMAL(5,2)    UNSIGNED DEFAULT 0 NOT NULL CHECK (price >= 0),
    quantity    DECIMAL(10,3)	DEFAULT 0 CHECK (quantity >= 0),
    kg          BOOLEAN			DEFAULT FALSE, 

    PRIMARY KEY(code)
);

CREATE TABLE Requirement (
    codeProduct DECIMAL(4)      UNSIGNED NOT NULL,
    codeRMaterial DECIMAL(4)    UNSIGNED NOT NULL,
    quantity    DECIMAL(5,2)    UNSIGNED DEFAULT 0 NOT NULL CHECK (quantity >= 0),

    PRIMARY KEY(codeProduct, codeRMaterial),
    FOREIGN KEY(codeProduct) REFERENCES Product(code) ON 
        UPDATE CASCADE,
    FOREIGN KEY(codeRMaterial) REFERENCES RawMaterial(code) ON 
        UPDATE CASCADE
);

CREATE TABLE ShippingCompany (
    cnpj        DECIMAL(8)      UNSIGNED NOT NULL,
    name        VARCHAR(40)     NOT NULL DEFAULT 'NONAME',
    price       DECIMAL(5,2)    UNSIGNED DEFAULT 0 NOT NULL CHECK (price >= 0),

    PRIMARY KEY(cnpj)
);

CREATE TABLE Package (  
    code        DECIMAL(4)      UNSIGNED NOT NULL,
    width       DECIMAL(6, 2)   UNSIGNED DEFAULT 0 NOT NULL CHECK (width >= 0),
    height      DECIMAL(6, 2)   UNSIGNED DEFAULT 0 NOT NULL CHECK (height >= 0),
    depth       DECIMAL(6, 2)   UNSIGNED DEFAULT 0 NOT NULL CHECK (depth >= 0),

    PRIMARY KEY(code)
);

CREATE TABLE Request (
    code        DECIMAL(8)      UNSIGNED NOT NULL,
    cnpjClient  DECIMAL(8)      UNSIGNED NOT NULL,
    codeProduct DECIMAL(4)      UNSIGNED NOT NULL,
    quantity    DECIMAL(10,3)   UNSIGNED DEFAULT 0 NOT NULL CHECK (quantity >= 0),
    startTime   DATE,
    endTime     DATE,
    cnpjSCompany DECIMAL(8)     UNSIGNED NOT NULL,

    PRIMARY KEY(code),
    FOREIGN KEY(cnpjClient) REFERENCES Client(cnpj) ON
        UPDATE CASCADE,
    FOREIGN KEY(codeProduct) REFERENCES Product(code) ON
        UPDATE CASCADE,
    FOREIGN KEY(cnpjSCompany) REFERENCES ShippingCompany(cnpj) ON
        UPDATE CASCADE
);

CREATE TABLE RequestPackage (
    codeRequest DECIMAL(8)      UNSIGNED NOT NULL,
    codePackage DECIMAL(4)      UNSIGNED NOT NULL,
    quantity    DECIMAL(5,2)	UNSIGNED DEFAULT 0 NOT NULL CHECK (quantity >= 0),

    PRIMARY KEY(codeRequest, codePackage),
    FOREIGN KEY(codeRequest) REFERENCES Request(code) ON
        UPDATE CASCADE,
    FOREIGN KEY(codePackage) REFERENCES Package(code) ON
        UPDATE CASCADE
);
