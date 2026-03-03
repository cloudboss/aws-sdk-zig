const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;
const CapacityReservationTargetResponse = @import("capacity_reservation_target_response.zig").CapacityReservationTargetResponse;

/// Information about the Capacity Reservation targeting option.
pub const LaunchTemplateCapacityReservationSpecificationResponse = struct {
    /// Indicates the instance's Capacity Reservation preferences. Possible
    /// preferences
    /// include:
    ///
    /// * `open` - The instance can run in any `open` Capacity
    /// Reservation that has matching attributes (instance type, platform,
    /// Availability
    /// Zone).
    ///
    /// * `none` - The instance avoids running in a Capacity Reservation even
    /// if one is available. The instance runs in On-Demand capacity.
    capacity_reservation_preference: ?CapacityReservationPreference = null,

    /// Information about the target Capacity Reservation or Capacity Reservation
    /// group.
    capacity_reservation_target: ?CapacityReservationTargetResponse = null,
};
