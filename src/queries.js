module.exports = {
    select: {
        all: {
            client: 'SELECT * FROM Client',
            product: 'SELECT * FROM Product',
            shippingCompany: 'SELECT * FROM ShippingCompany',
            rawMaterial: 'SELECT * FROM RawMaterial',
            package: 'SELECT * FROM Package',
            requirement: 'SELECT * FROM Requirement',
            request: 'SELECT * FROM Request',
            requestPackage: 'SELECT * FROM RequestPackage',
        }
    },
    insert: {
        client: (data) => `INSERT INTO Client VALUES (${data.cnpj}, '${data.name}', '${data.address}', '${data.startTime}');`,
        product: (data) => `INSERT INTO Product VALUES (${data.code}, '${data.name}', ${data.price})`,
        shippingCompany: (data) => `INSERT INTO ShippingCompany VALUES (${data.cnpj}, '${data.name}', ${data.price})`,
        rawMaterial: (data) => `INSERT INTO RawMaterial VALUES (${data.code}, '${data.name}', ${data.price}, ${data.quantity}, ${data.kg})`,
        package: (data) => `INSERT INTO Package VALUES (${data.code}, ${data.width}, ${data.height}, ${data.depth})`,
        requirement: (data) => `INSERT INTO Requirement VALUES (${data.codeProduct}, ${data.codeRMaterial}, ${data.quantity})`,
        request: (data) => `INSERT INTO Request VALUES (${data.code}, ${data.cnpjClient}, ${data.codeProduct}, ${data.quantity}, '${data.startTime}', '${data.endTime}', ${data.cnpjSCompany})`,
        requestPackage: (data) => `INSERT INTO RequestPackage VALUES (${data.codeRequest}, ${data.codePackage}, ${data.quantity})`,        
    }
}