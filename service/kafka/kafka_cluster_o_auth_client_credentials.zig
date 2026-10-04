/// Details for SASL/OAUTHBEARER using standard client_credentials grant.
pub const KafkaClusterOAuthClientCredentials = struct {
    /// The Amazon Resource Name (ARN) of the Secrets Manager secret containing the
    /// OAuth client credentials.
    token_request_secret_arn: []const u8,

    pub const json_field_names = .{
        .token_request_secret_arn = "TokenRequestSecretArn",
    };
};
