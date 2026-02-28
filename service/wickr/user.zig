/// Represents a user account in a Wickr network with detailed profile
/// information, status, security settings, and authentication details.
///
/// codeValidation, inviteCode and inviteCodeTtl are restricted to networks
/// under preview only.
pub const User = struct {
    /// The phone number minus country code, used for cloud deployments.
    cell: ?[]const u8,

    /// The number of failed password attempts for enterprise deployments, used for
    /// account lockout policies.
    challenge_failures: ?i32,

    /// Indicates whether the user can be verified through a custom invite code.
    code_validation: ?bool,

    /// The country code for the user's phone number, used for cloud deployments.
    country_code: ?[]const u8,

    /// The first name of the user.
    first_name: ?[]const u8,

    /// The invitation code for this user, used during registration to join the
    /// network.
    invite_code: ?[]const u8,

    /// Indicates whether the user has administrator privileges in the network.
    is_admin: ?bool,

    /// Indicates whether the user's email invitation code has expired, applicable
    /// to cloud deployments.
    is_invite_expired: ?bool,

    /// Indicates whether this account is a user (as opposed to a bot or other
    /// account type).
    is_user: ?bool,

    /// The last name of the user.
    last_name: ?[]const u8,

    /// Indicates whether one-time password (OTP) authentication is enabled for the
    /// user.
    otp_enabled: ?bool,

    /// The SCIM (System for Cross-domain Identity Management) identifier for the
    /// user, used for identity synchronization. Currently not used.
    scim_id: ?[]const u8,

    /// A list of security group IDs to which the user is assigned, determining
    /// their permissions and feature access.
    security_groups: ?[]const []const u8,

    /// The current status of the user (1 for pending invitation, 2 for active).
    status: ?i32,

    /// Indicates whether the user is currently suspended and unable to access the
    /// network.
    suspended: ?bool,

    /// The descriptive type of the user account (e.g., 'user').
    @"type": ?[]const u8,

    /// The unique identifier for the user.
    uname: ?[]const u8,

    /// The unique identifier for the user within the network.
    user_id: ?[]const u8,

    /// The email address or username of the user. For bots, this must end in 'bot'.
    username: ?[]const u8,

    pub const json_field_names = .{
        .cell = "cell",
        .challenge_failures = "challengeFailures",
        .code_validation = "codeValidation",
        .country_code = "countryCode",
        .first_name = "firstName",
        .invite_code = "inviteCode",
        .is_admin = "isAdmin",
        .is_invite_expired = "isInviteExpired",
        .is_user = "isUser",
        .last_name = "lastName",
        .otp_enabled = "otpEnabled",
        .scim_id = "scimId",
        .security_groups = "securityGroups",
        .status = "status",
        .suspended = "suspended",
        .@"type" = "type",
        .uname = "uname",
        .user_id = "userId",
        .username = "username",
    };
};
