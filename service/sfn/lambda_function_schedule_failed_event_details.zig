/// Contains details about a failed Lambda function schedule event that occurred
/// during an
/// execution.
pub const LambdaFunctionScheduleFailedEventDetails = struct {
    /// A more detailed explanation of the cause of the failure.
    cause: ?[]const u8,

    /// The error code of the failure.
    @"error": ?[]const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
    };
};
