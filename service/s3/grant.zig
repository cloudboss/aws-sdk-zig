const Grantee = @import("grantee.zig").Grantee;
const Permission = @import("permission.zig").Permission;

/// Container for grant information.
pub const Grant = struct {
    /// The person being granted permissions.
    grantee: ?Grantee = null,

    /// Specifies the permission given to the grantee.
    permission: ?Permission = null,
};
