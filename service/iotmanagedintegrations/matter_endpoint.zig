const MatterCluster = @import("matter_cluster.zig").MatterCluster;

/// Structure describing a managed thing.
pub const MatterEndpoint = struct {
    /// A list of Matter clusters for a managed thing.
    clusters: ?[]const MatterCluster,

    /// The Matter endpoint id.
    id: ?[]const u8,

    pub const json_field_names = .{
        .clusters = "clusters",
        .id = "id",
    };
};
