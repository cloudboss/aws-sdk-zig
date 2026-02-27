/// This is used to categorize the invoice unit. Values are Amazon Web Services
/// account IDs. Currently, the only supported rule is `LINKED_ACCOUNT`.
pub const InvoiceUnitRule = struct {
    /// A list of Amazon Web Services account account IDs that have delegated their
    /// billing responsibility to the receiver account through transfer billing.
    /// Unlike linked accounts, these bill source accounts can be payer accounts
    /// from other organizations that have authorized billing transfer to this
    /// account.
    bill_source_accounts: ?[]const []const u8,

    /// The list of `LINKED_ACCOUNT` IDs where charges are included within the
    /// invoice unit.
    linked_accounts: ?[]const []const u8,

    pub const json_field_names = .{
        .bill_source_accounts = "BillSourceAccounts",
        .linked_accounts = "LinkedAccounts",
    };
};
