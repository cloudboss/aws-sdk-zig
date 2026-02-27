const OutputParameter = @import("output_parameter.zig").OutputParameter;

/// Metadata for a Lambda step.
pub const LambdaStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function that was run by this
    /// step execution.
    arn: ?[]const u8,

    /// A list of the output parameters of the Lambda step.
    output_parameters: ?[]const OutputParameter,

    pub const json_field_names = .{
        .arn = "Arn",
        .output_parameters = "OutputParameters",
    };
};
