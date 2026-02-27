/// Details of the party proposing the agreement terms,. This is commonly the
/// seller for `PurchaseAgreement`.
pub const Proposer = struct {
    /// The AWS account ID of the proposer.
    account_id: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
