const FeesBreakdownAmount = @import("fees_breakdown_amount.zig").FeesBreakdownAmount;

/// The details of fees.
pub const FeesBreakdown = struct {
    /// The list of fees information.
    breakdown: ?[]const FeesBreakdownAmount = null,

    /// The total amount of fees.
    total_amount: ?[]const u8 = null,

    pub const json_field_names = .{
        .breakdown = "Breakdown",
        .total_amount = "TotalAmount",
    };
};
