component {

// CONSTRUCTOR
	public any function init( required string keystoreFile, required string keystorePassword ) {
		_setKeystoreFile( arguments.keystoreFile );
		_setKeystorePassword( arguments.keystorePassword );

		return this;
	}

// PUBLIC API METHODS
	public any function getKeyStore() {
		var ksfile      = CreateObject( "java", "java.io.File").init( _getKeystoreFile() );
		var inputStream = CreateObject( "java", "java.io.FileInputStream").init( ksfile );
		var keystore    = CreateObject( "java", "java.security.KeyStore" ).getInstance( "JKS" ); // JKS is the keystore type - may be variable

		keystore.load( inputStream, _getKeyStorePassword() );

		return keystore;
	}

	public string function getPrivateKey( required string certificateAlias, required string keyPassword ) {
		return getKeyStore().getKey( arguments.certificateAlias, arguments.keyPassword.toCharArray() );
	}

	public string function getCert( required string certificateAlias ) {
		return getKeyStore().getCertificate( arguments.certificateAlias );
	}

	public string function getPublicKey( required string certificateAlias ) {
		return getCert( arguments.certificateAlias ).getPublicKey();
	}


// GETTERS AND SETTERS
	private string function _getKeystoreFile() {
		return _keystoreFile;
	}
	private void function _setKeystoreFile( required string keystoreFile ) {
		_keystoreFile = arguments.keystoreFile;
	}

	private string function _getKeyStorePassword() {
		return _keyStorePassword;
	}
	private void function _setKeyStorePassword( required string keyStorePassword ) {
		_keyStorePassword = arguments.keyStorePassword.toCharArray();
	}
}