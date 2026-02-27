const MonetaryAmount = @import("monetary_amount.zig").MonetaryAmount;

/// The summary of the rewards granted as a result of activities completed.
pub const ActivityReward = union(enum) {
    /// The credits gained by activity rewards.
    credit: ?MonetaryAmount,

    pub const json_field_names = .{
        .credit = "credit",
    };
};
