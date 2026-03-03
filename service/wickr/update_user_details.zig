/// Contains the modifiable details for updating an existing user, including
/// name, password, security group membership, and invitation settings.
///
/// A user can only be assigned to a single security group. Attempting to add a
/// user to multiple security groups is not supported and will result in an
/// error.
pub const UpdateUserDetails = struct {
    /// Indicates whether the user can be verified through a custom invite code.
    code_validation: ?bool = null,

    /// The new first name for the user.
    first_name: ?[]const u8 = null,

    /// A new custom invite code for the user.
    invite_code: ?[]const u8 = null,

    /// The new time-to-live for the invite code in days.
    invite_code_ttl: ?i32 = null,

    /// The new last name for the user.
    last_name: ?[]const u8 = null,

    /// The updated list of security group IDs to which the user should belong.
    security_group_ids: ?[]const []const u8 = null,

    /// The new username or email address for the user.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_validation = "codeValidation",
        .first_name = "firstName",
        .invite_code = "inviteCode",
        .invite_code_ttl = "inviteCodeTtl",
        .last_name = "lastName",
        .security_group_ids = "securityGroupIds",
        .username = "username",
    };
};
