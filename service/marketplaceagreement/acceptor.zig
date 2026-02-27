/// The details of the party accepting the agreement terms. This is commonly the
/// buyer for `PurchaseAgreement`.
pub const Acceptor = struct {
    /// The AWS account ID of the acceptor.
    account_id: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
