const toJSON = util.JSONToTable

export default function (this: void, tags: string[], succ: (this: void, posts: table) => void, fail?: Function) {
	HTTP({
		method: "GET",
		url: "https://rule34js.glitch.me/api?tags=" + tags.join("+"),
		success: function (this: void, code, body, headers) {
			succ(toJSON(body))
		},
		failed: fail
	} as HTTPRequest)
}
