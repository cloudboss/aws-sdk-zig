/// Contains information about an extended key usage X.509 v3 extension object.
pub const AwsCertificateManagerCertificateExtendedKeyUsage = struct {
    /// The name of an extension value. Indicates the purpose for which the
    /// certificate public
    /// key can be used.
    name: ?[]const u8,

    /// An object identifier (OID) for the extension value.
    ///
    /// The format is numbers separated by periods.
    o_id: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .o_id = "OId",
    };
};
