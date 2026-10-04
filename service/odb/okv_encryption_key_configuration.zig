/// The configuration of the Oracle Key Vault (OKV) encryption key used for an
/// Autonomous Database.
pub const OkvEncryptionKeyConfiguration = struct {
    /// The name of the directory that contains the Oracle Key Vault (OKV)
    /// certificate.
    certificate_directory_name: []const u8,

    /// The identifier of the Oracle Key Vault (OKV) certificate.
    certificate_id: ?[]const u8 = null,

    /// The name of the directory where the Oracle Key Vault (OKV) configuration is
    /// stored.
    directory_name: []const u8,

    /// The identifier of the Oracle Key Vault (OKV) key to use for encryption.
    okv_kms_key: []const u8,

    /// The URI of the Oracle Key Vault (OKV) server.
    okv_uri: []const u8,

    pub const json_field_names = .{
        .certificate_directory_name = "certificateDirectoryName",
        .certificate_id = "certificateId",
        .directory_name = "directoryName",
        .okv_kms_key = "okvKmsKey",
        .okv_uri = "okvUri",
    };
};
