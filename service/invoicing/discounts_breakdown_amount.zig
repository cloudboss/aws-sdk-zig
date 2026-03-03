/// The discounted amount.
pub const DiscountsBreakdownAmount = struct {
    /// The discounted amount.
    amount: ?[]const u8 = null,

    /// The list of discounts information.
    description: ?[]const u8 = null,

    /// The details for the discount rate..
    rate: ?[]const u8 = null,

    pub const json_field_names = .{
        .amount = "Amount",
        .description = "Description",
        .rate = "Rate",
    };
};
