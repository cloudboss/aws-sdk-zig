const FleetInstanceMatchCriteria = @import("fleet_instance_match_criteria.zig").FleetInstanceMatchCriteria;
const FleetCapacityReservation = @import("fleet_capacity_reservation.zig").FleetCapacityReservation;
const CapacityReservationFleetState = @import("capacity_reservation_fleet_state.zig").CapacityReservationFleetState;
const Tag = @import("tag.zig").Tag;
const FleetCapacityReservationTenancy = @import("fleet_capacity_reservation_tenancy.zig").FleetCapacityReservationTenancy;

/// Information about a Capacity Reservation Fleet.
pub const CapacityReservationFleet = struct {
    /// The strategy used by the Capacity Reservation Fleet to determine which of
    /// the
    /// specified instance types to use. For more information, see For more
    /// information, see
    /// [Allocation
    /// strategy](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#allocation-strategy) in the *Amazon EC2 User Guide*.
    allocation_strategy: ?[]const u8 = null,

    /// The ARN of the Capacity Reservation Fleet.
    capacity_reservation_fleet_arn: ?[]const u8 = null,

    /// The ID of the Capacity Reservation Fleet.
    capacity_reservation_fleet_id: ?[]const u8 = null,

    /// The date and time at which the Capacity Reservation Fleet was created.
    create_time: ?i64 = null,

    /// The date and time at which the Capacity Reservation Fleet expires.
    end_date: ?i64 = null,

    /// Indicates the type of instance launches that the Capacity Reservation Fleet
    /// accepts.
    /// All Capacity Reservations in the Fleet inherit this instance matching
    /// criteria.
    ///
    /// Currently, Capacity Reservation Fleets support `open` instance matching
    /// criteria only. This means that instances that have matching attributes
    /// (instance type,
    /// platform, and Availability Zone) run in the Capacity Reservations
    /// automatically.
    /// Instances do not need to explicitly target a Capacity Reservation Fleet to
    /// use its
    /// reserved capacity.
    instance_match_criteria: ?FleetInstanceMatchCriteria = null,

    /// Information about the instance types for which to reserve the capacity.
    instance_type_specifications: ?[]const FleetCapacityReservation = null,

    /// The state of the Capacity Reservation Fleet. Possible states include:
    ///
    /// * `submitted` - The Capacity Reservation Fleet request has been
    /// submitted and Amazon Elastic Compute Cloud is preparing to create the
    /// Capacity
    /// Reservations.
    ///
    /// * `modifying` - The Capacity Reservation Fleet is being modified. The
    /// Fleet remains in this state until the modification is complete.
    ///
    /// * `active` - The Capacity Reservation Fleet has fulfilled its total
    /// target capacity and it is attempting to maintain this capacity. The Fleet
    /// remains in this state until it is modified or deleted.
    ///
    /// * `partially_fulfilled` - The Capacity Reservation Fleet has
    /// partially fulfilled its total target capacity. There is insufficient Amazon
    /// EC2 to fulfill the total target capacity. The Fleet is attempting to
    /// asynchronously fulfill its total target capacity.
    ///
    /// * `expiring` - The Capacity Reservation Fleet has reach its end date
    /// and it is in the process of expiring. One or more of its Capacity
    /// reservations
    /// might still be active.
    ///
    /// * `expired` - The Capacity Reservation Fleet has reach its end date.
    /// The Fleet and its Capacity Reservations are expired. The Fleet can't create
    /// new
    /// Capacity Reservations.
    ///
    /// * `cancelling` - The Capacity Reservation Fleet is in the process of
    /// being cancelled. One or more of its Capacity reservations might still be
    /// active.
    ///
    /// * `cancelled` - The Capacity Reservation Fleet has been manually
    /// cancelled. The Fleet and its Capacity Reservations are cancelled and the
    /// Fleet
    /// can't create new Capacity Reservations.
    ///
    /// * `failed` - The Capacity Reservation Fleet failed to reserve
    /// capacity for the specified instance types.
    state: ?CapacityReservationFleetState = null,

    /// The tags assigned to the Capacity Reservation Fleet.
    tags: ?[]const Tag = null,

    /// The tenancy of the Capacity Reservation Fleet. Tenancies include:
    ///
    /// * `default` - The Capacity Reservation Fleet is created on hardware
    /// that is shared with other Amazon Web Services accounts.
    ///
    /// * `dedicated` - The Capacity Reservation Fleet is created on
    /// single-tenant hardware that is dedicated to a single Amazon Web Services
    /// account.
    tenancy: ?FleetCapacityReservationTenancy = null,

    /// The capacity units that have been fulfilled.
    total_fulfilled_capacity: ?f64 = null,

    /// The total number of capacity units for which the Capacity Reservation Fleet
    /// reserves
    /// capacity. For more information, see [Total target
    /// capacity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#target-capacity) in the *Amazon EC2 User Guide*.
    total_target_capacity: ?i32 = null,
};
