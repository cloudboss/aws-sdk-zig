const PreTokenGenerationLambdaVersionType = @import("pre_token_generation_lambda_version_type.zig").PreTokenGenerationLambdaVersionType;

/// The properties of a pre token generation Lambda trigger.
pub const PreTokenGenerationVersionConfigType = struct {
    /// The Amazon Resource Name (ARN) of the function that you want to assign to
    /// your Lambda trigger.
    ///
    /// This parameter and the `PreTokenGeneration` property of
    /// `LambdaConfig` have the same value. For new instances of pre token
    /// generation triggers, set `LambdaArn`.
    lambda_arn: []const u8,

    /// The user pool trigger version of the request that Amazon Cognito sends to
    /// your Lambda function. Higher-numbered versions add fields that support new
    /// features.
    lambda_version: PreTokenGenerationLambdaVersionType,

    pub const json_field_names = .{
        .lambda_arn = "LambdaArn",
        .lambda_version = "LambdaVersion",
    };
};
