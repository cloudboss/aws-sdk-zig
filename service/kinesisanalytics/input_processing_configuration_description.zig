const InputLambdaProcessorDescription = @import("input_lambda_processor_description.zig").InputLambdaProcessorDescription;

/// Provides configuration information about an input processor. Currently, the
/// only input processor available is
/// [AWS Lambda](https://docs.aws.amazon.com/lambda/).
pub const InputProcessingConfigurationDescription = struct {
    /// Provides configuration information about the associated
    /// [InputLambdaProcessorDescription](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_InputLambdaProcessorDescription.html).
    input_lambda_processor_description: ?InputLambdaProcessorDescription,

    pub const json_field_names = .{
        .input_lambda_processor_description = "InputLambdaProcessorDescription",
    };
};
