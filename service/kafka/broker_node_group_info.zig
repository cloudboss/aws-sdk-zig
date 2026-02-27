const BrokerAZDistribution = @import("broker_az_distribution.zig").BrokerAZDistribution;
const ConnectivityInfo = @import("connectivity_info.zig").ConnectivityInfo;
const StorageInfo = @import("storage_info.zig").StorageInfo;

/// Describes the setup to be used for Apache Kafka broker nodes in the cluster.
pub const BrokerNodeGroupInfo = struct {
    /// The distribution of broker nodes across Availability Zones. This is an
    /// optional parameter. If you don't specify it, Amazon MSK gives it the value
    /// DEFAULT. You can also explicitly set this parameter to the value DEFAULT. No
    /// other values are currently allowed.
    ///
    /// Amazon MSK distributes the broker nodes evenly across the Availability Zones
    /// that correspond to the subnets you provide when you create the cluster.
    broker_az_distribution: ?BrokerAZDistribution,

    /// The list of subnets to connect to in the client virtual private cloud (VPC).
    /// AWS creates elastic network interfaces inside these subnets. Client
    /// applications use elastic network interfaces to produce and consume data.
    /// Client subnets can't occupy the Availability Zone with ID use use1-az3.
    client_subnets: []const []const u8,

    /// Information about the broker access configuration.
    connectivity_info: ?ConnectivityInfo,

    /// The type of Amazon EC2 instances to use for Apache Kafka brokers. The
    /// following instance types are allowed: kafka.m5.large, kafka.m5.xlarge,
    /// kafka.m5.2xlarge,
    /// kafka.m5.4xlarge, kafka.m5.12xlarge, and kafka.m5.24xlarge.
    instance_type: []const u8,

    /// The AWS security groups to associate with the elastic network interfaces in
    /// order to specify who can connect to and communicate with the Amazon MSK
    /// cluster. If you don't specify a security group, Amazon MSK uses the default
    /// security group associated with the VPC.
    security_groups: ?[]const []const u8,

    /// Contains information about storage volumes attached to MSK broker nodes.
    storage_info: ?StorageInfo,

    /// The list of zoneIds for the cluster in the virtual private cloud (VPC).
    zone_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .broker_az_distribution = "BrokerAZDistribution",
        .client_subnets = "ClientSubnets",
        .connectivity_info = "ConnectivityInfo",
        .instance_type = "InstanceType",
        .security_groups = "SecurityGroups",
        .storage_info = "StorageInfo",
        .zone_ids = "ZoneIds",
    };
};
