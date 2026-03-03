/// A `LambdaAuthorizerConfig` specifies how to authorize AppSync
/// API access when using the `AWS_LAMBDA` authorizer mode. Be aware that an
/// AppSync API can have only one Lambda authorizer configured at a
/// time.
pub const LambdaAuthorizerConfig = struct {
    /// The number of seconds a response should be cached for. The default is 0
    /// seconds, which
    /// disables caching. If you don't specify a value for
    /// `authorizerResultTtlInSeconds`, the default value is used. The maximum value
    /// is one hour (3600 seconds). The Lambda function can override this by
    /// returning
    /// a `ttlOverride` key in its response.
    authorizer_result_ttl_in_seconds: i32 = 0,

    /// The Amazon Resource Name (ARN) of the Lambda function to be called for
    /// authorization. This can be a standard Lambda ARN, a version ARN
    /// (`.../v3`), or an alias ARN.
    ///
    /// **Note**: This Lambda function must have the
    /// following resource-based policy assigned to it. When configuring Lambda
    /// authorizers in the console, this is done for you. To use the Command Line
    /// Interface
    /// (CLI), run the following:
    ///
    /// `aws lambda add-permission --function-name
    /// "arn:aws:lambda:us-east-2:111122223333:function:my-function" --statement-id
    /// "appsync"
    /// --principal appsync.amazonaws.com --action lambda:InvokeFunction`
    authorizer_uri: []const u8,

    /// A regular expression for validation of tokens before the Lambda function is
    /// called.
    identity_validation_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorizer_result_ttl_in_seconds = "authorizerResultTtlInSeconds",
        .authorizer_uri = "authorizerUri",
        .identity_validation_expression = "identityValidationExpression",
    };
};
