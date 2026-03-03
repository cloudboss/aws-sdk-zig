const aws = @import("aws");

const AwsLambdaFunctionEnvironmentError = @import("aws_lambda_function_environment_error.zig").AwsLambdaFunctionEnvironmentError;

/// A function's environment variable settings.
pub const AwsLambdaFunctionEnvironment = struct {
    /// An `AwsLambdaFunctionEnvironmentError` object.
    @"error": ?AwsLambdaFunctionEnvironmentError = null,

    /// Environment variable key-value pairs.
    variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .variables = "Variables",
    };
};
