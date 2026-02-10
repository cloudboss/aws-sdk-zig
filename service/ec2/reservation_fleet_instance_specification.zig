const CapacityReservationInstancePlatform = @import("capacity_reservation_instance_platform.zig").CapacityReservationInstancePlatform;
const InstanceType = @import("instance_type.zig").InstanceType;

/// Information about an instance type to use in a Capacity Reservation Fleet.
pub const ReservationFleetInstanceSpecification = struct {
    /// The Availability Zone in which the Capacity Reservation Fleet reserves the
    /// capacity. A
    /// Capacity Reservation Fleet can't span Availability Zones. All instance type
    /// specifications that you specify for the Fleet must use the same Availability
    /// Zone.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone in which the Capacity Reservation Fleet
    /// reserves the
    /// capacity. A Capacity Reservation Fleet can't span Availability Zones. All
    /// instance type
    /// specifications that you specify for the Fleet must use the same Availability
    /// Zone.
    availability_zone_id: ?[]const u8,

    /// Indicates whether the Capacity Reservation Fleet supports EBS-optimized
    /// instances
    /// types. This optimization provides dedicated throughput to Amazon EBS and an
    /// optimized configuration stack to provide optimal I/O performance. This
    /// optimization
    /// isn't available with all instance types. Additional usage charges apply when
    /// using
    /// EBS-optimized instance types.
    ebs_optimized: ?bool,

    /// The type of operating system for which the Capacity Reservation Fleet
    /// reserves
    /// capacity.
    instance_platform: ?CapacityReservationInstancePlatform,

    /// The instance type for which the Capacity Reservation Fleet reserves
    /// capacity.
    instance_type: ?InstanceType,

    /// The priority to assign to the instance type. This value is used to determine
    /// which of
    /// the instance types specified for the Fleet should be prioritized for use. A
    /// lower value
    /// indicates a high priority. For more information, see [Instance type
    /// priority](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#instance-priority) in the *Amazon EC2 User Guide*.
    priority: ?i32,

    /// The number of capacity units provided by the specified instance type. This
    /// value,
    /// together with the total target capacity that you specify for the Fleet
    /// determine the
    /// number of instances for which the Fleet reserves capacity. Both values are
    /// based on
    /// units that make sense for your workload. For more information, see [Total
    /// target
    /// capacity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#target-capacity) in the *Amazon EC2 User Guide*.
    weight: ?f64,
};
