const toJSON = util.JSONToTable
export = function (this: void, options: { tags: string[], limit: number, pid: number }, succ: (this: void, posts: table) => void, fail?: Function) {
	HTTP({
		method: "GET",
		url: `https://rule34js.glitch.me/api?tags=${options.tags.join("+")}&limit=${options.limit || 100}&pid=${options.pid || 0}`,
		success: function (this: void, code, body, headers) {
			succ(toJSON(body))
		},
		failed: fail
	} as HTTPRequest)
}
