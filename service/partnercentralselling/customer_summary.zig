const AccountSummary = @import("account_summary.zig").AccountSummary;

/// An object that contains a `Customer` object's subset of fields.
pub const CustomerSummary = struct {
    /// An object that contains a customer's account details.
    account: ?AccountSummary,

    pub const json_field_names = .{
        .account = "Account",
    };
};
