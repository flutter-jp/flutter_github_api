class BasicAuthParam {
	final List<String> scopes;
	final String note;
	final String noteURL;
	final String clientID;
	final String clientSecret;

	BasicAuthParam(
			this.clientID,
			this.clientSecret, {
				this.scopes = const ['user', 'repo', 'gist', 'notifications'],
				this.note = 'nothing to note',
				this.noteURL = 'https://xiaomo.info',
			});

	Map<String, dynamic> toDict() {
		return {
			'scopes': scopes,
			'note': note,
			'note_url': noteURL,
			'client_id': clientID,
			'client_secret': clientSecret,
		};
	}
}/// github app
class Auth {
	String clientId;
	String clientSecret;

	Auth(this.clientId, this.clientSecret);
}

/// user github account
class Account {
	String email;
	String password;

	Account(this.email, this.password);
}
