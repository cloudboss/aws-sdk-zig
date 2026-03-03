const AllocationType = @import("allocation_type.zig").AllocationType;

/// Information about instance capacity usage for a Capacity Reservation.
pub const CapacityAllocation = struct {
    /// The usage type. `used` indicates that the instance capacity is in use by
    /// instances that are running in the Capacity Reservation.
    allocation_type: ?AllocationType = null,

    /// The amount of instance capacity associated with the usage. For example a
    /// value of
    /// `4` indicates that instance capacity for 4 instances is currently in
    /// use.
    count: ?i32 = null,
};
