/// A filter that specifies the custom line items and billing groups to retrieve
/// FFLI information.
pub const ListCustomLineItemsFilter = struct {
    /// The Amazon Web Services accounts in which this custom line item will be
    /// applied to.
    account_ids: ?[]const []const u8 = null,

    /// A list of custom line item ARNs to retrieve information.
    arns: ?[]const []const u8 = null,

    /// The billing group Amazon Resource Names (ARNs) to retrieve information.
    billing_groups: ?[]const []const u8 = null,

    /// A list of custom line items to retrieve information.
    names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .arns = "Arns",
        .billing_groups = "BillingGroups",
        .names = "Names",
    };
};
