const Amount = @import("amount.zig").Amount;

/// Session spending limits
pub const SessionLimits = struct {
    /// The maximum amount that can be spent in this session.
    max_spend_amount: Amount,

    pub const json_field_names = .{
        .max_spend_amount = "maxSpendAmount",
    };
};
