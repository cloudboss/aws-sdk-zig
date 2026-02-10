const BlockDeviceMappingResponse = @import("block_device_mapping_response.zig").BlockDeviceMappingResponse;
const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const InstanceType = @import("instance_type.zig").InstanceType;
const PlacementResponse = @import("placement_response.zig").PlacementResponse;

/// Describes overrides for a launch template.
pub const FleetLaunchTemplateOverrides = struct {
    /// The Availability Zone in which to launch the instances. For example,
    /// `us-east-2a`.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be specified in the
    /// request, but not both.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone in which to launch the instances. For
    /// example,
    /// `use2-az1`.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be
    /// specified in the request, but not both.
    availability_zone_id: ?[]const u8,

    /// The block device mappings, which define the EBS volumes and instance store
    /// volumes to
    /// attach to the instance at launch.
    ///
    /// Supported only for fleets of type `instant`.
    ///
    /// For more information, see [Block device mappings
    /// for volumes on Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html) in the *Amazon EC2 User
    /// Guide*.
    block_device_mappings: ?[]const BlockDeviceMappingResponse,

    /// The ID of the AMI in the format `ami-17characters00000`.
    ///
    /// Alternatively, you can specify a Systems Manager parameter, using one of the
    /// following
    /// formats. The Systems Manager parameter will resolve to an AMI ID on launch.
    ///
    /// To reference a public parameter:
    ///
    /// * `resolve:ssm:*public-parameter*
    /// `
    ///
    /// To reference a parameter stored in the same account:
    ///
    /// * `resolve:ssm:*parameter-name*
    /// `
    ///
    /// * `resolve:ssm:*parameter-name:version-number*
    /// `
    ///
    /// * `resolve:ssm:*parameter-name:label*
    /// `
    ///
    /// To reference a parameter shared from another Amazon Web Services account:
    ///
    /// * `resolve:ssm:*parameter-ARN*
    /// `
    ///
    /// * `resolve:ssm:*parameter-ARN:version-number*
    /// `
    ///
    /// * `resolve:ssm:*parameter-ARN:label*
    /// `
    ///
    /// For more information, see [Use a Systems Manager parameter instead of an AMI
    /// ID](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#use-an-ssm-parameter-instead-of-an-ami-id) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// **Note:**
    ///
    /// This parameter is only available for fleets of type `instant`. For fleets
    /// of type `maintain` and `request`, you must specify the AMI ID in
    /// the launch template.
    image_id: ?[]const u8,

    /// The attributes for the instance types. When you specify instance attributes,
    /// Amazon EC2 will
    /// identify instance types with those attributes.
    ///
    /// **Note:**
    ///
    /// If you specify `InstanceRequirements`, you can't specify
    /// `InstanceType`.
    instance_requirements: ?InstanceRequirements,

    /// The instance type.
    ///
    /// `mac1.metal` is not supported as a launch template override.
    ///
    /// **Note:**
    ///
    /// If you specify `InstanceType`, you can't specify
    /// `InstanceRequirements`.
    instance_type: ?InstanceType,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance. We do not
    /// recommend using this parameter because it can lead to increased
    /// interruptions. If you
    /// do not specify this parameter, you will pay the current Spot price.
    ///
    /// **Important:**
    ///
    /// If you specify a maximum price, your instances will be interrupted more
    /// frequently
    /// than if you do not specify this parameter.
    ///
    /// If you specify a maximum price, it must be more than USD $0.001. Specifying
    /// a value
    /// below USD $0.001 will result in an `InvalidParameterValue` error
    /// message.
    max_price: ?[]const u8,

    /// The location where the instance launched, if applicable.
    placement: ?PlacementResponse,

    /// The priority for the launch template override. The highest priority is
    /// launched
    /// first.
    ///
    /// If the On-Demand `AllocationStrategy` is set to `prioritized`,
    /// EC2 Fleet uses priority to determine which launch template override to use
    /// first in fulfilling
    /// On-Demand capacity.
    ///
    /// If the Spot `AllocationStrategy` is set to
    /// `capacity-optimized-prioritized`, EC2 Fleet uses priority on a best-effort
    /// basis
    /// to determine which launch template override to use in fulfilling Spot
    /// capacity, but
    /// optimizes for capacity first.
    ///
    /// Valid values are whole numbers starting at `0`. The lower the number, the
    /// higher the priority. If no number is set, the override has the lowest
    /// priority. You can set
    /// the same priority for different launch template overrides.
    priority: ?f64,

    /// The ID of the subnet in which to launch the instances.
    subnet_id: ?[]const u8,

    /// The number of units provided by the specified instance type. These are the
    /// same units
    /// that you chose to set the target capacity in terms of instances, or a
    /// performance
    /// characteristic such as vCPUs, memory, or I/O.
    ///
    /// If the target capacity divided by this value is not a whole number, Amazon
    /// EC2 rounds the
    /// number of instances to the next whole number. If this value is not
    /// specified, the default
    /// is 1.
    ///
    /// **Note:**
    ///
    /// When specifying weights, the price used in the `lowest-price` and
    /// `price-capacity-optimized` allocation strategies is per
    /// *unit* hour (where the instance price is divided by the specified
    /// weight). However, if all the specified weights are above the requested
    /// `TargetCapacity`, resulting in only 1 instance being launched, the price
    /// used is per *instance* hour.
    weighted_capacity: ?f64,
};
