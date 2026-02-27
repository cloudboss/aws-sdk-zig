const PrincipalGroup = @import("principal_group.zig").PrincipalGroup;
const PrincipalUser = @import("principal_user.zig").PrincipalUser;

/// Provides user and group information used for filtering documents to use for
/// generating Amazon Q Business conversation responses.
pub const Principal = union(enum) {
    /// The group associated with the principal.
    group: ?PrincipalGroup,
    /// The user associated with the principal.
    user: ?PrincipalUser,

    pub const json_field_names = .{
        .group = "group",
        .user = "user",
    };
};
