const AccountJoinedMethod = @import("account_joined_method.zig").AccountJoinedMethod;
const AccountState = @import("account_state.zig").AccountState;
const AccountStatus = @import("account_status.zig").AccountStatus;

/// Contains information about the delegated administrator.
pub const DelegatedAdministrator = struct {
    /// The Amazon Resource Name (ARN) of the delegated administrator's account.
    arn: ?[]const u8,

    /// The date when the account was made a delegated administrator.
    delegation_enabled_date: ?i64,

    /// The email address that is associated with the delegated administrator's
    /// Amazon Web Services
    /// account.
    email: ?[]const u8,

    /// The unique identifier (ID) of the delegated administrator's account.
    id: ?[]const u8,

    /// The method by which the delegated administrator's account joined the
    /// organization.
    joined_method: ?AccountJoinedMethod,

    /// The date when the delegated administrator's account became a part of the
    /// organization.
    joined_timestamp: ?i64,

    /// The friendly name of the delegated administrator's account.
    name: ?[]const u8,

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
    state: ?AccountState,

    /// The status of the delegated administrator's account in the organization.
    status: ?AccountStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .delegation_enabled_date = "DelegationEnabledDate",
        .email = "Email",
        .id = "Id",
        .joined_method = "JoinedMethod",
        .joined_timestamp = "JoinedTimestamp",
        .name = "Name",
        .state = "State",
        .status = "Status",
    };
};
