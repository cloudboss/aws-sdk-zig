/// Contains the details for an SFTP connector object. The connector object is
/// used for transferring files to and from a partner's SFTP server.
pub const SftpConnectorConfig = struct {
    /// Specify the number of concurrent connections that your connector creates to
    /// the remote server. The default value is `1`. The maximum values is `5`.
    ///
    /// If you are using the Amazon Web Services Management Console, the default
    /// value is `5`.
    ///
    /// This parameter specifies the number of active connections that your
    /// connector can establish with the remote server at the same time. Increasing
    /// this value can enhance connector performance when transferring large file
    /// batches by enabling parallel operations.
    max_concurrent_connections: i32 = 1,

    /// The public portion of the host key, or keys, that are used to identify the
    /// external server to which you are connecting. You can use the `ssh-keyscan`
    /// command against the SFTP server to retrieve the necessary key.
    ///
    /// `TrustedHostKeys` is optional for `CreateConnector`. If not provided, you
    /// can use `TestConnection` to retrieve the server host key during the initial
    /// connection attempt, and subsequently update the connector with the observed
    /// host key.
    ///
    /// When creating connectors with egress config (VPC_LATTICE type connectors),
    /// since host name is not something we can verify, the only accepted trusted
    /// host key format is `key-type key-body` without the host name. For example:
    /// `ssh-rsa AAAAB3Nza...<long-string-for-public-key>`
    ///
    /// The three standard SSH public key format elements are `<key type>`, `<body
    /// base64>`, and an optional `<comment>`, with spaces between each element.
    /// Specify only the `<key type>` and `<body base64>`: do not enter the
    /// `<comment>` portion of the key.
    ///
    /// For the trusted host key, Transfer Family accepts RSA and ECDSA keys.
    ///
    /// * For RSA keys, the `<key type>` string is `ssh-rsa`.
    /// * For ECDSA keys, the `<key type>` string is either `ecdsa-sha2-nistp256`,
    ///   `ecdsa-sha2-nistp384`, or `ecdsa-sha2-nistp521`, depending on the size of
    ///   the key you generated.
    ///
    /// Run this command to retrieve the SFTP server host key, where your SFTP
    /// server name is `ftp.host.com`.
    ///
    /// `ssh-keyscan ftp.host.com`
    ///
    /// This prints the public host key to standard output.
    ///
    /// `ftp.host.com ssh-rsa AAAAB3Nza...<long-string-for-public-key>`
    ///
    /// Copy and paste this string into the `TrustedHostKeys` field for the
    /// `create-connector` command or into the **Trusted host keys** field in the
    /// console.
    ///
    /// For VPC Lattice type connectors (VPC_LATTICE), remove the hostname from the
    /// key and use only the `key-type key-body` format. In this example, it should
    /// be: `ssh-rsa AAAAB3Nza...<long-string-for-public-key>`
    trusted_host_keys: ?[]const []const u8,

    /// The identifier for the secret (in Amazon Web Services Secrets Manager) that
    /// contains the SFTP user's private key, password, or both. The identifier must
    /// be the Amazon Resource Name (ARN) of the secret.
    ///
    /// * Required when creating an SFTP connector
    /// * Optional when updating an existing SFTP connector
    user_secret_id: ?[]const u8,

    pub const json_field_names = .{
        .max_concurrent_connections = "MaxConcurrentConnections",
        .trusted_host_keys = "TrustedHostKeys",
        .user_secret_id = "UserSecretId",
    };
};
