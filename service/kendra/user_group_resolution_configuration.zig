const UserGroupResolutionMode = @import("user_group_resolution_mode.zig").UserGroupResolutionMode;

/// Provides the configuration information to get users and groups from an IAM
/// Identity Center identity source. This is useful for user context filtering,
/// where search
/// results are filtered based on the user or their group access to documents.
/// You can also use
/// the
/// [PutPrincipalMapping](https://docs.aws.amazon.com/kendra/latest/dg/API_PutPrincipalMapping.html) API to map users to their groups so that you only need to
/// provide the user ID when you issue the query.
///
/// To set up an IAM Identity Center identity source in the console to use with
/// Amazon Kendra, see [Getting started with an IAM Identity Center identity
/// source](https://docs.aws.amazon.com/kendra/latest/dg/getting-started-aws-sso.html). You must also grant the required permissions to
/// use IAM Identity Center with Amazon Kendra. For more information, see [IAM
/// roles for IAM Identity
/// Center](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html#iam-roles-aws-sso).
///
/// Amazon Kendra currently does not support using
/// `UserGroupResolutionConfiguration` with an Amazon Web Services organization
/// member account for your IAM Identity Center identify source. You must create
/// your index in
/// the management account for the organization in order to use
/// `UserGroupResolutionConfiguration`.
///
/// If you're using an Amazon Kendra Gen AI Enterprise Edition index,
/// `UserGroupResolutionConfiguration` isn't supported.
pub const UserGroupResolutionConfiguration = struct {
    /// The identity store provider (mode) you want to use to get users and groups.
    /// IAM Identity Center is currently the only available mode. Your users and
    /// groups must exist in
    /// an IAM Identity Center identity source in order to use this mode.
    user_group_resolution_mode: UserGroupResolutionMode,

    pub const json_field_names = .{
        .user_group_resolution_mode = "UserGroupResolutionMode",
    };
};
