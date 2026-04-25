const AccountJoinedMethod = @import("account_joined_method.zig").AccountJoinedMethod;
const AccountState = @import("account_state.zig").AccountState;
const AccountStatus = @import("account_status.zig").AccountStatus;

/// Contains information about an Amazon Web Services account that is a member
/// of an
/// organization.
pub const Account = struct {
    /// The Amazon Resource Name (ARN) of the account.
    ///
    /// For more information about ARNs in Organizations, see [ARN
    /// Formats Supported by
    /// Organizations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsorganizations.html#awsorganizations-resources-for-iam-policies) in the *Amazon Web Services Service Authorization Reference*.
    arn: ?[]const u8 = null,

    /// The email address associated with the Amazon Web Services account.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for this parameter is a
    /// string of characters that represents a
    /// standard internet email address.
    email: ?[]const u8 = null,

    /// The unique identifier (ID) of the account.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for an account ID
    /// string requires exactly 12
    /// digits.
    id: ?[]const u8 = null,

    /// The method by which the account joined the organization.
    joined_method: ?AccountJoinedMethod = null,

    /// The date the account became a part of the organization.
    joined_timestamp: ?i64 = null,

    /// The friendly name of the account.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: ?[]const u8 = null,

    /// The paths in the organization where the account exists.
    paths: ?[]const []const u8 = null,

    /// Each state represents a specific phase in the account lifecycle. Use this
    /// information
    /// to manage account access, automate workflows, or trigger actions based on
    /// account state
    /// changes.
    ///
    /// For more information about account states and their implications, see
    /// [Monitor the state of your Amazon Web Services accounts
    /// ](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_account_state.html) in the
    /// *Organizations User Guide*.
    state: ?AccountState = null,

    /// The status of the account in the organization.
    ///
    /// The `Status` parameter in the `Account` object will be retired on September
    /// 9, 2026.
    /// Although both the account `State` and account `Status` parameters are
    /// currently
    /// available in the Organizations APIs (`DescribeAccount`, `ListAccounts`,
    /// `ListAccountsForParent`), we recommend that you update your scripts or other
    /// code to
    /// use the `State` parameter instead of `Status` before September 9, 2026.
    status: ?AccountStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .email = "Email",
        .id = "Id",
        .joined_method = "JoinedMethod",
        .joined_timestamp = "JoinedTimestamp",
        .name = "Name",
        .paths = "Paths",
        .state = "State",
        .status = "Status",
    };
};
