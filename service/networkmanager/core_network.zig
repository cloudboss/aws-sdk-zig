const CoreNetworkEdge = @import("core_network_edge.zig").CoreNetworkEdge;
const CoreNetworkNetworkFunctionGroup = @import("core_network_network_function_group.zig").CoreNetworkNetworkFunctionGroup;
const CoreNetworkSegment = @import("core_network_segment.zig").CoreNetworkSegment;
const CoreNetworkState = @import("core_network_state.zig").CoreNetworkState;
const Tag = @import("tag.zig").Tag;

/// Describes a core network.
pub const CoreNetwork = struct {
    /// The ARN of a core network.
    core_network_arn: ?[]const u8,

    /// The ID of a core network.
    core_network_id: ?[]const u8,

    /// The timestamp when a core network was created.
    created_at: ?i64,

    /// The description of a core network.
    description: ?[]const u8,

    /// The edges within a core network.
    edges: ?[]const CoreNetworkEdge,

    /// The ID of the global network that your core network is a part of.
    global_network_id: ?[]const u8,

    /// The network function groups associated with a core network.
    network_function_groups: ?[]const CoreNetworkNetworkFunctionGroup,

    /// The segments within a core network.
    segments: ?[]const CoreNetworkSegment,

    /// The current state of a core network.
    state: ?CoreNetworkState,

    /// The list of key-value tags associated with a core network.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .core_network_arn = "CoreNetworkArn",
        .core_network_id = "CoreNetworkId",
        .created_at = "CreatedAt",
        .description = "Description",
        .edges = "Edges",
        .global_network_id = "GlobalNetworkId",
        .network_function_groups = "NetworkFunctionGroups",
        .segments = "Segments",
        .state = "State",
        .tags = "Tags",
    };
};
