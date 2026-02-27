const InputLambdaProcessorUpdate = @import("input_lambda_processor_update.zig").InputLambdaProcessorUpdate;

/// For a SQL-based Kinesis Data Analytics application, describes updates to an
/// InputProcessingConfiguration.
pub const InputProcessingConfigurationUpdate = struct {
    /// Provides update information for an InputLambdaProcessor.
    input_lambda_processor_update: InputLambdaProcessorUpdate,

    pub const json_field_names = .{
        .input_lambda_processor_update = "InputLambdaProcessorUpdate",
    };
};
