const ConfigChangeStatus = @import("config_change_status.zig").ConfigChangeStatus;
const InitiatedBy = @import("initiated_by.zig").InitiatedBy;

/// Container for information about a configuration change happening on a
/// domain.
pub const ChangeProgressDetails = struct {
    /// The ID of the configuration change.
    change_id: ?[]const u8,

    /// The current status of the configuration change.
    config_change_status: ?ConfigChangeStatus,

    /// The IAM principal who initiated the configuration change.
    initiated_by: ?InitiatedBy,

    /// The last time that the configuration change was updated.
    last_updated_time: ?i64,

    /// A message corresponding to the status of the configuration change.
    message: ?[]const u8,

    /// The time that the configuration change was initiated, in Universal
    /// Coordinated Time
    /// (UTC).
    start_time: ?i64,

    pub const json_field_names = .{
        .change_id = "ChangeId",
        .config_change_status = "ConfigChangeStatus",
        .initiated_by = "InitiatedBy",
        .last_updated_time = "LastUpdatedTime",
        .message = "Message",
        .start_time = "StartTime",
    };
};
