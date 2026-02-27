const AutoScalingPolicy = @import("auto_scaling_policy.zig").AutoScalingPolicy;
const Configuration = @import("configuration.zig").Configuration;
const EbsConfiguration = @import("ebs_configuration.zig").EbsConfiguration;
const InstanceRoleType = @import("instance_role_type.zig").InstanceRoleType;
const MarketType = @import("market_type.zig").MarketType;

/// Configuration defining a new instance group.
pub const InstanceGroupConfig = struct {
    /// An automatic scaling policy for a core instance group or task instance group
    /// in an
    /// Amazon EMR cluster. The automatic scaling policy defines how an instance
    /// group
    /// dynamically adds and terminates Amazon EC2 instances in response to the
    /// value of a
    /// CloudWatch metric. See PutAutoScalingPolicy.
    auto_scaling_policy: ?AutoScalingPolicy,

    /// The bid price for each Amazon EC2 Spot Instance type as defined by
    /// `InstanceType`. Expressed in USD. If neither `BidPrice` nor
    /// `BidPriceAsPercentageOfOnDemandPrice` is provided,
    /// `BidPriceAsPercentageOfOnDemandPrice` defaults to 100%.
    bid_price: ?[]const u8,

    /// Amazon EMR releases 4.x or later.
    ///
    /// The list of configurations supplied for an Amazon EMR cluster instance
    /// group.
    /// You can specify a separate configuration for each instance group (master,
    /// core, and
    /// task).
    configurations: ?[]const Configuration,

    /// The custom AMI ID to use for the provisioned instance group.
    custom_ami_id: ?[]const u8,

    /// EBS configurations that will be attached to each Amazon EC2 instance in the
    /// instance group.
    ebs_configuration: ?EbsConfiguration,

    /// Target number of instances for the instance group.
    instance_count: i32,

    /// The role of the instance group in the cluster.
    instance_role: InstanceRoleType,

    /// The Amazon EC2 instance type for all instances in the instance group.
    instance_type: []const u8,

    /// Market type of the Amazon EC2 instances used to create a cluster node.
    market: ?MarketType,

    /// Friendly name given to the instance group.
    name: ?[]const u8,

    pub const json_field_names = .{
        .auto_scaling_policy = "AutoScalingPolicy",
        .bid_price = "BidPrice",
        .configurations = "Configurations",
        .custom_ami_id = "CustomAmiId",
        .ebs_configuration = "EbsConfiguration",
        .instance_count = "InstanceCount",
        .instance_role = "InstanceRole",
        .instance_type = "InstanceType",
        .market = "Market",
        .name = "Name",
    };
};
