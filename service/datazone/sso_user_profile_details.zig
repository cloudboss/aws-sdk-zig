/// The SSO user profile detail.
pub const SsoUserProfileDetails = struct {
    /// The first name as part of the SSO user profile detail.
    first_name: ?[]const u8,

    /// The last name as part of the SSO user profile detail.
    last_name: ?[]const u8,

    /// The username as part of the SSO user profile detail.
    username: ?[]const u8,

    pub const json_field_names = .{
        .first_name = "firstName",
        .last_name = "lastName",
        .username = "username",
    };
};
