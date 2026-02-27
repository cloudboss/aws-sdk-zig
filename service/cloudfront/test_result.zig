const FunctionSummary = @import("function_summary.zig").FunctionSummary;

/// Contains the result of testing a CloudFront function with `TestFunction`.
pub const TestResult = struct {
    /// The amount of time that the function took to run as a percentage of the
    /// maximum allowed time. For example, a compute utilization of 35 means that
    /// the function completed in 35% of the maximum allowed time.
    compute_utilization: ?[]const u8,

    /// If the result of testing the function was an error, this field contains the
    /// error message.
    function_error_message: ?[]const u8,

    /// Contains the log lines that the function wrote (if any) when running the
    /// test.
    function_execution_logs: ?[]const []const u8,

    /// The event object returned by the function. For more information about the
    /// structure of the event object, see [Event object
    /// structure](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/functions-event-structure.html) in the *Amazon CloudFront Developer Guide*.
    function_output: ?[]const u8,

    /// Contains configuration information and metadata about the CloudFront
    /// function that was tested.
    function_summary: ?FunctionSummary,
};
