const Action = @import("action.zig").Action;
const EventBatchingCondition = @import("event_batching_condition.zig").EventBatchingCondition;
const Predicate = @import("predicate.zig").Predicate;

/// A structure used to provide information used to update a trigger. This
/// object updates the
/// previous trigger definition by overwriting it completely.
pub const TriggerUpdate = struct {
    /// The actions initiated by this trigger.
    actions: ?[]const Action = null,

    /// A description of this trigger.
    description: ?[]const u8 = null,

    /// Batch condition that must be met (specified number of events received or
    /// batch time window expired)
    /// before EventBridge event trigger fires.
    event_batching_condition: ?EventBatchingCondition = null,

    /// Reserved for future use.
    name: ?[]const u8 = null,

    /// The predicate of this trigger, which defines when it will fire.
    predicate: ?Predicate = null,

    /// A `cron` expression used to specify the schedule (see [Time-Based
    /// Schedules for Jobs and
    /// Crawlers](https://docs.aws.amazon.com/glue/latest/dg/monitor-data-warehouse-schedule.html). For example, to run
    /// something every day at 12:15 UTC, you would specify:
    /// `cron(15 12 * * ? *)`.
    schedule: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .description = "Description",
        .event_batching_condition = "EventBatchingCondition",
        .name = "Name",
        .predicate = "Predicate",
        .schedule = "Schedule",
    };
};
