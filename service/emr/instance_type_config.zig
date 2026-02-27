const Configuration = @import("configuration.zig").Configuration;
const EbsConfiguration = @import("ebs_configuration.zig").EbsConfiguration;

/// An instance type configuration for each instance type in an instance fleet,
/// which
/// determines the Amazon EC2 instances Amazon EMR attempts to provision to
/// fulfill On-Demand and Spot target capacities. When you use an allocation
/// strategy, you can
/// include a maximum of 30 instance type configurations for a fleet. For more
/// information
/// about how to use an allocation strategy, see [Configure Instance
/// Fleets](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-instance-fleet.html). Without an allocation strategy, you may specify a maximum of five
/// instance type configurations for a fleet.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions.
pub const InstanceTypeConfig = struct {
    /// The bid price for each Amazon EC2 Spot Instance type as defined by
    /// `InstanceType`. Expressed in USD. If neither `BidPrice` nor
    /// `BidPriceAsPercentageOfOnDemandPrice` is provided,
    /// `BidPriceAsPercentageOfOnDemandPrice` defaults to 100%.
    bid_price: ?[]const u8,

    /// The bid price, as a percentage of On-Demand price, for each Amazon EC2 Spot
    /// Instance as defined by `InstanceType`. Expressed as a number (for example,
    /// 20
    /// specifies 20%). If neither `BidPrice` nor
    /// `BidPriceAsPercentageOfOnDemandPrice` is provided,
    /// `BidPriceAsPercentageOfOnDemandPrice` defaults to 100%.
    bid_price_as_percentage_of_on_demand_price: ?f64,

    /// A configuration classification that applies when provisioning cluster
    /// instances, which
    /// can include configurations for applications and software that run on the
    /// cluster.
    configurations: ?[]const Configuration,

    /// The custom AMI ID to use for the instance type.
    custom_ami_id: ?[]const u8,

    /// The configuration of Amazon Elastic Block Store (Amazon EBS) attached to
    /// each
    /// instance as defined by `InstanceType`.
    ebs_configuration: ?EbsConfiguration,

    /// An Amazon EC2 instance type, such as `m3.xlarge`.
    instance_type: []const u8,

    /// The priority at which Amazon EMR launches the Amazon EC2 instances with this
    /// instance type.
    /// Priority starts at 0, which is the highest priority. Amazon EMR considers
    /// the highest priority first.
    priority: ?f64,

    /// The number of units that a provisioned instance of this type provides toward
    /// fulfilling
    /// the target capacities defined in InstanceFleetConfig. This value is 1 for
    /// a master instance fleet, and must be 1 or greater for core and task instance
    /// fleets.
    /// Defaults to 1 if not specified.
    weighted_capacity: ?i32,

    pub const json_field_names = .{
        .bid_price = "BidPrice",
        .bid_price_as_percentage_of_on_demand_price = "BidPriceAsPercentageOfOnDemandPrice",
        .configurations = "Configurations",
        .custom_ami_id = "CustomAmiId",
        .ebs_configuration = "EbsConfiguration",
        .instance_type = "InstanceType",
        .priority = "Priority",
        .weighted_capacity = "WeightedCapacity",
    };
};
