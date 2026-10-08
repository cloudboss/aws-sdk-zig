const UserConfig = @import("user_config.zig").UserConfig;

/// The configuration for a membership. This is a union type that contains
/// member-type-specific configuration.
pub const MembershipConfig = union(enum) {
    /// The user configuration for the membership.
    user: ?UserConfig,

    pub const json_field_names = .{
        .user = "user",
    };
};
