const AsyncInvokeOutputDataConfig = @import("async_invoke_output_data_config.zig").AsyncInvokeOutputDataConfig;
const AsyncInvokeStatus = @import("async_invoke_status.zig").AsyncInvokeStatus;

/// A summary of an asynchronous invocation.
pub const AsyncInvokeSummary = struct {
    /// The invocation's idempotency token.
    client_request_token: ?[]const u8,

    /// When the invocation ended.
    end_time: ?i64,

    /// An error message.
    failure_message: ?[]const u8,

    /// The invocation's ARN.
    invocation_arn: []const u8,

    /// When the invocation was last modified.
    last_modified_time: ?i64,

    /// The invoked model's ARN.
    model_arn: []const u8,

    /// The invocation's output data settings.
    output_data_config: AsyncInvokeOutputDataConfig,

    /// The invocation's status.
    status: ?AsyncInvokeStatus,

    /// When the invocation was submitted.
    submit_time: i64,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .end_time = "endTime",
        .failure_message = "failureMessage",
        .invocation_arn = "invocationArn",
        .last_modified_time = "lastModifiedTime",
        .model_arn = "modelArn",
        .output_data_config = "outputDataConfig",
        .status = "status",
        .submit_time = "submitTime",
    };
};
