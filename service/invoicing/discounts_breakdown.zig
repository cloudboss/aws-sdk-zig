const DiscountsBreakdownAmount = @import("discounts_breakdown_amount.zig").DiscountsBreakdownAmount;

/// The discounts details.
pub const DiscountsBreakdown = struct {
    /// The list of discounts information.
    breakdown: ?[]const DiscountsBreakdownAmount,

    /// The discount's total amount.
    total_amount: ?[]const u8,

    pub const json_field_names = .{
        .breakdown = "Breakdown",
        .total_amount = "TotalAmount",
    };
};
