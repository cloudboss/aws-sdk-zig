/// An optional input to the list API. If multiple filters are specified, the
/// returned list will be a configuration that match all of the provided
/// filters. Supported filter types are `InvoiceReceivers`, `Names`, and
/// `Accounts`.
pub const Filters = struct {
    /// You can specify a list of Amazon Web Services account IDs inside filters to
    /// return invoice units that match only the specified accounts. If multiple
    /// accounts are provided, the result is an `OR` condition (match any) of the
    /// specified accounts. The specified account IDs are matched with either the
    /// receiver or the linked accounts in the rules.
    accounts: ?[]const []const u8 = null,

    /// A list of Amazon Web Services account account IDs used to filter invoice
    /// units. These are payer accounts from other Organizations that have delegated
    /// their billing responsibility to the receiver account through the billing
    /// transfer feature.
    bill_source_accounts: ?[]const []const u8 = null,

    /// You can specify a list of Amazon Web Services account IDs inside filters to
    /// return invoice units that match only the specified accounts. If multiple
    /// accounts are provided, the result is an `OR` condition (match any) of the
    /// specified accounts. This filter only matches the specified accounts on the
    /// invoice receivers of the invoice units.
    invoice_receivers: ?[]const []const u8 = null,

    /// An optional input to the list API. You can specify a list of invoice unit
    /// names inside filters to return invoice units that match only the specified
    /// invoice unit names. If multiple names are provided, the result is an `OR`
    /// condition (match any) of the specified invoice unit names.
    names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .accounts = "Accounts",
        .bill_source_accounts = "BillSourceAccounts",
        .invoice_receivers = "InvoiceReceivers",
        .names = "Names",
    };
};
