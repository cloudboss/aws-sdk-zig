/// Contains details about an abort of an execution.
pub const ExecutionAbortedEventDetails = struct {
    /// A more detailed explanation of the cause of the failure.
    cause: ?[]const u8,

    /// The error code of the failure.
    @"error": ?[]const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
    };
};
