const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const ReservationState = @import("reservation_state.zig").ReservationState;
const Tag = @import("tag.zig").Tag;

/// Details about the Dedicated Host Reservation and associated Dedicated Hosts.
pub const HostReservation = struct {
    /// The number of Dedicated Hosts the reservation is associated with.
    count: ?i32,

    /// The currency in which the `upfrontPrice` and `hourlyPrice`
    /// amounts are specified. At this time, the only supported currency is
    /// `USD`.
    currency_code: ?CurrencyCodeValues,

    /// The length of the reservation's term, specified in seconds. Can be `31536000
    /// (1
    /// year)` | `94608000 (3 years)`.
    duration: ?i32,

    /// The date and time that the reservation ends.
    end: ?i64,

    /// The IDs of the Dedicated Hosts associated with the reservation.
    host_id_set: ?[]const []const u8,

    /// The ID of the reservation that specifies the associated Dedicated Hosts.
    host_reservation_id: ?[]const u8,

    /// The hourly price of the reservation.
    hourly_price: ?[]const u8,

    /// The instance family of the Dedicated Host Reservation. The instance family
    /// on the
    /// Dedicated Host must be the same in order for it to benefit from the
    /// reservation.
    instance_family: ?[]const u8,

    /// The ID of the reservation. This remains the same regardless of which
    /// Dedicated Hosts
    /// are associated with it.
    offering_id: ?[]const u8,

    /// The payment option selected for this reservation.
    payment_option: ?PaymentOption,

    /// The date and time that the reservation started.
    start: ?i64,

    /// The state of the reservation.
    state: ?ReservationState,

    /// Any tags assigned to the Dedicated Host Reservation.
    tags: ?[]const Tag,

    /// The upfront price of the reservation.
    upfront_price: ?[]const u8,
};
