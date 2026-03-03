const Endpoint = @import("endpoint.zig").Endpoint;
const ClusterEndpointEncryptionType = @import("cluster_endpoint_encryption_type.zig").ClusterEndpointEncryptionType;
const NetworkType = @import("network_type.zig").NetworkType;
const Node = @import("node.zig").Node;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const ParameterGroupStatus = @import("parameter_group_status.zig").ParameterGroupStatus;
const SecurityGroupMembership = @import("security_group_membership.zig").SecurityGroupMembership;
const SSEDescription = @import("sse_description.zig").SSEDescription;

/// Contains all of the attributes of a specific DAX cluster.
pub const Cluster = struct {
    /// The number of nodes in the cluster that are active (i.e., capable of serving
    /// requests).
    active_nodes: ?i32 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: ?[]const u8 = null,

    /// The endpoint for this DAX cluster, consisting of a DNS name, a port
    /// number, and a URL. Applications should use the URL to configure the DAX
    /// client to find their cluster.
    cluster_discovery_endpoint: ?Endpoint = null,

    /// The type of encryption supported by the cluster's endpoint. Values are:
    ///
    /// * `NONE` for no encryption
    ///
    /// `TLS` for Transport Layer Security
    cluster_endpoint_encryption_type: ?ClusterEndpointEncryptionType = null,

    /// The name of the DAX cluster.
    cluster_name: ?[]const u8 = null,

    /// The description of the cluster.
    description: ?[]const u8 = null,

    /// A valid Amazon Resource Name (ARN) that identifies an IAM role. At
    /// runtime, DAX will assume this role and use the role's permissions to
    /// access DynamoDB on your behalf.
    iam_role_arn: ?[]const u8 = null,

    /// The IP address type of the cluster. Values are:
    ///
    /// * `ipv4` - IPv4 addresses only
    ///
    /// * `ipv6` - IPv6 addresses only
    ///
    /// * `dual_stack` - Both IPv4 and IPv6 addresses
    network_type: ?NetworkType = null,

    /// A list of nodes to be removed from the cluster.
    node_ids_to_remove: ?[]const []const u8 = null,

    /// A list of nodes that are currently in the cluster.
    nodes: ?[]const Node = null,

    /// The node type for the nodes in the cluster. (All nodes in a DAX cluster are
    /// of the
    /// same type.)
    node_type: ?[]const u8 = null,

    /// Describes a notification topic and its status. Notification topics are used
    /// for
    /// publishing DAX events to subscribers using Amazon Simple Notification
    /// Service
    /// (SNS).
    notification_configuration: ?NotificationConfiguration = null,

    /// The parameter group being used by nodes in the cluster.
    parameter_group: ?ParameterGroupStatus = null,

    /// A range of time when maintenance of DAX cluster software will be performed.
    /// For
    /// example: `sun:01:00-sun:09:00`. Cluster maintenance normally takes less than
    /// 30 minutes, and is performed automatically within the maintenance window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// A list of security groups, and the status of each, for the nodes in the
    /// cluster.
    security_groups: ?[]const SecurityGroupMembership = null,

    /// The description of the server-side encryption status on the specified DAX
    /// cluster.
    sse_description: ?SSEDescription = null,

    /// The current status of the cluster.
    status: ?[]const u8 = null,

    /// The subnet group where the DAX cluster is running.
    subnet_group: ?[]const u8 = null,

    /// The total number of nodes in the cluster.
    total_nodes: ?i32 = null,

    pub const json_field_names = .{
        .active_nodes = "ActiveNodes",
        .cluster_arn = "ClusterArn",
        .cluster_discovery_endpoint = "ClusterDiscoveryEndpoint",
        .cluster_endpoint_encryption_type = "ClusterEndpointEncryptionType",
        .cluster_name = "ClusterName",
        .description = "Description",
        .iam_role_arn = "IamRoleArn",
        .network_type = "NetworkType",
        .node_ids_to_remove = "NodeIdsToRemove",
        .nodes = "Nodes",
        .node_type = "NodeType",
        .notification_configuration = "NotificationConfiguration",
        .parameter_group = "ParameterGroup",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .security_groups = "SecurityGroups",
        .sse_description = "SSEDescription",
        .status = "Status",
        .subnet_group = "SubnetGroup",
        .total_nodes = "TotalNodes",
    };
};
