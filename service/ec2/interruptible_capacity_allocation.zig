const InterruptionType = @import("interruption_type.zig").InterruptionType;
const InterruptibleCapacityReservationAllocationStatus = @import("interruptible_capacity_reservation_allocation_status.zig").InterruptibleCapacityReservationAllocationStatus;

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
};
