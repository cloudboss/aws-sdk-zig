const MediaResourceNeighbor = @import("media_resource_neighbor.zig").MediaResourceNeighbor;

/// An AWS resource used in media workflows.
pub const MediaResource = struct {
    destinations: ?[]const MediaResourceNeighbor,

    /// The logical name of an AWS media resource.
    name: ?[]const u8,

    sources: ?[]const MediaResourceNeighbor,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .name = "Name",
        .sources = "Sources",
    };
};
