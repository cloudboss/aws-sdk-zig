const AccountFilterType = @import("account_filter_type.zig").AccountFilterType;

/// Specifies the Organizations accounts where you want to create, update, or
/// delete
/// stack instances. You can target either your entire organization or specific
/// accounts using
/// organizational units (OUs) and account filter options.
///
/// CloudFormation doesn't deploy stack instances to the organization management
/// account, even if the organization management account is in your organization
/// or in an OU
/// in your organization.
///
/// When performing create operations, if you specify both
/// `OrganizationalUnitIds`
/// and `Accounts`, you must also specify the `AccountFilterType` property.
pub const DeploymentTargets = struct {
    /// Refines which accounts will have stack operations performed on them by
    /// specifying how to use
    /// the `Accounts` and `OrganizationalUnitIds` properties together.
    ///
    /// The following values determine how CloudFormation selects target accounts:
    ///
    /// * `INTERSECTION`: Performs stack operations only on specific individual
    ///   accounts
    /// within the selected OUs. Only accounts that are both specified in the
    /// `Accounts`
    /// property and belong to the specified OUs will be targeted.
    ///
    /// * `DIFFERENCE`: Performs stack operations on all accounts in the selected
    ///   OUs
    /// except for specific accounts listed in the `Accounts` property. This enables
    /// you to
    /// exclude certain accounts within an OU, such as suspended accounts.
    ///
    /// * `UNION`: Performs stack operations on the specified OUs plus additional
    /// individual accounts listed in the `Accounts` property. This is the default
    /// value if
    /// `AccountFilterType` is not provided. This lets you target an entire OU and
    /// individual accounts from a different OU in one request. Note that `UNION` is
    /// not
    /// supported for `CreateStackInstances` operations.
    ///
    /// * `NONE`: Performs stack operations on all accounts in the specified
    /// organizational units (OUs).
    account_filter_type: ?AccountFilterType = null,

    /// The Amazon Web Services account IDs where you want to perform stack
    /// operations. How these accounts are
    /// used depends on the `AccountFilterType` property.
    ///
    /// If you have many account numbers, you can provide those accounts using the
    /// `AccountsUrl` property instead.
    accounts: ?[]const []const u8 = null,

    /// The Amazon S3 URL path to a file that contains a list of Amazon Web Services
    /// account IDs. The file
    /// format must be either `.csv` or `.txt`, and the data can be comma-separated
    /// or new-line-separated. There is currently a 10MB limit for the data
    /// (approximately 800,000
    /// accounts).
    ///
    /// This property serves the same purpose as `Accounts` but allows you to
    /// specify a
    /// large number of accounts.
    accounts_url: ?[]const u8 = null,

    /// The organization root ID or organizational unit (OU) IDs where you want to
    /// perform stack
    /// operations. CloudFormation will perform operations on accounts within these
    /// OUs and their child
    /// OUs.
    organizational_unit_ids: ?[]const []const u8 = null,
};
