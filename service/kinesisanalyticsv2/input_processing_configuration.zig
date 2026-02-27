const InputLambdaProcessor = @import("input_lambda_processor.zig").InputLambdaProcessor;

/// For a SQL-based Kinesis Data Analytics application, describes a processor
/// that is
/// used to preprocess the records in the stream before being processed by your
/// application code.
/// Currently, the only input processor available is [Amazon
/// Lambda](https://docs.aws.amazon.com/lambda/).
pub const InputProcessingConfiguration = struct {
    /// The InputLambdaProcessor that is used to preprocess the records
    /// in the stream before being processed by your application code.
    input_lambda_processor: InputLambdaProcessor,

    pub const json_field_names = .{
        .input_lambda_processor = "InputLambdaProcessor",
    };
};
