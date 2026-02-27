const AutomationStreamUpdate = @import("automation_stream_update.zig").AutomationStreamUpdate;

/// Contains information about an update to a stream.
pub const StreamUpdate = union(enum) {
    /// The update to an automation stream.
    automation_stream_update: ?AutomationStreamUpdate,

    pub const json_field_names = .{
        .automation_stream_update = "automationStreamUpdate",
    };
};
