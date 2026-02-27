/// Specifies the authorization configuration for using an Lambda function with
/// your AppSync
/// GraphQL API endpoint.
pub const AwsAppSyncGraphQlApiLambdaAuthorizerConfigDetails = struct {
    /// The number of seconds a response should be cached for. The default is 5
    /// minutes (300 seconds).
    authorizer_result_ttl_in_seconds: ?i32,

    /// The Amazon Resource Name (ARN) of the Lambda function to be called for
    /// authorization. This can be a
    /// standard Lambda ARN, a version ARN (.../v3), or an alias ARN.
    authorizer_uri: ?[]const u8,

    /// A regular expression for validation of tokens before the Lambda function is
    /// called.
    identity_validation_expression: ?[]const u8,

    pub const json_field_names = .{
        .authorizer_result_ttl_in_seconds = "AuthorizerResultTtlInSeconds",
        .authorizer_uri = "AuthorizerUri",
        .identity_validation_expression = "IdentityValidationExpression",
    };
};
