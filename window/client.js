const btnAdd = document.getElementById('btn-add');
const btnCNPJ = document.getElementById('input-cnpj');
const btnName = document.getElementById('input-name');
const btnAddress = document.getElementById('input-address');
const btnDate = document.getElementById('input-date');

const ulMain = document.getElementById('list');

btnAdd.addEventListener('click', event => {
    event.preventDefault();
    const data = {
        cnpj: btnCNPJ.value,
        name: btnName.value,
        address: btnAddress.value,
        startTime: btnDate.value,
    };
    man.query(queries.insert.client(data)).then(() => renderListByDB()).catch(err => {
        alert('Erro ao adicionar\n' + err);
    });
});

function renderList(data) {
    let fragment = document.createDocumentFragment(), li, cnpj, name, address, date;
    data.forEach(value => {
        li = document.createElement('li');
        cnpj = document.createElement('span');
        name = document.createElement('span');
        address = document.createElement('span');
        date = document.createElement('span');

        cnpj.innerText = value.cnpj + '\n';
        name.innerText = value.name + '\n';
        address.innerText = value.address + '\n';
        date.innerText = `${value.startTime.getDate() + 1} - ${value.startTime.getMonth() + 1} - ${value.startTime.getFullYear()}`;
        li.appendChild(cnpj);
        li.appendChild(name);
        li.appendChild(address);
        li.appendChild(date);

        fragment.appendChild(li.cloneNode(true));
    });
    ulMain.innerText = '';
    ulMain.appendChild(fragment.cloneNode(true));
}

function renderListByDB() {
    man.query(queries.select.all.client).then(data => renderList(data) ).catch(err => alert('Erro ao consultar BD\n' + err));
}

renderListByDB();

// renderList([{name: 'fulano', cnpj: 123, address: 'asd', date: '2019-01-12'}, 
//     {name: 'fulano', cnpj: 123, address: 'asd', date: '2019-01-12'}]);