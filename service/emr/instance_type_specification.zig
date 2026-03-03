const Configuration = @import("configuration.zig").Configuration;
const EbsBlockDevice = @import("ebs_block_device.zig").EbsBlockDevice;

/// The configuration specification for each instance type in an instance fleet.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions.
pub const InstanceTypeSpecification = struct {
    /// The bid price for each Amazon EC2 Spot Instance type as defined by
    /// `InstanceType`. Expressed in USD. If neither `BidPrice` nor
    /// `BidPriceAsPercentageOfOnDemandPrice` is provided,
    /// `BidPriceAsPercentageOfOnDemandPrice` defaults to 100%.
    bid_price: ?[]const u8 = null,

    /// The bid price, as a percentage of On-Demand price, for each Amazon EC2 Spot
    /// Instance as defined by `InstanceType`. Expressed as a number (for example,
    /// 20
    /// specifies 20%).
    bid_price_as_percentage_of_on_demand_price: ?f64 = null,

    /// A configuration classification that applies when provisioning cluster
    /// instances, which
    /// can include configurations for applications and software bundled with Amazon
    /// EMR.
    configurations: ?[]const Configuration = null,

    /// The custom AMI ID to use for the instance type.
    custom_ami_id: ?[]const u8 = null,

    /// The configuration of Amazon Elastic Block Store (Amazon EBS) attached to
    /// each
    /// instance as defined by `InstanceType`.
    ebs_block_devices: ?[]const EbsBlockDevice = null,

    /// Evaluates to `TRUE` when the specified `InstanceType` is
    /// EBS-optimized.
    ebs_optimized: ?bool = null,

    /// The Amazon EC2 instance type, for example `m3.xlarge`.
    instance_type: ?[]const u8 = null,

    /// The priority at which Amazon EMR launches the Amazon EC2 instances with this
    /// instance type.
    /// Priority starts at 0, which is the highest priority. Amazon EMR considers
    /// the highest priority first.
    priority: ?f64 = null,

    /// The number of units that a provisioned instance of this type provides toward
    /// fulfilling
    /// the target capacities defined in InstanceFleetConfig. Capacity values
    /// represent performance characteristics such as vCPUs, memory, or I/O. If not
    /// specified, the
    /// default value is 1.
    weighted_capacity: ?i32 = null,

    pub const json_field_names = .{
        .bid_price = "BidPrice",
        .bid_price_as_percentage_of_on_demand_price = "BidPriceAsPercentageOfOnDemandPrice",
        .configurations = "Configurations",
        .custom_ami_id = "CustomAmiId",
        .ebs_block_devices = "EbsBlockDevices",
        .ebs_optimized = "EbsOptimized",
        .instance_type = "InstanceType",
        .priority = "Priority",
        .weighted_capacity = "WeightedCapacity",
    };
};
