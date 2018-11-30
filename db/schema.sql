DROP DATABASE IF EXISTS Factory;

CREATE DATABASE Factory;

USE Factory;

CREATE TABLE Client (
    cnpj        DECIMAL(8)      UNSIGNED NOT NULL,
    name        VARCHAR(40)     NOT NULL,
    address     VARCHAR(55),
    startTime   DATE,

    PRIMARY KEY(cnpj)
);

CREATE TABLE Product (
    code        DECIMAL(4)      UNSIGNED NOT NULL,
    name        VARCHAR(40),
    price       DECIMAL(5,2)    NOT NULL,

    PRIMARY KEY(code)
);

CREATE TABLE RawMaterial (
    code        DECIMAL(4)      UNSIGNED NOT NULL,
    name        VARCHAR(40),
    price       DECIMAL(5,2)    UNSIGNED NOT NULL,
    quantity    DECIMAL(10,3),
    kg          BOOLEAN, -- CHANGED

    PRIMARY KEY(code)
);

CREATE TABLE Requirement (
    codeProduct DECIMAL(4)      UNSIGNED NOT NULL,
    codeRMaterial DECIMAL(4)    UNSIGNED NOT NULL,
    quantity    DECIMAL(5,2)    UNSIGNED NOT NULL,

    PRIMARY KEY(codeProduct, codeRMaterial),
    FOREIGN KEY(codeProduct) REFERENCES Product(code) ON 
        UPDATE CASCADE,
    FOREIGN KEY(codeRMaterial) REFERENCES RawMaterial(code) ON 
        UPDATE CASCADE
);

CREATE TABLE ShippingCompany (
    cnpj        DECIMAL(8)      UNSIGNED NOT NULL,
    name        VARCHAR(40)     NOT NULL,
    price       DECIMAL(5,2)    NOT NULL,

    PRIMARY KEY(cnpj)
);

CREATE TABLE Package (  -- CHANGED
    code        DECIMAL(4)      UNSIGNED NOT NULL,
    width       DECIMAL(6, 2)   NOT NULL,
    height      DECIMAL(6, 2)   NOT NULL,
    depth       DECIMAL(6, 2)   NOT NULL,

    PRIMARY KEY(code)
);

CREATE TABLE Request (
    code        DECIMAL(8)      UNSIGNED NOT NULL,
    cnpjClient  DECIMAL(8)      UNSIGNED NOT NULL,
    codeProduct DECIMAL(4)      UNSIGNED NOT NULL,
    quantity    DECIMAL(10,3)   UNSIGNED NOT NULL,
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

CREATE TABLE RequestPackage (   -- CHANGED
    codeRequest DECIMAL(8)      UNSIGNED NOT NULL,
    codePackage DECIMAL(4)      UNSIGNED NOT NULL,
    quantity    INTEGER,

    PRIMARY KEY(codeRequest, codePackage),
    FOREIGN KEY(codeRequest) REFERENCES Request(code) ON
        UPDATE CASCADE,
    FOREIGN KEY(codePackage) REFERENCES Package(code) ON
        UPDATE CASCADE
);