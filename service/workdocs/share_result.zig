const RoleType = @import("role_type.zig").RoleType;
const ShareStatusType = @import("share_status_type.zig").ShareStatusType;

/// Describes the share results of a resource.
pub const ShareResult = struct {
    /// The ID of the invited user.
    invitee_principal_id: ?[]const u8,

    /// The ID of the principal.
    principal_id: ?[]const u8,

    /// The role.
    role: ?RoleType,

    /// The ID of the resource that was shared.
    share_id: ?[]const u8,

    /// The status.
    status: ?ShareStatusType,

    /// The status message.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .invitee_principal_id = "InviteePrincipalId",
        .principal_id = "PrincipalId",
        .role = "Role",
        .share_id = "ShareId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
