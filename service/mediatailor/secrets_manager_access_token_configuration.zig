/// AWS Secrets Manager access token configuration parameters. For information
/// about Secrets Manager access token authentication, see [Working with AWS
/// Secrets Manager access token
/// authentication](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-access-configuration-access-token.html).
pub const SecretsManagerAccessTokenConfiguration = struct {
    /// The name of the HTTP header used to supply the access token in requests to
    /// the source location.
    header_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the AWS Secrets Manager secret that
    /// contains the access token.
    secret_arn: ?[]const u8 = null,

    /// The AWS Secrets Manager
    /// [SecretString](https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_CreateSecret.html#SecretsManager-CreateSecret-request-SecretString.html) key associated with the access token. MediaTailor uses the key to look up SecretString key and value pair containing the access token.
    secret_string_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .header_name = "HeaderName",
        .secret_arn = "SecretArn",
        .secret_string_key = "SecretStringKey",
    };
};
