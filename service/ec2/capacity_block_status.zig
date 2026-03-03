const CapacityReservationStatus = @import("capacity_reservation_status.zig").CapacityReservationStatus;
const CapacityBlockInterconnectStatus = @import("capacity_block_interconnect_status.zig").CapacityBlockInterconnectStatus;

/// Describes the availability of capacity for a Capacity Block.
pub const CapacityBlockStatus = struct {
    /// The ID of the Capacity Block.
    capacity_block_id: ?[]const u8 = null,

    /// The availability of capacity for the Capacity Block reservations.
    capacity_reservation_statuses: ?[]const CapacityReservationStatus = null,

    /// The status of the high-bandwidth accelerator interconnect. Possible states
    /// include:
    ///
    /// * `ok` the accelerator interconnect is healthy.
    ///
    /// * `impaired` - accelerator interconnect communication is impaired.
    ///
    /// * `insufficient-data` - insufficient data to determine accelerator
    ///   interconnect status.
    interconnect_status: ?CapacityBlockInterconnectStatus = null,

    /// The remaining capacity. Indicates the number of resources that can be
    /// launched into the Capacity Block.
    total_available_capacity: ?i32 = null,

    /// The combined amount of `Available` and `Unavailable` capacity in the
    /// Capacity Block.
    total_capacity: ?i32 = null,

    /// The unavailable capacity. Indicates the instance capacity that is
    /// unavailable for use
    /// due to a system status check failure.
    total_unavailable_capacity: ?i32 = null,
};
