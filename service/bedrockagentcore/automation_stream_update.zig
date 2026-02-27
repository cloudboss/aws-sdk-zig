const AutomationStreamStatus = @import("automation_stream_status.zig").AutomationStreamStatus;

/// Contains information about an update to an automation stream.
pub const AutomationStreamUpdate = struct {
    /// The status of the automation stream.
    stream_status: ?AutomationStreamStatus,

    pub const json_field_names = .{
        .stream_status = "streamStatus",
    };
};
