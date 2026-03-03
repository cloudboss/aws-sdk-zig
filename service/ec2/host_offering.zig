const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const PaymentOption = @import("payment_option.zig").PaymentOption;

/// Details about the Dedicated Host Reservation offering.
pub const HostOffering = struct {
    /// The currency of the offering.
    currency_code: ?CurrencyCodeValues = null,

    /// The duration of the offering (in seconds).
    duration: ?i32 = null,

    /// The hourly price of the offering.
    hourly_price: ?[]const u8 = null,

    /// The instance family of the offering.
    instance_family: ?[]const u8 = null,

    /// The ID of the offering.
    offering_id: ?[]const u8 = null,

    /// The available payment option.
    payment_option: ?PaymentOption = null,

    /// The upfront price of the offering. Does not apply to No Upfront offerings.
    upfront_price: ?[]const u8 = null,
};
