/// Specifies the settings required for kerberos authentication when creating
/// the
/// replication instance.
pub const KerberosAuthenticationSettings = struct {
    /// Specifies the Amazon Resource Name (ARN) of the IAM role that grants Amazon
    /// Web Services
    /// DMS access to the secret containing key cache file for the kerberos
    /// authentication.
    key_cache_secret_iam_arn: ?[]const u8 = null,

    /// Specifies the ID of the secret that stores the key cache file required for
    /// kerberos
    /// authentication.
    key_cache_secret_id: ?[]const u8 = null,

    /// Specifies the contents of krb5 configuration file required for kerberos
    /// authentication.
    krb_5_file_contents: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_cache_secret_iam_arn = "KeyCacheSecretIamArn",
        .key_cache_secret_id = "KeyCacheSecretId",
        .krb_5_file_contents = "Krb5FileContents",
    };
};
