/// The capacity reservation configuration for Amazon ECS Managed Instances. Use
/// this to target
/// On-Demand Capacity Reservations or Reserved Instances.
pub const CapacityReservationRequest = struct {
    /// The Amazon Resource Name (ARN) of the capacity reservation group to target.
    reservation_group_arn: ?[]const u8 = null,

    /// The capacity reservation preference. Valid values:
    ///
    /// * `RESERVATIONS_ONLY` — Use only capacity reservations.
    ///
    /// * `RESERVATIONS_FIRST` — Prefer capacity reservations but fall back to
    /// On-Demand if unavailable.
    ///
    /// * `RESERVATIONS_EXCLUDED` — Do not use capacity reservations.
    reservation_preference: ?[]const u8 = null,

    pub const json_field_names = .{
        .reservation_group_arn = "reservationGroupArn",
        .reservation_preference = "reservationPreference",
    };
};
