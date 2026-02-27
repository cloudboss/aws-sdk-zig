/// The Compute Savings Plans configuration used for recommendations.
pub const ComputeSavingsPlansConfiguration = struct {
    /// The account scope for which you want recommendations. Amazon Web Services
    /// calculates recommendations including the management account and member
    /// accounts if the value is set to `PAYER`. If the value is `LINKED`,
    /// recommendations are calculated for individual member accounts only.
    account_scope: ?[]const u8,

    /// The hourly commitment for the Savings Plans type.
    hourly_commitment: ?[]const u8,

    /// The payment option for the commitment.
    payment_option: ?[]const u8,

    /// The Savings Plans recommendation term in years.
    term: ?[]const u8,

    pub const json_field_names = .{
        .account_scope = "accountScope",
        .hourly_commitment = "hourlyCommitment",
        .payment_option = "paymentOption",
        .term = "term",
    };
};
