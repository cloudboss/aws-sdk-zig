/// A Business Support subscription contract for an account.
pub const BusinessSupportSubscriptionContract = struct {
    /// The account ID associated with this subscription contract.
    account_id: []const u8,

    /// The end date of the subscription contract.
    contract_end_date: i64,

    /// The start date of the subscription contract.
    contract_start_date: i64,

    /// The name of the Support plan for this subscription contract. Valid values:
    /// `AWSSupportBusiness` (Business Support plan), `AWSSupportDeveloper`
    /// (Developer Support plan), `AWSSupportEssential` (Basic Support plan).
    plan_name: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .contract_end_date = "contractEndDate",
        .contract_start_date = "contractStartDate",
        .plan_name = "planName",
    };
};
