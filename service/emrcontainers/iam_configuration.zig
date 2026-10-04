/// Contains the IAM settings for a security configuration, including the system
/// role used for authentication.
pub const IAMConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the system role used by the security
    /// configuration.
    system_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .system_role = "systemRole",
    };
};
