const PrincipalType = @import("principal_type.zig").PrincipalType;

/// Describes a principal.
pub const AddedPrincipal = struct {
    /// The Amazon Resource Name (ARN) of the principal.
    principal: ?[]const u8,

    /// The type of principal.
    principal_type: ?PrincipalType,

    /// The ID of the service.
    service_id: ?[]const u8,

    /// The ID of the service permission.
    service_permission_id: ?[]const u8,
};
