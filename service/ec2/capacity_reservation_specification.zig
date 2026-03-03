const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;
const CapacityReservationTarget = @import("capacity_reservation_target.zig").CapacityReservationTarget;

/// Describes an instance's Capacity Reservation targeting option.
///
/// Use the `CapacityReservationPreference` parameter to configure the instance
/// to run as an On-Demand Instance, to run in any `open` Capacity Reservation
/// that has matching attributes, or to run only in a Capacity Reservation or
/// Capacity
/// Reservation group. Use the `CapacityReservationTarget` parameter to
/// explicitly target a specific Capacity Reservation or a Capacity Reservation
/// group.
///
/// You can only specify `CapacityReservationPreference` and
/// `CapacityReservationTarget` if the
/// `CapacityReservationPreference` is
/// `capacity-reservations-only`.
pub const CapacityReservationSpecification = struct {
    /// Indicates the instance's Capacity Reservation preferences. Possible
    /// preferences
    /// include:
    ///
    /// * `capacity-reservations-only` - The instance will only run in a
    /// Capacity Reservation or Capacity Reservation group. If capacity isn't
    /// available,
    /// the instance will fail to launch.
    ///
    /// * `open` - The instance can run in any `open` Capacity
    /// Reservation that has matching attributes (instance type, platform,
    /// Availability
    /// Zone, and tenancy). If capacity isn't available, the instance runs as an
    /// On-Demand Instance.
    ///
    /// * `none` - The instance doesn't run in a Capacity Reservation even if
    /// one is available. The instance runs as an On-Demand Instance.
    capacity_reservation_preference: ?CapacityReservationPreference = null,

    /// Information about the target Capacity Reservation or Capacity Reservation
    /// group.
    capacity_reservation_target: ?CapacityReservationTarget = null,
};
