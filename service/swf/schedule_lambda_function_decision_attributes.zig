/// Decision attributes specified in `scheduleLambdaFunctionDecisionAttributes`
/// within the list of
/// decisions `decisions` passed to RespondDecisionTaskCompleted.
pub const ScheduleLambdaFunctionDecisionAttributes = struct {
    /// The data attached to the event that the decider can use in subsequent
    /// workflow tasks.
    /// This data isn't sent to the Lambda task.
    control: ?[]const u8,

    /// A string that identifies the Lambda function execution in the event history.
    id: []const u8,

    /// The optional input data to be supplied to the Lambda function.
    input: ?[]const u8,

    /// The name, or ARN, of the Lambda function to schedule.
    name: []const u8,

    /// The timeout value, in seconds, after which the Lambda function is considered
    /// to be
    /// failed once it has started. This can be any integer from 1-900 (1s-15m).
    ///
    /// If no value is supplied, then a default value of 900s is assumed.
    start_to_close_timeout: ?[]const u8,

    pub const json_field_names = .{
        .control = "control",
        .id = "id",
        .input = "input",
        .name = "name",
        .start_to_close_timeout = "startToCloseTimeout",
    };
};
