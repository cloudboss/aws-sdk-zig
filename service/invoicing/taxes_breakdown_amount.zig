/// The tax amount.
pub const TaxesBreakdownAmount = struct {
    /// The tax amount.
    amount: ?[]const u8,

    /// The details of the taxes.
    description: ?[]const u8,

    /// The details of the tax rate.
    rate: ?[]const u8,

    pub const json_field_names = .{
        .amount = "Amount",
        .description = "Description",
        .rate = "Rate",
    };
};
