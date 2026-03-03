/// Represents information about free trial device minutes for an AWS
/// account.
pub const TrialMinutes = struct {
    /// The number of free trial minutes remaining in the account.
    remaining: ?f64 = null,

    /// The total number of free trial minutes that the account started with.
    total: ?f64 = null,

    pub const json_field_names = .{
        .remaining = "remaining",
        .total = "total",
    };
};
