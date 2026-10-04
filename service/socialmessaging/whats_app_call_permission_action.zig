const WhatsAppCallPermissionLimit = @import("whats_app_call_permission_limit.zig").WhatsAppCallPermissionLimit;

/// Describes a single calling action the business can take with an end user,
/// including whether the action is currently allowed and any limits that apply
/// to it. Returned as an item in the actions list from
/// `GetWhatsAppCallPermission`.
pub const WhatsAppCallPermissionAction = struct {
    /// The name of the calling action.
    action_name: []const u8,

    /// Specifies whether the business can currently perform the action.
    can_perform_action: bool,

    /// The time-bound limits that apply to the action.
    limits: []const WhatsAppCallPermissionLimit,

    pub const json_field_names = .{
        .action_name = "actionName",
        .can_perform_action = "canPerformAction",
        .limits = "limits",
    };
};
