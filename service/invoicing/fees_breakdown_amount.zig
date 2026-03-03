/// The fee amount.
pub const FeesBreakdownAmount = struct {
    /// The fee amount.
    amount: ?[]const u8 = null,

    /// The list of fees information.
    description: ?[]const u8 = null,

    /// Details about the rate amount.
    rate: ?[]const u8 = null,

    pub const json_field_names = .{
        .amount = "Amount",
        .description = "Description",
        .rate = "Rate",
    };
};
