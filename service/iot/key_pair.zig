/// Describes a key pair.
pub const KeyPair = struct {
    /// The private key.
    private_key: ?[]const u8,

    /// The public key.
    public_key: ?[]const u8,

    pub const json_field_names = .{
        .private_key = "PrivateKey",
        .public_key = "PublicKey",
    };
};
