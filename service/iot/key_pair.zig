/// Describes a key pair.
pub const KeyPair = struct {
    /// The private key.
    private_key: ?[]const u8 = null,

    /// The public key.
    public_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .private_key = "PrivateKey",
        .public_key = "PublicKey",
    };
};
