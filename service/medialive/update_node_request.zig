const NodeRole = @import("node_role.zig").NodeRole;
const SdiSourceMappingUpdateRequest = @import("sdi_source_mapping_update_request.zig").SdiSourceMappingUpdateRequest;

/// A request to update the node.
pub const UpdateNodeRequest = struct {
    /// The ID of the cluster
    cluster_id: []const u8,

    /// Include this parameter only if you want to change the current name of the
    /// Node. Specify a name that is unique in the Cluster. You can't change the
    /// name. Names are case-sensitive.
    name: ?[]const u8 = null,

    /// The ID of the node.
    node_id: []const u8,

    /// The initial role of the Node in the Cluster. ACTIVE means the Node is
    /// available for encoding. BACKUP means the Node is a redundant Node and might
    /// get used if an ACTIVE Node fails.
    role: ?NodeRole = null,

    /// The mappings of a SDI capture card port to a logical SDI data stream
    sdi_source_mappings: ?[]const SdiSourceMappingUpdateRequest = null,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .name = "Name",
        .node_id = "NodeId",
        .role = "Role",
        .sdi_source_mappings = "SdiSourceMappings",
    };
};
