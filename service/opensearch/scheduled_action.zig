const ScheduledBy = @import("scheduled_by.zig").ScheduledBy;
const ActionSeverity = @import("action_severity.zig").ActionSeverity;
const ActionStatus = @import("action_status.zig").ActionStatus;
const ActionType = @import("action_type.zig").ActionType;

/// Information about a scheduled configuration change for an OpenSearch Service
/// domain.
/// This actions can be a [service
/// software
/// update](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/service-software.html) or a [blue/green Auto-Tune enhancement](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html#auto-tune-types).
pub const ScheduledAction = struct {
    /// Whether or not the scheduled action is cancellable.
    cancellable: ?bool,

    /// A description of the action to be taken.
    description: ?[]const u8,

    /// The unique identifier of the scheduled action.
    id: []const u8,

    /// Whether the action is required or optional.
    mandatory: ?bool,

    /// Whether the action was scheduled manually (`CUSTOMER`, or by OpenSearch
    /// Service automatically (`SYSTEM`).
    scheduled_by: ?ScheduledBy,

    /// The time when the change is scheduled to happen.
    scheduled_time: i64,

    /// The severity of the action.
    severity: ActionSeverity,

    /// The current status of the scheduled action.
    status: ?ActionStatus,

    /// The type of action that will be taken on the domain.
    @"type": ActionType,

    pub const json_field_names = .{
        .cancellable = "Cancellable",
        .description = "Description",
        .id = "Id",
        .mandatory = "Mandatory",
        .scheduled_by = "ScheduledBy",
        .scheduled_time = "ScheduledTime",
        .severity = "Severity",
        .status = "Status",
        .@"type" = "Type",
    };
};
