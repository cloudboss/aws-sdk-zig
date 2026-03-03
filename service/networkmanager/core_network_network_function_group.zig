const ServiceInsertionSegments = @import("service_insertion_segments.zig").ServiceInsertionSegments;

/// Describes a network function group.
pub const CoreNetworkNetworkFunctionGroup = struct {
    /// The core network edge locations.
    edge_locations: ?[]const []const u8 = null,

    /// The name of the network function group.
    name: ?[]const u8 = null,

    /// The segments associated with the network function group.
    segments: ?ServiceInsertionSegments = null,

    pub const json_field_names = .{
        .edge_locations = "EdgeLocations",
        .name = "Name",
        .segments = "Segments",
    };
};
