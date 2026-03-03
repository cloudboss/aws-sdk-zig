const GrantItem = @import("grant_item.zig").GrantItem;

/// Defines a short-term free pricing model where the buyers aren’t charged
/// anything within a specified limit.
pub const FreeTrialPricingTerm = struct {
    /// Duration of the free trial period (5–31 days).
    duration: ?[]const u8 = null,

    /// Entitlements granted to the acceptor of a free trial as part of an agreement
    /// execution.
    grants: ?[]const GrantItem = null,

    /// Category of the term.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .duration = "duration",
        .grants = "grants",
        .@"type" = "type",
    };
};
