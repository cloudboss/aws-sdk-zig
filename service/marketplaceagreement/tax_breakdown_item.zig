/// Represents a single tax breakdown entry with amount, rate, and type.
pub const TaxBreakdownItem = struct {
    /// The estimated tax amount.
    amount: ?[]const u8 = null,

    /// The tax rate, in decimals.
    rate: ?[]const u8 = null,

    /// The type of tax (for example, VAT, ST, or GST).
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .amount = "amount",
        .rate = "rate",
        .@"type" = "type",
    };
};
