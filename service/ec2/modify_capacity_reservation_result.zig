const CapacityReservationAdjustmentDetails = @import("capacity_reservation_adjustment_details.zig").CapacityReservationAdjustmentDetails;
const CapacityReservationAdjustmentStatus = @import("capacity_reservation_adjustment_status.zig").CapacityReservationAdjustmentStatus;

pub const ModifyCapacityReservationResult = struct {
    /// The configuration that the Capacity Reservation will have after the
    /// adjustment is
    /// applied.
    adjustment_details: ?CapacityReservationAdjustmentDetails = null,

    /// The status of the requested modification. For a description of each possible
    /// value, see
    /// the `adjustmentStatus` field of the `CapacityReservation` data
    /// type.
    adjustment_status: ?CapacityReservationAdjustmentStatus = null,

    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,
};
