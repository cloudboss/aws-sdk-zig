const InputLambdaProcessor = @import("input_lambda_processor.zig").InputLambdaProcessor;

/// Provides a description of a processor that is used to preprocess the records
/// in the
/// stream before being processed by your application code. Currently, the only
/// input
/// processor available is [AWS
/// Lambda](https://docs.aws.amazon.com/lambda/).
pub const InputProcessingConfiguration = struct {
    /// The
    /// [InputLambdaProcessor](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_InputLambdaProcessor.html) that is used to preprocess the records
    /// in the stream before being processed by your application code.
    input_lambda_processor: InputLambdaProcessor,

    pub const json_field_names = .{
        .input_lambda_processor = "InputLambdaProcessor",
    };
};
