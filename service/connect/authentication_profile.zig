/// This API is in preview release for Amazon Connect and is subject to change.
/// To
/// request access to this API, contact Amazon Web Services Support.
///
/// Information about an authentication profile. An authentication profile is a
/// resource that stores the
/// authentication settings for users in your contact center. You use
/// authentication profiles to set up IP address range
/// restrictions and session timeouts. For more information, see [Set IP address
/// restrictions or session
/// timeouts](https://docs.aws.amazon.com/connect/latest/adminguide/authentication-profiles.html).
pub const AuthenticationProfile = struct {
    /// A list of IP address range strings that are allowed to access the Amazon
    /// Connect instance. For more
    /// information about how to configure IP addresses, see [Configure IP address
    /// based access
    /// control](https://docs.aws.amazon.com/connect/latest/adminguide/authentication-profiles.html#configure-ip-based-ac) in the *Amazon Connect Administrator Guide*.
    allowed_ips: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) for the authentication profile.
    arn: ?[]const u8 = null,

    /// A list of IP address range strings that are blocked from accessing the
    /// Amazon Connect instance. For more
    /// information about how to configure IP addresses, see [Configure IP address
    /// based access
    /// control](https://docs.aws.amazon.com/connect/latest/adminguide/authentication-profiles.html#configure-ip-based-ac) in the *Amazon Connect Administrator Guide*.
    blocked_ips: ?[]const []const u8 = null,

    /// The timestamp when the authentication profile was created.
    created_time: ?i64 = null,

    /// The description for the authentication profile.
    description: ?[]const u8 = null,

    /// A unique identifier for the authentication profile.
    id: ?[]const u8 = null,

    /// Shows whether the authentication profile is the default authentication
    /// profile for the Amazon Connect
    /// instance. The default authentication profile applies to all agents in an
    /// Amazon Connect instance, unless
    /// overridden by another authentication profile.
    is_default: bool = false,

    /// The Amazon Web Services Region where the authentication profile was last
    /// modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when the authentication profile was last modified.
    last_modified_time: ?i64 = null,

    /// The long lived session duration for users logged in to Amazon Connect, in
    /// minutes. After this time period,
    /// users must log in again. For more information, see [Configure the session
    /// duration](https://docs.aws.amazon.com/connect/latest/adminguide/authentication-profiles.html#configure-session-timeouts) in the *Amazon Connect Administrator Guide*.
    max_session_duration: ?i32 = null,

    /// The name for the authentication profile.
    name: ?[]const u8 = null,

    /// The short lived session duration configuration for users logged in to Amazon
    /// Connect, in minutes. This value
    /// determines the maximum possible time before an agent is authenticated. For
    /// more information, see [Configure the session
    /// duration](https://docs.aws.amazon.com/connect/latest/adminguide/authentication-profiles.html#configure-session-timeouts) in the *Amazon Connect Administrator Guide*.
    periodic_session_duration: ?i32 = null,

    /// The period, in minutes, before an agent is automatically signed out of the
    /// contact center when they go
    /// inactive.
    session_inactivity_duration: ?i32 = null,

    /// Determines if automatic logout on user inactivity is enabled.
    session_inactivity_handling_enabled: ?bool = null,

    pub const json_field_names = .{
        .allowed_ips = "AllowedIps",
        .arn = "Arn",
        .blocked_ips = "BlockedIps",
        .created_time = "CreatedTime",
        .description = "Description",
        .id = "Id",
        .is_default = "IsDefault",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .max_session_duration = "MaxSessionDuration",
        .name = "Name",
        .periodic_session_duration = "PeriodicSessionDuration",
        .session_inactivity_duration = "SessionInactivityDuration",
        .session_inactivity_handling_enabled = "SessionInactivityHandlingEnabled",
    };
};
