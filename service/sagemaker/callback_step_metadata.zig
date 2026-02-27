const OutputParameter = @import("output_parameter.zig").OutputParameter;

/// Metadata about a callback step.
pub const CallbackStepMetadata = struct {
    /// The pipeline generated token from the Amazon SQS queue.
    callback_token: ?[]const u8,

    /// A list of the output parameters of the callback step.
    output_parameters: ?[]const OutputParameter,

    /// The URL of the Amazon Simple Queue Service (Amazon SQS) queue used by the
    /// callback step.
    sqs_queue_url: ?[]const u8,

    pub const json_field_names = .{
        .callback_token = "CallbackToken",
        .output_parameters = "OutputParameters",
        .sqs_queue_url = "SqsQueueUrl",
    };
};
