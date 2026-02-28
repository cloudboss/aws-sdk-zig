const ClusterEndpointEncryptionType = @import("cluster_endpoint_encryption_type.zig").ClusterEndpointEncryptionType;
const NetworkType = @import("network_type.zig").NetworkType;
const SSESpecification = @import("sse_specification.zig").SSESpecification;
const Tag = @import("tag.zig").Tag;

pub const CreateClusterRequest = struct {
    /// The Availability Zones (AZs) in which the cluster nodes will reside after
    /// the
    /// cluster has been created or updated. If provided, the length of this list
    /// must equal the
    /// `ReplicationFactor` parameter. If you omit this parameter, DAX will spread
    /// the nodes across Availability Zones for the highest
    /// availability.
    availability_zones: ?[]const []const u8,

    /// The type of encryption the cluster's endpoint should support. Values are:
    ///
    /// * `NONE` for no encryption
    ///
    /// * `TLS` for Transport Layer Security
    cluster_endpoint_encryption_type: ?ClusterEndpointEncryptionType,

    /// The cluster identifier. This parameter is stored as a lowercase string.
    ///
    /// **Constraints:**
    ///
    /// * A name must contain from 1 to 20 alphanumeric characters or
    /// hyphens.
    ///
    /// * The first character must be a letter.
    ///
    /// * A name cannot end with a hyphen or contain two consecutive
    /// hyphens.
    cluster_name: []const u8,

    /// A description of the cluster.
    description: ?[]const u8,

    /// A valid Amazon Resource Name (ARN) that identifies an IAM role. At
    /// runtime, DAX will assume this role and use the role's permissions to
    /// access DynamoDB on your behalf.
    iam_role_arn: []const u8,

    /// Specifies the IP protocol(s) the cluster uses for network communications.
    /// Values
    /// are:
    ///
    /// * `ipv4` - The cluster is accessible only through IPv4
    /// addresses
    ///
    /// * `ipv6` - The cluster is accessible only through IPv6
    /// addresses
    ///
    /// * `dual_stack` - The cluster is accessible through both IPv4 and
    /// IPv6 addresses.
    ///
    /// If no explicit `NetworkType` is provided, the network type is
    /// derived based on the subnet group's configuration.
    network_type: ?NetworkType,

    /// The compute and memory capacity of the nodes in the cluster.
    node_type: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to which
    /// notifications will be sent.
    ///
    /// The Amazon SNS topic owner must be same as the DAX
    /// cluster owner.
    notification_topic_arn: ?[]const u8,

    /// The parameter group to be associated with the DAX cluster.
    parameter_group_name: ?[]const u8,

    /// Specifies the weekly time range during which maintenance on the DAX cluster
    /// is
    /// performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi
    /// (24H Clock
    /// UTC). The minimum maintenance window is a 60 minute period. Valid values for
    /// `ddd` are:
    ///
    /// * `sun`
    ///
    /// * `mon`
    ///
    /// * `tue`
    ///
    /// * `wed`
    ///
    /// * `thu`
    ///
    /// * `fri`
    ///
    /// * `sat`
    ///
    /// Example: `sun:05:00-sun:09:00`
    ///
    /// If you don't specify a preferred maintenance window when you create or
    /// modify a
    /// cache cluster, DAX assigns a 60-minute maintenance window on a
    /// randomly selected day of the week.
    preferred_maintenance_window: ?[]const u8,

    /// The number of nodes in the DAX cluster. A replication factor of 1
    /// will create a single-node cluster, without any read replicas. For additional
    /// fault
    /// tolerance, you can create a multiple node cluster with one or more read
    /// replicas. To do
    /// this, set `ReplicationFactor` to a number between 3 (one primary and two
    /// read
    /// replicas) and 10 (one primary and nine read replicas). `If the
    /// AvailabilityZones` parameter is provided, its length must equal the
    /// `ReplicationFactor`.
    ///
    /// Amazon Web Services recommends that you have at least two read replicas per
    /// cluster.
    replication_factor: ?i32 = null,

    /// A list of security group IDs to be assigned to each node in the DAX
    /// cluster. (Each of the security group ID is system-generated.)
    ///
    /// If this parameter is not specified, DAX assigns the default VPC
    /// security group to each node.
    security_group_ids: ?[]const []const u8,

    /// Represents the settings used to enable server-side encryption on the
    /// cluster.
    sse_specification: ?SSESpecification,

    /// The name of the subnet group to be used for the replication group.
    ///
    /// DAX clusters can only run in an Amazon VPC environment.
    /// All of the subnets that you specify in a subnet group must exist in the same
    /// VPC.
    subnet_group_name: ?[]const u8,

    /// A set of tags to associate with the DAX cluster.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .cluster_endpoint_encryption_type = "ClusterEndpointEncryptionType",
        .cluster_name = "ClusterName",
        .description = "Description",
        .iam_role_arn = "IamRoleArn",
        .network_type = "NetworkType",
        .node_type = "NodeType",
        .notification_topic_arn = "NotificationTopicArn",
        .parameter_group_name = "ParameterGroupName",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .replication_factor = "ReplicationFactor",
        .security_group_ids = "SecurityGroupIds",
        .sse_specification = "SSESpecification",
        .subnet_group_name = "SubnetGroupName",
        .tags = "Tags",
    };
};
