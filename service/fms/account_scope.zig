/// Configures the accounts within the administrator's Organizations
/// organization that the specified Firewall Manager administrator can apply
/// policies to.
pub const AccountScope = struct {
    /// The list of accounts within the organization that the specified Firewall
    /// Manager administrator either can or cannot apply policies to, based on the
    /// value of `ExcludeSpecifiedAccounts`. If `ExcludeSpecifiedAccounts` is set to
    /// `true`, then the Firewall Manager administrator can apply policies to all
    /// members of the organization except for the accounts in this list. If
    /// `ExcludeSpecifiedAccounts` is set to `false`, then the Firewall Manager
    /// administrator can only apply policies to the accounts in this list.
    accounts: ?[]const []const u8 = null,

    /// A boolean value that indicates if the administrator can apply policies to
    /// all accounts within an organization. If true, the administrator can apply
    /// policies to all accounts within the organization. You can either enable
    /// management of all accounts through this operation, or you can specify a list
    /// of accounts to manage in `AccountScope$Accounts`. You cannot specify both.
    all_accounts_enabled: bool = false,

    /// A boolean value that excludes the accounts in `AccountScope$Accounts` from
    /// the administrator's scope. If true, the Firewall Manager administrator can
    /// apply policies to all members of the organization except for the accounts
    /// listed in `AccountScope$Accounts`. You can either specify a list of accounts
    /// to exclude by `AccountScope$Accounts`, or you can enable management of all
    /// accounts by `AccountScope$AllAccountsEnabled`. You cannot specify both.
    exclude_specified_accounts: bool = false,

    pub const json_field_names = .{
        .accounts = "Accounts",
        .all_accounts_enabled = "AllAccountsEnabled",
        .exclude_specified_accounts = "ExcludeSpecifiedAccounts",
    };
};
