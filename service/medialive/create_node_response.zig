const NodeConnectionState = @import("node_connection_state.zig").NodeConnectionState;
const NodeInterfaceMapping = @import("node_interface_mapping.zig").NodeInterfaceMapping;
const NodeRole = @import("node_role.zig").NodeRole;
const SdiSourceMapping = @import("sdi_source_mapping.zig").SdiSourceMapping;
const NodeState = @import("node_state.zig").NodeState;

/// Placeholder documentation for CreateNodeResponse
pub const CreateNodeResponse = struct {
    /// The ARN of the Node. It is automatically assigned when the Node is created.
    arn: ?[]const u8,

    /// An array of IDs. Each ID is one ChannelPlacementGroup that is associated
    /// with this Node. Empty if the Node is not yet associated with any groups.
    channel_placement_groups: ?[]const []const u8,

    /// The ID of the Cluster that the Node belongs to.
    cluster_id: ?[]const u8,

    /// The current connection state of the Node.
    connection_state: ?NodeConnectionState,

    /// The unique ID of the Node. Unique in the Cluster. The ID is the resource-id
    /// portion of the ARN.
    id: ?[]const u8,

    /// The ARN of the EC2 instance hosting the Node.
    instance_arn: ?[]const u8,

    /// The name that you specified for the Node.
    name: ?[]const u8,

    /// Documentation update needed
    node_interface_mappings: ?[]const NodeInterfaceMapping,

    /// The initial role current role of the Node in the Cluster. ACTIVE means the
    /// Node is available for encoding. BACKUP means the Node is a redundant Node
    /// and might get used if an ACTIVE Node fails.
    role: ?NodeRole,

    /// An array of SDI source mappings. Each mapping connects one logical SdiSource
    /// to the physical SDI card and port that the physical SDI source uses.
    sdi_source_mappings: ?[]const SdiSourceMapping,

    /// The current state of the Node.
    state: ?NodeState,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_placement_groups = "ChannelPlacementGroups",
        .cluster_id = "ClusterId",
        .connection_state = "ConnectionState",
        .id = "Id",
        .instance_arn = "InstanceArn",
        .name = "Name",
        .node_interface_mappings = "NodeInterfaceMappings",
        .role = "Role",
        .sdi_source_mappings = "SdiSourceMappings",
        .state = "State",
    };
};
