const TriggerProperties = @import("trigger_properties.zig").TriggerProperties;
const TriggerType = @import("trigger_type.zig").TriggerType;

/// The trigger settings that determine how and when Amazon AppFlow runs the
/// specified
/// flow.
pub const TriggerConfig = struct {
    /// Specifies the configuration details of a schedule-triggered flow that you
    /// define.
    /// Currently, these settings only apply to the Scheduled trigger type.
    trigger_properties: ?TriggerProperties,

    /// Specifies the type of flow trigger. It can be OnDemand, Scheduled, or Event.
    trigger_type: TriggerType,

    pub const json_field_names = .{
        .trigger_properties = "TriggerProperties",
        .trigger_type = "TriggerType",
    };
};
