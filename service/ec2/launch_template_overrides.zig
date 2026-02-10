const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const InstanceType = @import("instance_type.zig").InstanceType;

/// Describes overrides for a launch template.
pub const LaunchTemplateOverrides = struct {
    /// The Availability Zone in which to launch the instances. For example,
    /// `us-east-2a`.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be
    /// specified in the request, but not both.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone in which to launch the instances. For
    /// example,
    /// `use2-az1`.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be
    /// specified in the request, but not both.
    availability_zone_id: ?[]const u8,

    /// The instance requirements. When you specify instance requirements, Amazon
    /// EC2 will identify
    /// instance types with the provided requirements, and then use your On-Demand
    /// and Spot
    /// allocation strategies to launch instances from these instance types, in the
    /// same way as
    /// when you specify a list of instance types.
    ///
    /// **Note:**
    ///
    /// If you specify `InstanceRequirements`, you can't specify
    /// `InstanceType`.
    instance_requirements: ?InstanceRequirements,

    /// The instance type.
    instance_type: ?InstanceType,

    /// The priority for the launch template override. The highest priority is
    /// launched
    /// first.
    ///
    /// If `OnDemandAllocationStrategy` is set to `prioritized`, Spot Fleet
    /// uses priority to determine which launch template override to use first in
    /// fulfilling
    /// On-Demand capacity.
    ///
    /// If the Spot `AllocationStrategy` is set to
    /// `capacityOptimizedPrioritized`, Spot Fleet uses priority on a best-effort
    /// basis
    /// to determine which launch template override to use in fulfilling Spot
    /// capacity, but
    /// optimizes for capacity first.
    ///
    /// Valid values are whole numbers starting at `0`. The lower the number, the
    /// higher the priority. If no number is set, the launch template override has
    /// the lowest
    /// priority. You can set the same priority for different launch template
    /// overrides.
    priority: ?f64,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance. We do not recommend using this parameter because it can lead to
    /// increased interruptions. If you do not specify this parameter, you will pay
    /// the current Spot price.
    ///
    /// **Important:**
    ///
    /// If you specify a maximum price, your instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    spot_price: ?[]const u8,

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
    /// When specifying weights, the price used in the `lowestPrice` and
    /// `priceCapacityOptimized` allocation strategies is per
    /// *unit* hour (where the instance price is divided by the specified
    /// weight). However, if all the specified weights are above the requested
    /// `TargetCapacity`, resulting in only 1 instance being launched, the price
    /// used is per *instance* hour.
    weighted_capacity: ?f64,
};
