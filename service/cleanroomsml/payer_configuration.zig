/// Specifies which member accounts are responsible for paying for compute and
/// synthetic data generation costs in a Clean Rooms ML collaboration.
pub const PayerConfiguration = struct {
    /// The account ID of the member that is responsible for paying compute costs.
    compute_payer_account_id: ?[]const u8 = null,

    /// The account ID of the member that is responsible for paying synthetic data
    /// generation costs.
    synthetic_data_payer_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_payer_account_id = "computePayerAccountId",
        .synthetic_data_payer_account_id = "syntheticDataPayerAccountId",
    };
};
