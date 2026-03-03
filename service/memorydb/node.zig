const Endpoint = @import("endpoint.zig").Endpoint;

/// Represents an individual node within a cluster. Each node runs its own
/// instance of the cluster's protocol-compliant caching software.
pub const Node = struct {
    /// The Availability Zone in which the node resides
    availability_zone: ?[]const u8 = null,

    /// The date and time when the node was created.
    create_time: ?i64 = null,

    /// The hostname for connecting to this node.
    endpoint: ?Endpoint = null,

    /// The node identifier. A node name is a numeric identifier (0001, 0002, etc.).
    /// The combination of cluster name, shard name and node name uniquely
    /// identifies every node used in a customer's Amazon account.
    name: ?[]const u8 = null,

    /// The status of the service update on the node
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .create_time = "CreateTime",
        .endpoint = "Endpoint",
        .name = "Name",
        .status = "Status",
    };
};
