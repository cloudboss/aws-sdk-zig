const IamUserProfileDetails = @import("iam_user_profile_details.zig").IamUserProfileDetails;
const SsoUserProfileDetails = @import("sso_user_profile_details.zig").SsoUserProfileDetails;

/// The user profile details.
pub const UserProfileDetails = union(enum) {
    /// The IAM details of the user profile.
    iam: ?IamUserProfileDetails,
    /// The SSO details of the user profile.
    sso: ?SsoUserProfileDetails,

    pub const json_field_names = .{
        .iam = "iam",
        .sso = "sso",
    };
};
