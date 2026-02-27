/// The fee amount.
pub const FeesBreakdownAmount = struct {
    /// The fee amount.
    amount: ?[]const u8,

    /// The list of fees information.
    description: ?[]const u8,

    /// Details about the rate amount.
    rate: ?[]const u8,

    pub const json_field_names = .{
        .amount = "Amount",
        .description = "Description",
        .rate = "Rate",
    };
};
