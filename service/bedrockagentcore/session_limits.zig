const Amount = @import("amount.zig").Amount;

/// The spending limits configuration for a payment session.
pub const SessionLimits = struct {
    /// The maximum amount that can be spent in the session.
    max_spend_amount: Amount,

    pub const json_field_names = .{
        .max_spend_amount = "maxSpendAmount",
    };
};
