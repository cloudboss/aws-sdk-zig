/// Contains details about the execution timeout that occurred during the
/// execution.
pub const ExecutionTimedOutEventDetails = struct {
    /// A more detailed explanation of the cause of the timeout.
    cause: ?[]const u8,

    /// The error code of the failure.
    @"error": ?[]const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
    };
};
