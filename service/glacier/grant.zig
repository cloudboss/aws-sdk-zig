const Grantee = @import("grantee.zig").Grantee;
const Permission = @import("permission.zig").Permission;

/// Contains information about a grant.
pub const Grant = struct {
    /// The grantee.
    grantee: ?Grantee,

    /// Specifies the permission given to the grantee.
    permission: ?Permission,

    pub const json_field_names = .{
        .grantee = "Grantee",
        .permission = "Permission",
    };
};
