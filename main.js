const { app, BrowserWindow } = require('electron');
const ipc = require('./src/ipc');
const path = require('path');

function createWindow(win, width = 800, height = 600) {
    win = new BrowserWindow({ width, height });
    win.loadFile(path.join(__dirname, 'window', 'index.html'));
    win.webContents.openDevTools();
    win.on('closed', () => { win = null });
}

let win = null;

app.on('ready', createWindow.bind(null, win));