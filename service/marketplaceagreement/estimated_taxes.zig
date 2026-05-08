const TaxBreakdownItem = @import("tax_breakdown_item.zig").TaxBreakdownItem;

/// Provides an aggregated view of estimated tax information.
pub const EstimatedTaxes = struct {
    /// A list of tax breakdown information.
    breakdown: ?[]const TaxBreakdownItem = null,

    /// The total amount of tax aggregated from the tax breakdown.
    total_amount: ?[]const u8 = null,

    pub const json_field_names = .{
        .breakdown = "breakdown",
        .total_amount = "totalAmount",
    };
};
