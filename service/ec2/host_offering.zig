const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const PaymentOption = @import("payment_option.zig").PaymentOption;

/// Details about the Dedicated Host Reservation offering.
pub const HostOffering = struct {
    /// The currency of the offering.
    currency_code: ?CurrencyCodeValues,

    /// The duration of the offering (in seconds).
    duration: ?i32,

    /// The hourly price of the offering.
    hourly_price: ?[]const u8,

    /// The instance family of the offering.
    instance_family: ?[]const u8,

    /// The ID of the offering.
    offering_id: ?[]const u8,

    /// The available payment option.
    payment_option: ?PaymentOption,

    /// The upfront price of the offering. Does not apply to No Upfront offerings.
    upfront_price: ?[]const u8,
};
