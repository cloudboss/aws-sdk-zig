const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const PaymentOption = @import("payment_option.zig").PaymentOption;

/// Describes the result of the purchase.
pub const Purchase = struct {
    /// The currency in which the `UpfrontPrice` and `HourlyPrice`
    /// amounts are specified. At this time, the only supported currency is
    /// `USD`.
    currency_code: ?CurrencyCodeValues = null,

    /// The duration of the reservation's term in seconds.
    duration: ?i32 = null,

    /// The IDs of the Dedicated Hosts associated with the reservation.
    host_id_set: ?[]const []const u8 = null,

    /// The ID of the reservation.
    host_reservation_id: ?[]const u8 = null,

    /// The hourly price of the reservation per hour.
    hourly_price: ?[]const u8 = null,

    /// The instance family on the Dedicated Host that the reservation can be
    /// associated
    /// with.
    instance_family: ?[]const u8 = null,

    /// The payment option for the reservation.
    payment_option: ?PaymentOption = null,

    /// The upfront price of the reservation.
    upfront_price: ?[]const u8 = null,
};
