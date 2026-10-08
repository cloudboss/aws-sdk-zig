const SystemEventMetadata = @import("system_event_metadata.zig").SystemEventMetadata;

/// Contains the details of a system event.
pub const SystemEventDetails = struct {
    /// The description of the event.
    description: []const u8,

    event_metadata: ?SystemEventMetadata = null,

    /// The title of the event.
    title: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .event_metadata = "eventMetadata",
        .title = "title",
    };
};
