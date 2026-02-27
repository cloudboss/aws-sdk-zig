/// Contains details about an activity timeout that occurred during an
/// execution.
pub const ActivityTimedOutEventDetails = struct {
    /// A more detailed explanation of the cause of the timeout.
    cause: ?[]const u8,

    /// The error code of the failure.
    @"error": ?[]const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
    };
};
