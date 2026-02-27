const InputLambdaProcessorDescription = @import("input_lambda_processor_description.zig").InputLambdaProcessorDescription;

/// For a SQL-based Kinesis Data Analytics application, provides the
/// configuration
/// information about an input processor. Currently, the only input processor
/// available is [Amazon Lambda](https://docs.aws.amazon.com/lambda/).
pub const InputProcessingConfigurationDescription = struct {
    /// Provides configuration information about the associated
    /// InputLambdaProcessorDescription
    input_lambda_processor_description: ?InputLambdaProcessorDescription,

    pub const json_field_names = .{
        .input_lambda_processor_description = "InputLambdaProcessorDescription",
    };
};
