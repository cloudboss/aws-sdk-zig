const CredentialPair = @import("credential_pair.zig").CredentialPair;
const KeyPairCredentials = @import("key_pair_credentials.zig").KeyPairCredentials;
const WebProxyCredentials = @import("web_proxy_credentials.zig").WebProxyCredentials;

/// Data source credentials. This is a variant type structure. For this
/// structure to be
/// valid, only one of the attributes can be non-null.
pub const DataSourceCredentials = struct {
    /// The Amazon Resource Name (ARN) of a data source that has the credential pair
    /// that you
    /// want to use. When `CopySourceArn` is not null, the credential pair from the
    /// data source in the ARN is used as the credentials for the
    /// `DataSourceCredentials` structure.
    copy_source_arn: ?[]const u8,

    /// Credential pair. For more information, see
    /// `
    /// [CredentialPair](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_CredentialPair.html)
    /// `.
    credential_pair: ?CredentialPair,

    /// The credentials for connecting using key-pair.
    key_pair_credentials: ?KeyPairCredentials,

    /// The Amazon Resource Name (ARN) of the secret associated with the data source
    /// in Amazon Secrets Manager.
    secret_arn: ?[]const u8,

    /// The credentials for connecting through a web proxy server.
    web_proxy_credentials: ?WebProxyCredentials,

    pub const json_field_names = .{
        .copy_source_arn = "CopySourceArn",
        .credential_pair = "CredentialPair",
        .key_pair_credentials = "KeyPairCredentials",
        .secret_arn = "SecretArn",
        .web_proxy_credentials = "WebProxyCredentials",
    };
};
