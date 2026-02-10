const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;
const CapacityReservationTarget = @import("capacity_reservation_target.zig").CapacityReservationTarget;

/// Describes an instance's Capacity Reservation targeting option. You can
/// specify only
/// one option at a time. Use the `CapacityReservationPreference` parameter to
/// configure the instance to run in On-Demand capacity or to run in any `open`
/// Capacity Reservation that has matching attributes (instance type, platform,
/// Availability
/// Zone). Use the `CapacityReservationTarget` parameter to explicitly target a
/// specific Capacity Reservation or a Capacity Reservation group.
pub const LaunchTemplateCapacityReservationSpecificationRequest = struct {
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
    /// Zone, tenancy).
    ///
    /// * `none` - The instance avoids running in a Capacity Reservation even
    /// if one is available. The instance runs in On-Demand capacity.
    capacity_reservation_preference: ?CapacityReservationPreference,

    /// Information about the target Capacity Reservation or Capacity Reservation
    /// group.
    capacity_reservation_target: ?CapacityReservationTarget,
};
