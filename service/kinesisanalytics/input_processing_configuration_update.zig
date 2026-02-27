const InputLambdaProcessorUpdate = @import("input_lambda_processor_update.zig").InputLambdaProcessorUpdate;

/// Describes updates to an
/// [InputProcessingConfiguration](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_InputProcessingConfiguration.html).
pub const InputProcessingConfigurationUpdate = struct {
    /// Provides update information for an
    /// [InputLambdaProcessor](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_InputLambdaProcessor.html).
    input_lambda_processor_update: InputLambdaProcessorUpdate,

    pub const json_field_names = .{
        .input_lambda_processor_update = "InputLambdaProcessorUpdate",
    };
};
