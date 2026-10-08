const EventChannelType = @import("event_channel_type.zig").EventChannelType;

/// Service details for Event Channel integration.
pub const EventChannelDetails = struct {
    /// The type of event channel
    type: ?EventChannelType = null,

    pub const json_field_names = .{
        .type = "type",
    };
};
