/// Contains information about a key usage X.509 v3 extension object.
pub const AwsCertificateManagerCertificateKeyUsage = struct {
    /// The key usage extension name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
