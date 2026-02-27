/// The amortized amount of Savings Plans purchased in a specific account during
/// a
/// specific time interval.
pub const SavingsPlansAmortizedCommitment = struct {
    /// The amortized amount of your Savings Plans commitment that was purchased
    /// with either a
    /// `Partial` or a `NoUpfront`.
    amortized_recurring_commitment: ?[]const u8,

    /// The amortized amount of your Savings Plans commitment that was purchased
    /// with an
    /// `Upfront` or `PartialUpfront` Savings Plans.
    amortized_upfront_commitment: ?[]const u8,

    /// The total amortized amount of your Savings Plans commitment, regardless of
    /// your
    /// Savings Plans purchase method.
    total_amortized_commitment: ?[]const u8,

    pub const json_field_names = .{
        .amortized_recurring_commitment = "AmortizedRecurringCommitment",
        .amortized_upfront_commitment = "AmortizedUpfrontCommitment",
        .total_amortized_commitment = "TotalAmortizedCommitment",
    };
};
