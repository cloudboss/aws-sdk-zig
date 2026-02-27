const PrincipalRoleType = @import("principal_role_type.zig").PrincipalRoleType;

/// Filter based on UserIds or GroupIds.
pub const SearchPrincipalType = struct {
    /// UserIds or GroupIds.
    id: []const u8,

    /// The Role of a User or Group.
    roles: ?[]const PrincipalRoleType,

    pub const json_field_names = .{
        .id = "Id",
        .roles = "Roles",
    };
};
