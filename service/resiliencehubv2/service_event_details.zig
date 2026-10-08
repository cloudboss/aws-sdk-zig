const ServiceEventMetadata = @import("service_event_metadata.zig").ServiceEventMetadata;

/// Contains the details of a service event.
pub const ServiceEventDetails = struct {
    /// The description of the event.
    description: []const u8,

    event_metadata: ?ServiceEventMetadata = null,

    /// The title of the event.
    title: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .event_metadata = "eventMetadata",
        .title = "title",
    };
};
