const ScheduledTriggerProperties = @import("scheduled_trigger_properties.zig").ScheduledTriggerProperties;

/// Specifies the configuration details that control the trigger for a flow.
/// Currently, these
/// settings only apply to the `Scheduled` trigger type.
pub const TriggerProperties = struct {
    /// Specifies the configuration details of a schedule-triggered flow as defined
    /// by the user.
    scheduled: ?ScheduledTriggerProperties = null,

    pub const json_field_names = .{
        .scheduled = "Scheduled",
    };
};
