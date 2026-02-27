const LastUpdateStatusValue = @import("last_update_status_value.zig").LastUpdateStatusValue;

/// A value that indicates whether the update was successful.
pub const LastUpdateStatus = struct {
    /// If the update wasn't successful, indicates the reason why it failed.
    failure_reason: ?[]const u8,

    /// A value that indicates whether the update was made successful.
    status: LastUpdateStatusValue,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .status = "Status",
    };
};
