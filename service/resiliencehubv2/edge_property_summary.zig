const TopologyType = @import("topology_type.zig").TopologyType;

/// Contains property information for a service topology edge.
pub const EdgePropertySummary = struct {
    /// Human-readable relationship description. Only present for LLM-inferred
    /// edges.
    label: ?[]const u8 = null,

    /// The topology type of the edge.
    topology_type: ?TopologyType = null,

    pub const json_field_names = .{
        .label = "label",
        .topology_type = "topologyType",
    };
};
