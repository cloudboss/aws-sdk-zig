const CapacityReservationInstancePlatform = @import("capacity_reservation_instance_platform.zig").CapacityReservationInstancePlatform;
const InstanceType = @import("instance_type.zig").InstanceType;

/// Information about a Capacity Reservation in a Capacity Reservation Fleet.
pub const FleetCapacityReservation = struct {
    /// The Availability Zone in which the Capacity Reservation reserves capacity.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone in which the Capacity Reservation reserves
    /// capacity.
    availability_zone_id: ?[]const u8,

    /// The ID of the Capacity Reservation.
    capacity_reservation_id: ?[]const u8,

    /// The date and time at which the Capacity Reservation was created.
    create_date: ?i64,

    /// Indicates whether the Capacity Reservation reserves capacity for
    /// EBS-optimized
    /// instance types.
    ebs_optimized: ?bool,

    /// The number of capacity units fulfilled by the Capacity Reservation. For more
    /// information, see [Total target
    /// capacity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#target-capacity) in the *Amazon EC2 User Guide*.
    fulfilled_capacity: ?f64,

    /// The type of operating system for which the Capacity Reservation reserves
    /// capacity.
    instance_platform: ?CapacityReservationInstancePlatform,

    /// The instance type for which the Capacity Reservation reserves capacity.
    instance_type: ?InstanceType,

    /// The priority of the instance type in the Capacity Reservation Fleet. For
    /// more
    /// information, see [Instance type
    /// priority](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#instance-priority) in the *Amazon EC2 User Guide*.
    priority: ?i32,

    /// The total number of instances for which the Capacity Reservation reserves
    /// capacity.
    total_instance_count: ?i32,

    /// The weight of the instance type in the Capacity Reservation Fleet. For more
    /// information, see [Instance type
    /// weight](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#instance-weight) in the *Amazon EC2 User Guide*.
    weight: ?f64,
};
