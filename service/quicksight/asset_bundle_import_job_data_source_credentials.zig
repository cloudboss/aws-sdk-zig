const AssetBundleImportJobDataSourceCredentialPair = @import("asset_bundle_import_job_data_source_credential_pair.zig").AssetBundleImportJobDataSourceCredentialPair;

/// The login credentials to use to import a data source resource.
pub const AssetBundleImportJobDataSourceCredentials = struct {
    /// A username and password credential pair to be used to create the imported
    /// data source.
    /// Keep this field blank if you are using a Secrets Manager secret to provide
    /// credentials.
    credential_pair: ?AssetBundleImportJobDataSourceCredentialPair,

    /// The ARN of the Secrets Manager secret that's used to create the imported
    /// data source.
    /// Keep this field blank, unless you are using a secret in place of a
    /// credential pair.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .credential_pair = "CredentialPair",
        .secret_arn = "SecretArn",
    };
};
