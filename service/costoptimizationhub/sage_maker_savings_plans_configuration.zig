/// The SageMaker Savings Plans configuration used for recommendations.
pub const SageMakerSavingsPlansConfiguration = struct {
    /// The account scope for which you want recommendations.
    account_scope: ?[]const u8 = null,

    /// The hourly commitment for the Savings Plans type.
    hourly_commitment: ?[]const u8 = null,

    /// The payment option for the commitment.
    payment_option: ?[]const u8 = null,

    /// The Savings Plans recommendation term in years.
    term: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_scope = "accountScope",
        .hourly_commitment = "hourlyCommitment",
        .payment_option = "paymentOption",
        .term = "term",
    };
};
