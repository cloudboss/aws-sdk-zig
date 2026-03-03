const ReservationValue = @import("reservation_value.zig").ReservationValue;

/// The total value of the Convertible Reserved Instance.
pub const ReservedInstanceReservationValue = struct {
    /// The total value of the Convertible Reserved Instance that you are
    /// exchanging.
    reservation_value: ?ReservationValue = null,

    /// The ID of the Convertible Reserved Instance that you are exchanging.
    reserved_instance_id: ?[]const u8 = null,
};
