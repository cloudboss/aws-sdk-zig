const LambdaTransformConfiguration = @import("lambda_transform_configuration.zig").LambdaTransformConfiguration;

/// The configuration for custom transformations applied to requests and
/// responses through the gateway. This structure defines how the gateway
/// transforms data.
pub const CustomTransformConfiguration = struct {
    /// The Lambda configuration for custom transformations. This configuration
    /// defines how the gateway uses a Lambda function to transform data.
    lambda: ?LambdaTransformConfiguration = null,

    pub const json_field_names = .{
        .lambda = "lambda",
    };
};
