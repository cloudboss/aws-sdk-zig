const LastUpdateStatus = @import("last_update_status.zig").LastUpdateStatus;

/// Configuration object that contains the most recent account settings update,
/// visible only if settings have been updated previously.
pub const LastUpdate = struct {
    /// The status of the last update. Can be either `PENDING`, `FAILED`, or
    /// `SUCCEEDED`.
    status: ?LastUpdateStatus = null,

    /// Error message describing the last account settings update status, visible
    /// only if an error occurred.
    status_message: ?[]const u8 = null,

    /// The number of TimeStream Compute Units (TCUs) requested in the last account
    /// settings update.
    target_query_tcu: ?i32 = null,

    pub const json_field_names = .{
        .status = "Status",
        .status_message = "StatusMessage",
        .target_query_tcu = "TargetQueryTCU",
    };
};
