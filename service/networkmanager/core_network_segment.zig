/// Describes a core network segment, which are dedicated routes. Only
/// attachments within this segment can communicate with each other.
pub const CoreNetworkSegment = struct {
    /// The Regions where the edges are located.
    edge_locations: ?[]const []const u8,

    /// The name of a core network segment.
    name: ?[]const u8,

    /// The shared segments of a core network.
    shared_segments: ?[]const []const u8,

    pub const json_field_names = .{
        .edge_locations = "EdgeLocations",
        .name = "Name",
        .shared_segments = "SharedSegments",
    };
};
