const FeesBreakdownAmount = @import("fees_breakdown_amount.zig").FeesBreakdownAmount;

/// The details of fees.
pub const FeesBreakdown = struct {
    /// The list of fees information.
    breakdown: ?[]const FeesBreakdownAmount,

    /// The total amount of fees.
    total_amount: ?[]const u8,

    pub const json_field_names = .{
        .breakdown = "Breakdown",
        .total_amount = "TotalAmount",
    };
};
