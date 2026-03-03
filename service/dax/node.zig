const Endpoint = @import("endpoint.zig").Endpoint;

/// Represents an individual node within a DAX cluster.
pub const Node = struct {
    /// The Availability Zone (AZ) in which the node has been deployed.
    availability_zone: ?[]const u8 = null,

    /// The endpoint for the node, consisting of a DNS name and a port number.
    /// Client
    /// applications can connect directly to a node endpoint, if desired (as an
    /// alternative to
    /// allowing DAX client software to intelligently route requests and
    /// responses to nodes in the DAX cluster.
    endpoint: ?Endpoint = null,

    /// The date and time (in UNIX epoch format) when the node was launched.
    node_create_time: ?i64 = null,

    /// A system-generated identifier for the node.
    node_id: ?[]const u8 = null,

    /// The current status of the node. For example: `available`.
    node_status: ?[]const u8 = null,

    /// The status of the parameter group associated with this node. For example,
    /// `in-sync`.
    parameter_group_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .endpoint = "Endpoint",
        .node_create_time = "NodeCreateTime",
        .node_id = "NodeId",
        .node_status = "NodeStatus",
        .parameter_group_status = "ParameterGroupStatus",
    };
};
