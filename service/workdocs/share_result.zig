const RoleType = @import("role_type.zig").RoleType;
const ShareStatusType = @import("share_status_type.zig").ShareStatusType;

/// Describes the share results of a resource.
pub const ShareResult = struct {
    /// The ID of the invited user.
    invitee_principal_id: ?[]const u8 = null,

    /// The ID of the principal.
    principal_id: ?[]const u8 = null,

    /// The role.
    role: ?RoleType = null,

    /// The ID of the resource that was shared.
    share_id: ?[]const u8 = null,

    /// The status.
    status: ?ShareStatusType = null,

    /// The status message.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .invitee_principal_id = "InviteePrincipalId",
        .principal_id = "PrincipalId",
        .role = "Role",
        .share_id = "ShareId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
