const GroupIdentity = @import("group_identity.zig").GroupIdentity;
const IAMRoleIdentity = @import("iam_role_identity.zig").IAMRoleIdentity;
const IAMUserIdentity = @import("iam_user_identity.zig").IAMUserIdentity;
const UserIdentity = @import("user_identity.zig").UserIdentity;

/// Contains an identity that can access an IoT SiteWise Monitor resource.
///
/// Currently, you can't use Amazon Web Services API operations to retrieve IAM
/// Identity Center identity IDs. You can
/// find the IAM Identity Center identity IDs in the URL of user and group pages
/// in the [IAM Identity Center
/// console](https://console.aws.amazon.com/singlesignon).
pub const Identity = struct {
    /// An IAM Identity Center group identity.
    group: ?GroupIdentity,

    /// An IAM role identity.
    iam_role: ?IAMRoleIdentity,

    /// An IAM user identity.
    iam_user: ?IAMUserIdentity,

    /// An IAM Identity Center user identity.
    user: ?UserIdentity,

    pub const json_field_names = .{
        .group = "group",
        .iam_role = "iamRole",
        .iam_user = "iamUser",
        .user = "user",
    };
};
