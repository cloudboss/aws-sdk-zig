const AutoScalingPolicyDescription = @import("auto_scaling_policy_description.zig").AutoScalingPolicyDescription;
const Configuration = @import("configuration.zig").Configuration;
const EbsBlockDevice = @import("ebs_block_device.zig").EbsBlockDevice;
const InstanceGroupType = @import("instance_group_type.zig").InstanceGroupType;
const MarketType = @import("market_type.zig").MarketType;
const ShrinkPolicy = @import("shrink_policy.zig").ShrinkPolicy;
const InstanceGroupStatus = @import("instance_group_status.zig").InstanceGroupStatus;

/// This entity represents an instance group, which is a group of instances that
/// have common
/// purpose. For example, CORE instance group is used for HDFS.
pub const InstanceGroup = struct {
    /// An automatic scaling policy for a core instance group or task instance group
    /// in an
    /// Amazon EMR cluster. The automatic scaling policy defines how an instance
    /// group
    /// dynamically adds and terminates Amazon EC2 instances in response to the
    /// value of a
    /// CloudWatch metric. See PutAutoScalingPolicy.
    auto_scaling_policy: ?AutoScalingPolicyDescription,

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

    /// The version number of the requested configuration specification for this
    /// instance
    /// group.
    configurations_version: ?i64,

    /// The custom AMI ID to use for the provisioned instance group.
    custom_ami_id: ?[]const u8,

    /// The EBS block devices that are mapped to this instance group.
    ebs_block_devices: ?[]const EbsBlockDevice,

    /// If the instance group is EBS-optimized. An Amazon EBS-optimized instance
    /// uses an
    /// optimized configuration stack and provides additional, dedicated capacity
    /// for Amazon EBS I/O.
    ebs_optimized: ?bool,

    /// The identifier of the instance group.
    id: ?[]const u8,

    /// The type of the instance group. Valid values are MASTER, CORE or TASK.
    instance_group_type: ?InstanceGroupType,

    /// The Amazon EC2 instance type for all instances in the instance group.
    instance_type: ?[]const u8,

    /// A list of configurations that were successfully applied for an instance
    /// group last
    /// time.
    last_successfully_applied_configurations: ?[]const Configuration,

    /// The version number of a configuration specification that was successfully
    /// applied for an
    /// instance group last time.
    last_successfully_applied_configurations_version: ?i64,

    /// The marketplace to provision instances for this group. Valid values are
    /// ON_DEMAND or
    /// SPOT.
    market: ?MarketType,

    /// The name of the instance group.
    name: ?[]const u8,

    /// The target number of instances for the instance group.
    requested_instance_count: ?i32,

    /// The number of instances currently running in this instance group.
    running_instance_count: ?i32,

    /// Policy for customizing shrink operations.
    shrink_policy: ?ShrinkPolicy,

    /// The current status of the instance group.
    status: ?InstanceGroupStatus,

    pub const json_field_names = .{
        .auto_scaling_policy = "AutoScalingPolicy",
        .bid_price = "BidPrice",
        .configurations = "Configurations",
        .configurations_version = "ConfigurationsVersion",
        .custom_ami_id = "CustomAmiId",
        .ebs_block_devices = "EbsBlockDevices",
        .ebs_optimized = "EbsOptimized",
        .id = "Id",
        .instance_group_type = "InstanceGroupType",
        .instance_type = "InstanceType",
        .last_successfully_applied_configurations = "LastSuccessfullyAppliedConfigurations",
        .last_successfully_applied_configurations_version = "LastSuccessfullyAppliedConfigurationsVersion",
        .market = "Market",
        .name = "Name",
        .requested_instance_count = "RequestedInstanceCount",
        .running_instance_count = "RunningInstanceCount",
        .shrink_policy = "ShrinkPolicy",
        .status = "Status",
    };
};
