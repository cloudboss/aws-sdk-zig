const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;
const CapacityReservationTargetResponse = @import("capacity_reservation_target_response.zig").CapacityReservationTargetResponse;

/// Describes the instance's Capacity Reservation targeting preferences. The
/// action returns the
/// `capacityReservationPreference` response element if the instance is
/// configured to run in On-Demand capacity, or if it is configured in run in
/// any
/// `open` Capacity Reservation that has matching attributes (instance type,
/// platform,
/// Availability Zone). The action returns the `capacityReservationTarget`
/// response element if the instance explicily targets a specific Capacity
/// Reservation or Capacity Reservation group.
pub const CapacityReservationSpecificationResponse = struct {
    /// Describes the instance's Capacity Reservation preferences. Possible
    /// preferences include:
    ///
    /// * `open` - The instance can run in any `open` Capacity Reservation that
    /// has matching attributes (instance type, platform, Availability Zone).
    ///
    /// * `none` - The instance avoids running in a Capacity Reservation even if one
    ///   is
    /// available. The instance runs in On-Demand capacity.
    capacity_reservation_preference: ?CapacityReservationPreference,

    /// Information about the targeted Capacity Reservation or Capacity Reservation
    /// group.
    capacity_reservation_target: ?CapacityReservationTargetResponse,
};
