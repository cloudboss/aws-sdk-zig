/// The EC2 instance Savings Plans configuration used for recommendations.
pub const Ec2InstanceSavingsPlansConfiguration = struct {
    /// The account scope for which you want recommendations.
    account_scope: ?[]const u8 = null,

    /// The hourly commitment for the Savings Plans type.
    hourly_commitment: ?[]const u8 = null,

    /// The instance family of the recommended Savings Plans.
    instance_family: ?[]const u8 = null,

    /// The payment option for the commitment.
    payment_option: ?[]const u8 = null,

    /// The Amazon Web Services Region of the commitment.
    savings_plans_region: ?[]const u8 = null,

    /// The Savings Plans recommendation term in years.
    term: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_scope = "accountScope",
        .hourly_commitment = "hourlyCommitment",
        .instance_family = "instanceFamily",
        .payment_option = "paymentOption",
        .savings_plans_region = "savingsPlansRegion",
        .term = "term",
    };
};
