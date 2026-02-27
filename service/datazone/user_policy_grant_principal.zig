const AllUsersGrantFilter = @import("all_users_grant_filter.zig").AllUsersGrantFilter;

/// The user policy grant principal.
pub const UserPolicyGrantPrincipal = union(enum) {
    /// The all users grant filter of the user policy grant principal.
    all_users_grant_filter: ?AllUsersGrantFilter,
    /// The user ID of the user policy grant principal.
    user_identifier: ?[]const u8,

    pub const json_field_names = .{
        .all_users_grant_filter = "allUsersGrantFilter",
        .user_identifier = "userIdentifier",
    };
};
