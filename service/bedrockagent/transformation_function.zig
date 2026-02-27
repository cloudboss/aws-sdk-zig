const TransformationLambdaConfiguration = @import("transformation_lambda_configuration.zig").TransformationLambdaConfiguration;

/// A Lambda function that processes documents.
pub const TransformationFunction = struct {
    /// The Lambda function.
    transformation_lambda_configuration: TransformationLambdaConfiguration,

    pub const json_field_names = .{
        .transformation_lambda_configuration = "transformationLambdaConfiguration",
    };
};
