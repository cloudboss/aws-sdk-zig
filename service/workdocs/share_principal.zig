const RoleType = @import("role_type.zig").RoleType;
const PrincipalType = @import("principal_type.zig").PrincipalType;

/// Describes the recipient type and ID, if available.
pub const SharePrincipal = struct {
    /// The ID of the recipient.
    id: []const u8,

    /// The role of the recipient.
    role: RoleType,

    /// The type of the recipient.
    @"type": PrincipalType,

    pub const json_field_names = .{
        .id = "Id",
        .role = "Role",
        .@"type" = "Type",
    };
};
