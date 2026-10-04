/// Contains the configuration for mapping user identities to Snowflake users,
/// including the username attribute and optional prefix applied during the
/// mapping.
pub const IdentityMapping = struct {
    /// The prefix used for the identity mapping.
    prefix: ?[]const u8 = null,

    /// The username attribute used for the identity mapping.
    username_attribute: []const u8,

    pub const json_field_names = .{
        .prefix = "prefix",
        .username_attribute = "usernameAttribute",
    };
};
