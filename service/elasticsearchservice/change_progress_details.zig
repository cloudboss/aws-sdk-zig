const ConfigChangeStatus = @import("config_change_status.zig").ConfigChangeStatus;
const InitiatedBy = @import("initiated_by.zig").InitiatedBy;

/// Specifies change details of the domain configuration change.
pub const ChangeProgressDetails = struct {
    /// The unique change identifier associated with a specific domain configuration
    /// change.
    change_id: ?[]const u8 = null,

    /// The current status of the configuration change.
    config_change_status: ?ConfigChangeStatus = null,

    /// The IAM principal who initiated the configuration change.
    initiated_by: ?InitiatedBy = null,

    /// The last time that the configuration change was updated.
    last_updated_time: ?i64 = null,

    /// Contains an optional message associated with the domain configuration
    /// change.
    message: ?[]const u8 = null,

    /// The time that the configuration change was initiated, in Universal
    /// Coordinated Time (UTC).
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .change_id = "ChangeId",
        .config_change_status = "ConfigChangeStatus",
        .initiated_by = "InitiatedBy",
        .last_updated_time = "LastUpdatedTime",
        .message = "Message",
        .start_time = "StartTime",
    };
};
