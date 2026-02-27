const AccountStatus = @import("account_status.zig").AccountStatus;
const AccountType = @import("account_type.zig").AccountType;
const License = @import("license.zig").License;
const SigninDelegateGroup = @import("signin_delegate_group.zig").SigninDelegateGroup;

/// The Amazon Chime account details. An AWS account can have multiple Amazon
/// Chime accounts.
pub const Account = struct {
    /// The Amazon Chime account ID.
    account_id: []const u8,

    /// The status of the account.
    account_status: ?AccountStatus,

    /// The Amazon Chime account type. For more information about different account
    /// types, see
    /// [Managing Your Amazon Chime
    /// Accounts](https://docs.aws.amazon.com/chime/latest/ag/manage-chime-account.html) in the *Amazon Chime Administration
    /// Guide*.
    account_type: ?AccountType,

    /// The AWS account ID.
    aws_account_id: []const u8,

    /// The Amazon Chime account creation timestamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// The default license for the Amazon Chime account.
    default_license: ?License,

    /// The Amazon Chime account name.
    name: []const u8,

    /// The sign-in delegate groups associated with the account.
    signin_delegate_groups: ?[]const SigninDelegateGroup,

    /// Supported licenses for the Amazon Chime account.
    supported_licenses: ?[]const License,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_status = "AccountStatus",
        .account_type = "AccountType",
        .aws_account_id = "AwsAccountId",
        .created_timestamp = "CreatedTimestamp",
        .default_license = "DefaultLicense",
        .name = "Name",
        .signin_delegate_groups = "SigninDelegateGroups",
        .supported_licenses = "SupportedLicenses",
    };
};
