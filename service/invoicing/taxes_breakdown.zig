const TaxesBreakdownAmount = @import("taxes_breakdown_amount.zig").TaxesBreakdownAmount;

/// The details of the taxes.
pub const TaxesBreakdown = struct {
    /// A list of tax information.
    breakdown: ?[]const TaxesBreakdownAmount = null,

    /// The total amount for your taxes.
    total_amount: ?[]const u8 = null,

    pub const json_field_names = .{
        .breakdown = "Breakdown",
        .total_amount = "TotalAmount",
    };
};
