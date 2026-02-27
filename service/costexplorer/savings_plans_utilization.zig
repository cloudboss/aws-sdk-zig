/// The measurement of how well you're using your existing Savings Plans.
pub const SavingsPlansUtilization = struct {
    /// The total amount of Savings Plans commitment that's been purchased in an
    /// account (or
    /// set of accounts).
    total_commitment: ?[]const u8,

    /// The amount of your Savings Plans commitment that wasn't consumed from
    /// Savings Plans
    /// eligible usage in a specific period.
    unused_commitment: ?[]const u8,

    /// The amount of your Savings Plans commitment that was consumed from Savings
    /// Plans
    /// eligible usage in a specific period.
    used_commitment: ?[]const u8,

    /// The amount of `UsedCommitment` divided by the `TotalCommitment`
    /// for your Savings Plans.
    utilization_percentage: ?[]const u8,

    pub const json_field_names = .{
        .total_commitment = "TotalCommitment",
        .unused_commitment = "UnusedCommitment",
        .used_commitment = "UsedCommitment",
        .utilization_percentage = "UtilizationPercentage",
    };
};
