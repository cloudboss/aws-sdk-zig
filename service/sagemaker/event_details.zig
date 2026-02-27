const EventMetadata = @import("event_metadata.zig").EventMetadata;

/// Detailed information about a specific event, including event metadata.
pub const EventDetails = struct {
    /// Metadata specific to the event, which may include information about the
    /// cluster, instance group, or instance involved.
    event_metadata: ?EventMetadata,

    pub const json_field_names = .{
        .event_metadata = "EventMetadata",
    };
};
