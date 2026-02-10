const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const PaymentOption = @import("payment_option.zig").PaymentOption;

/// Describes the result of the purchase.
pub const Purchase = struct {
    /// The currency in which the `UpfrontPrice` and `HourlyPrice`
    /// amounts are specified. At this time, the only supported currency is
    /// `USD`.
    currency_code: ?CurrencyCodeValues,

    /// The duration of the reservation's term in seconds.
    duration: ?i32,

    /// The IDs of the Dedicated Hosts associated with the reservation.
    host_id_set: ?[]const []const u8,

    /// The ID of the reservation.
    host_reservation_id: ?[]const u8,

    /// The hourly price of the reservation per hour.
    hourly_price: ?[]const u8,

    /// The instance family on the Dedicated Host that the reservation can be
    /// associated
    /// with.
    instance_family: ?[]const u8,

    /// The payment option for the reservation.
    payment_option: ?PaymentOption,

    /// The upfront price of the reservation.
    upfront_price: ?[]const u8,
};
