const SendingStatus = @import("sending_status.zig").SendingStatus;

/// An object that contains status information for a reputation entity,
/// including
/// the current status, cause description, and timestamp.
pub const StatusRecord = struct {
    /// A description of the reason for the current status, or null if no specific
    /// cause is available.
    cause: ?[]const u8 = null,

    /// The timestamp when this status was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The current sending status. This can be one of the following:
    ///
    /// * `ENABLED` – Sending is allowed.
    ///
    /// * `DISABLED` – Sending is prevented.
    ///
    /// * `REINSTATED` – Sending is allowed even with active reputation findings.
    status: ?SendingStatus = null,

    pub const json_field_names = .{
        .cause = "Cause",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .status = "Status",
    };
};
