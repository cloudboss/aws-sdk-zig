/// Contains the details for a single user to be created in a batch user
/// creation request.
///
/// A user can only be assigned to a single security group. Attempting to add a
/// user to multiple security groups is not supported and will result in an
/// error.
///
/// `codeValidation`, `inviteCode`, and `inviteCodeTtl` are restricted to
/// networks under preview only.
pub const BatchCreateUserRequestItem = struct {
    /// Indicates whether the user can be verified through a custom invite code.
    code_validation: ?bool = null,

    /// The first name of the user.
    first_name: ?[]const u8 = null,

    /// A custom invite code for the user. If not provided, one will be generated
    /// automatically.
    invite_code: ?[]const u8 = null,

    /// The time-to-live for the invite code in days. After this period, the invite
    /// code will expire.
    invite_code_ttl: ?i32 = null,

    /// The last name of the user.
    last_name: ?[]const u8 = null,

    /// A list of security group IDs to which the user should be assigned.
    security_group_ids: []const []const u8,

    /// The email address or username for the user. Must be unique within the
    /// network.
    username: []const u8,

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
