local toJSON
toJSON = util.JSONToTable
local function ____exports(options, succ, fail)
    HTTP(
        {
            method = "GET",
            url = (((("https://rule34js.glitch.me/api?tags=" .. tostring(
                table.concat(options.tags, "+" or ",")
            )) .. "&limit=") .. tostring(options.limit or 100)) .. "&pid=") .. tostring(options.pid or 0),
            success = function(code, body, headers)
                succ(
                    toJSON(body)
                )
            end,
            failed = fail
        }
    )
end
return ____exports
