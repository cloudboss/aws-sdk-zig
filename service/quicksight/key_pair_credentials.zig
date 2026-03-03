/// The combination of username, private key and passphrase that are used as
/// credentials.
pub const KeyPairCredentials = struct {
    /// Username
    key_pair_username: []const u8,

    /// PrivateKey
    private_key: []const u8,

    /// PrivateKeyPassphrase
    private_key_passphrase: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_pair_username = "KeyPairUsername",
        .private_key = "PrivateKey",
        .private_key_passphrase = "PrivateKeyPassphrase",
    };
};
