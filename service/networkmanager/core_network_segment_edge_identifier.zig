/// Returns details about a core network edge.
pub const CoreNetworkSegmentEdgeIdentifier = struct {
    /// The ID of a core network.
    core_network_id: ?[]const u8 = null,

    /// The Region where the segment edge is located.
    edge_location: ?[]const u8 = null,

    /// The name of the segment edge.
    segment_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .core_network_id = "CoreNetworkId",
        .edge_location = "EdgeLocation",
        .segment_name = "SegmentName",
    };
};
