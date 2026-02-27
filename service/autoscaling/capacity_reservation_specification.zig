const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;
const CapacityReservationTarget = @import("capacity_reservation_target.zig").CapacityReservationTarget;

/// Describes the Capacity Reservation preference and targeting options. If you
/// specify `open` or `none` for `CapacityReservationPreference`, do not specify
/// a `CapacityReservationTarget`.
pub const CapacityReservationSpecification = struct {
    /// The capacity reservation preference. The following options are available:
    ///
    /// * `capacity-reservations-only` - Auto Scaling will only launch instances
    ///   into a Capacity Reservation or Capacity Reservation resource group. If
    ///   capacity isn't available, instances will fail to launch.
    ///
    /// * `capacity-reservations-first` - Auto Scaling will try to launch instances
    ///   into a Capacity Reservation or Capacity Reservation resource group first.
    ///   If capacity isn't available, instances will run in On-Demand capacity.
    ///
    /// * `none` - Auto Scaling will not launch instances into a Capacity
    ///   Reservation. Instances will run in On-Demand capacity.
    ///
    /// * `default` - Auto Scaling uses the Capacity Reservation preference from
    ///   your launch template or an open Capacity Reservation.
    capacity_reservation_preference: ?CapacityReservationPreference,

    /// Describes a target Capacity Reservation or Capacity Reservation resource
    /// group.
    capacity_reservation_target: ?CapacityReservationTarget,
};
