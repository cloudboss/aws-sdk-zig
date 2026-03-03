const CapacityAllocation = @import("capacity_allocation.zig").CapacityAllocation;
const CapacityReservationStatus = @import("capacity_reservation_status.zig").CapacityReservationStatus;

/// A reservation for a specified number of data processing units (DPUs). When a
/// reservation is initially created, it has no DPUs. Athena allocates DPUs
/// until the allocated amount equals the requested amount.
pub const CapacityReservation = struct {
    /// The number of data processing units currently allocated.
    allocated_dpus: i32,

    /// The time in UTC epoch millis when the capacity reservation was created.
    creation_time: i64,

    last_allocation: ?CapacityAllocation = null,

    /// The time of the most recent capacity allocation that succeeded.
    last_successful_allocation_time: ?i64 = null,

    /// The name of the capacity reservation.
    name: []const u8,

    /// The status of the capacity reservation.
    status: CapacityReservationStatus,

    /// The number of data processing units requested.
    target_dpus: i32,

    pub const json_field_names = .{
        .allocated_dpus = "AllocatedDpus",
        .creation_time = "CreationTime",
        .last_allocation = "LastAllocation",
        .last_successful_allocation_time = "LastSuccessfulAllocationTime",
        .name = "Name",
        .status = "Status",
        .target_dpus = "TargetDpus",
    };
};
