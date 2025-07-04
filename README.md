# TradeNote-SelfHost
This user-friendly make CLI that enable any budding trader to host and use an Open Source Trading Journal called [TradeNote]() with no hardware need if you run it in Github's CodeSpace. It has CLI to help you backup and restore your data easily. The make directive should also work in any Linux/Mac machine (if your have all the prerequiste dependencies installed. eg: Docker)

# What's new

Beta release

# Use TradeNote in CodeSpace

## Fork this github repository and launch CodeSpace
![CodeSpace](./docs/images/codespace.png)


## Start TradeNote
In the terminal console, enter this command to start TradeNote
```ssh
make start
```

The URI is listed in the PORTS tab. Click on the forwarded address for 8080
![ports](./docs/images/ports.png)

Default user is listed in `Makefile` variable called `TN_USER`. Same password. Or you can create a new one

## Other useful commands
Usually, you only need to know 2 make-commands

`make start`
- to start the service

`make backup`
- to backup your data as a zip. It will be store in a file called `./backup/tradenote_db_backup.tar.gz`.
- you should occasionally commit this into your github to store the backup data

## Restoring data
In the event you need to start a new codespace (codespace instance are delete by github after 1 month of inactive usage), use the following command to restore the instance in a new codespace

`make restore`

## 🕊️ In Memory of [paulgoh]

This project is dedicated to the memory of [@paulgoh](https://github.com/paulgoh), my collegue, my friend and my brother. RIP 💙
