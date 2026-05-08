const Amount = @import("amount.zig").Amount;

/// Available session limits. Currently only budget is supported.
pub const AvailableLimits = struct {
    /// The available spend amount for this session.
    available_spend_amount: ?Amount = null,

    /// The timestamp when the available limits were last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .available_spend_amount = "availableSpendAmount",
        .updated_at = "updatedAt",
    };
};
