const InterruptionType = @import("interruption_type.zig").InterruptionType;
const InterruptibleCapacityReservationAllocationStatus = @import("interruptible_capacity_reservation_allocation_status.zig").InterruptibleCapacityReservationAllocationStatus;
const ZeroSizePreference = @import("zero_size_preference.zig").ZeroSizePreference;

/// Represents the allocation of capacity from a source reservation to an
/// interruptible reservation, tracking current and target instance counts for
/// allocation management.
pub const InterruptibleCapacityAllocation = struct {
    /// The current number of instances allocated to the interruptible reservation.
    instance_count: ?i32 = null,

    /// The ID of the interruptible Capacity Reservation created from the
    /// allocation.
    interruptible_capacity_reservation_id: ?[]const u8 = null,

    /// The type of interruption policy applied to the interruptible reservation.
    interruption_type: ?InterruptionType = null,

    /// The current status of the allocation (updating during reclamation, active
    /// when complete).
    status: ?InterruptibleCapacityReservationAllocationStatus = null,

    /// After your modify request, the requested number of instances allocated to
    /// interruptible reservation.
    target_instance_count: ?i32 = null,

    /// Specifies how Amazon EC2 handles the interruptible Capacity Reservation when
    /// you reduce its allocation to zero instances. A value of `retain` keeps the
    /// interruptible Capacity Reservation active at zero capacity so that you can
    /// allocate instances to it again later. A value of `default` cancels the
    /// interruptible Capacity Reservation and returns the capacity to your source
    /// Capacity Reservation.
    zero_size_preference: ?ZeroSizePreference = null,
};
