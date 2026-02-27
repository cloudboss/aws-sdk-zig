/// Details about the issuer of a license.
pub const Issuer = struct {
    /// Issuer name.
    name: []const u8,

    /// Asymmetric KMS key from Key Management Service. The KMS key must have a key
    /// usage of sign and verify,
    /// and support the RSASSA-PSS SHA-256 signing algorithm.
    sign_key: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .sign_key = "SignKey",
    };
};
