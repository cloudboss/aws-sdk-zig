const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;

/// The Capacity Reservation configurations to be used when using the `RESERVED`
/// capacity option type.
pub const CapacityReservationRequest = struct {
    /// The ARN of the Capacity Reservation resource group in which to run the
    /// instance.
    reservation_group_arn: ?[]const u8 = null,

    /// The preference on when capacity reservations should be used.
    ///
    /// Valid values are:
    ///
    /// * `RESERVATIONS_ONLY` - Exclusively launch instances into capacity
    ///   reservations that match the instance requirements configured for the
    ///   capacity provider. If none exist, instances will fail to provision.
    /// * `RESERVATIONS_FIRST` - Prefer to launch instances into a capacity
    ///   reservation if any exist that match the instance requirements configured
    ///   for the capacity provider. If none exist, fall back to launching instances
    ///   On-Demand.
    /// * `RESERVATIONS_EXCLUDED` - Avoid using capacity reservations and launch
    ///   exclusively On-Demand.
    reservation_preference: ?CapacityReservationPreference = null,

    pub const json_field_names = .{
        .reservation_group_arn = "reservationGroupArn",
        .reservation_preference = "reservationPreference",
    };
};
