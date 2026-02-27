const DiscountsBreakdown = @import("discounts_breakdown.zig").DiscountsBreakdown;
const FeesBreakdown = @import("fees_breakdown.zig").FeesBreakdown;
const TaxesBreakdown = @import("taxes_breakdown.zig").TaxesBreakdown;

/// Details about how the total amount was calculated and categorized.
pub const AmountBreakdown = struct {
    /// The discounted amount.
    discounts: ?DiscountsBreakdown,

    /// The fee amount.
    fees: ?FeesBreakdown,

    /// The total of a set of the breakdown.
    sub_total_amount: ?[]const u8,

    /// The tax amount.
    taxes: ?TaxesBreakdown,

    pub const json_field_names = .{
        .discounts = "Discounts",
        .fees = "Fees",
        .sub_total_amount = "SubTotalAmount",
        .taxes = "Taxes",
    };
};
