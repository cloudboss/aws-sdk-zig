const aws = @import("aws");

const NodeInterfaceMappingCreateRequest = @import("node_interface_mapping_create_request.zig").NodeInterfaceMappingCreateRequest;
const NodeRole = @import("node_role.zig").NodeRole;

/// A request to create a node
pub const CreateNodeRequest = struct {
    /// The ID of the cluster.
    cluster_id: []const u8,

    /// The user-specified name of the Node to be created.
    name: ?[]const u8,

    /// Documentation update needed
    node_interface_mappings: ?[]const NodeInterfaceMappingCreateRequest,

    /// An ID that you assign to a create request. This ID ensures idempotency when
    /// creating resources.
    request_id: ?[]const u8,

    /// The initial role of the Node in the Cluster. ACTIVE means the Node is
    /// available for encoding. BACKUP means the Node is a redundant Node and might
    /// get used if an ACTIVE Node fails.
    role: ?NodeRole,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .name = "Name",
        .node_interface_mappings = "NodeInterfaceMappings",
        .request_id = "RequestId",
        .role = "Role",
        .tags = "Tags",
    };
};
