const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Information about a [durable
/// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html).
pub const Execution = struct {
    /// The Amazon Resource Name (ARN) of the durable execution, if this execution
    /// is a durable execution.
    durable_execution_arn: []const u8,

    /// The unique name of the durable execution, if one was provided when the
    /// execution was started.
    durable_execution_name: []const u8,

    /// The date and time when the durable execution ended, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    end_timestamp: ?i64,

    /// The Amazon Resource Name (ARN) of the Lambda function.
    function_arn: []const u8,

    /// The date and time when the durable execution started, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    start_timestamp: i64,

    /// The current status of the durable execution.
    status: ExecutionStatus,
};
