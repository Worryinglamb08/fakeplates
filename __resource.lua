resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description "Fake plates for ESX"
client_scripts {
	"client/*.lua",
	"client/*.dll"
}
server_scripts {
	"server/*.lua",
	'@mysql-async/lib/MySQL.lua'
}
version "1.0.0"