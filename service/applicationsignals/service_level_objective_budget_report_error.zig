/// A structure containing information about one error that occurred during a
/// [BatchGetServiceLevelObjectiveBudgetReport](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_BatchGetServiceLevelObjectiveBudgetReport.html) operation.
pub const ServiceLevelObjectiveBudgetReportError = struct {
    /// The ARN of the SLO that this error is related to.
    arn: []const u8,

    /// The error code for this error.
    error_code: []const u8,

    /// The message for this error.
    error_message: []const u8,

    /// The name of the SLO that this error is related to.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .name = "Name",
    };
};
