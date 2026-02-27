const EventStatus = @import("event_status.zig").EventStatus;

/// A summary of the deployment event data.
pub const DeploymentEventDataSummary = struct {
    /// The description of the deployment event.
    description: ?[]const u8,

    /// The name of the deployment event.
    name: ?[]const u8,

    /// The status of the deployment event.
    status: ?EventStatus,

    /// The reason of the deployment event status.
    status_reason: ?[]const u8,

    /// The timestamp of the deployment event.
    timestamp: ?i64,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .status = "status",
        .status_reason = "statusReason",
        .timestamp = "timestamp",
    };
};
