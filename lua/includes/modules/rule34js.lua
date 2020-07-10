local ____exports = {}
local toJSON
toJSON = util.JSONToTable
function ____exports.default(tags, succ, fail)
    HTTP(
        {
            method = "GET",
            url = "https://rule34js.glitch.me/api?tags=" .. tostring(
                table.concat(tags, "+" or ",")
            ),
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
