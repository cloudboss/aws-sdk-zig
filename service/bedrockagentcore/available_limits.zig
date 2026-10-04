const Amount = @import("amount.zig").Amount;

/// The available spending limits for a payment session.
pub const AvailableLimits = struct {
    /// The remaining available amount that can be spent.
    available_spend_amount: ?Amount = null,

    /// The timestamp when the available limits were last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .available_spend_amount = "availableSpendAmount",
        .updated_at = "updatedAt",
    };
};
