const Currency = @import("currency.zig").Currency;

/// A summary of AI bot monetization revenue, including total revenue, revenue
/// by verification tier, and request counts.
pub const RevenueBreakdown = struct {
    /// The currency of the revenue amounts.
    currency: ?Currency = null,

    /// The total revenue amount in the specified currency.
    total_amount: ?[]const u8 = null,

    /// The total number of HTTP 402 Payment Required responses served to AI agents.
    total_monetize_served: i64 = 0,

    /// The total number of successfully settled payment transactions.
    total_settled: i64 = 0,

    /// The revenue amount from unverified AI bots.
    unverified_amount: ?[]const u8 = null,

    /// The revenue amount from verified AI bots.
    verified_amount: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency = "Currency",
        .total_amount = "TotalAmount",
        .total_monetize_served = "TotalMonetizeServed",
        .total_settled = "TotalSettled",
        .unverified_amount = "UnverifiedAmount",
        .verified_amount = "VerifiedAmount",
    };
};
