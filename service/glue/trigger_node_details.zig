const Trigger = @import("trigger.zig").Trigger;

/// The details of a Trigger node present in the workflow.
pub const TriggerNodeDetails = struct {
    /// The information of the trigger represented by the trigger node.
    trigger: ?Trigger = null,

    pub const json_field_names = .{
        .trigger = "Trigger",
    };
};
