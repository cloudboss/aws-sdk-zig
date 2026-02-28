const Action = @import("action.zig").Action;
const EventBatchingCondition = @import("event_batching_condition.zig").EventBatchingCondition;
const Predicate = @import("predicate.zig").Predicate;
const TriggerState = @import("trigger_state.zig").TriggerState;
const TriggerType = @import("trigger_type.zig").TriggerType;

/// Information about a specific trigger.
pub const Trigger = struct {
    /// The actions initiated by this trigger.
    actions: ?[]const Action,

    /// A description of this trigger.
    description: ?[]const u8,

    /// Batch condition that must be met (specified number of events received or
    /// batch time window expired)
    /// before EventBridge event trigger fires.
    event_batching_condition: ?EventBatchingCondition,

    /// Reserved for future use.
    id: ?[]const u8,

    /// The name of the trigger.
    name: ?[]const u8,

    /// The predicate of this trigger, which defines when it will fire.
    predicate: ?Predicate,

    /// A `cron` expression used to specify the schedule (see [Time-Based
    /// Schedules for Jobs and
    /// Crawlers](https://docs.aws.amazon.com/glue/latest/dg/monitor-data-warehouse-schedule.html). For example, to run
    /// something every day at 12:15 UTC, you would specify:
    /// `cron(15 12 * * ? *)`.
    schedule: ?[]const u8,

    /// The current state of the trigger.
    state: ?TriggerState,

    /// The type of trigger that this is.
    @"type": ?TriggerType,

    /// The name of the workflow associated with the trigger.
    workflow_name: ?[]const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .description = "Description",
        .event_batching_condition = "EventBatchingCondition",
        .id = "Id",
        .name = "Name",
        .predicate = "Predicate",
        .schedule = "Schedule",
        .state = "State",
        .@"type" = "Type",
        .workflow_name = "WorkflowName",
    };
};
