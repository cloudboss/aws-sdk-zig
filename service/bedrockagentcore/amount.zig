const Currency = @import("currency.zig").Currency;

/// Money amount with currency
pub const Amount = struct {
    /// The currency code for this amount.
    currency: Currency,

    /// The numeric value of the amount.
    value: []const u8,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
