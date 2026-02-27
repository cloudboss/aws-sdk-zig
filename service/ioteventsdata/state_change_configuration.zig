const TriggerType = @import("trigger_type.zig").TriggerType;

/// Contains the configuration information of alarm state changes.
pub const StateChangeConfiguration = struct {
    /// The trigger type. If the value is `SNOOZE_TIMEOUT`, the snooze duration ends
    /// and the alarm automatically changes to the `NORMAL` state.
    trigger_type: ?TriggerType,

    pub const json_field_names = .{
        .trigger_type = "triggerType",
    };
};
