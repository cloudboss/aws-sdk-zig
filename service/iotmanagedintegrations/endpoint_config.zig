const LambdaConfig = @import("lambda_config.zig").LambdaConfig;

/// The configuration details for an endpoint, which defines how to connect to
/// and communicate with external services.
pub const EndpointConfig = struct {
    /// The Lambda function configuration for the endpoint, used when the endpoint
    /// communicates through an AWS Lambda function.
    lambda: ?LambdaConfig,

    pub const json_field_names = .{
        .lambda = "lambda",
    };
};
