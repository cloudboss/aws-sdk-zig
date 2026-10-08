const PolicyEventMetadata = @import("policy_event_metadata.zig").PolicyEventMetadata;

/// Contains the title, description, and event-specific metadata for a single
/// event on the timeline of a resilience policy.
pub const PolicyEventDetails = struct {
    /// A description of the event.
    description: []const u8,

    /// The event-specific metadata, with one member populated according to the
    /// event type.
    event_metadata: ?PolicyEventMetadata = null,

    /// A short summary of the event.
    title: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .event_metadata = "eventMetadata",
        .title = "title",
    };
};
