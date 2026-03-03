/// The configuration parameters to enable access to the key store required by
/// the
/// package.
pub const KeyStoreAccessOption = struct {
    /// Role ARN to access the KeyStore Key
    key_access_role_arn: ?[]const u8 = null,

    /// This indicates whether Key Store access is enabled
    key_store_access_enabled: bool,

    pub const json_field_names = .{
        .key_access_role_arn = "KeyAccessRoleArn",
        .key_store_access_enabled = "KeyStoreAccessEnabled",
    };
};
