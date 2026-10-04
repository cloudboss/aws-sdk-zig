const WhatsAppCallHours = @import("whats_app_call_hours.zig").WhatsAppCallHours;

/// The calling configuration for a WhatsApp business phone number.
pub const WhatsAppCallSettings = struct {
    /// The callback permission status for the phone number.
    callback_permission_status: ?[]const u8 = null,

    /// Specifies whether calling is enabled for the phone number.
    call_enabled: bool,

    /// The hours during which the business accepts calls on the phone number.
    call_hours: ?WhatsAppCallHours = null,

    /// The visibility setting for the call icon shown to end users in WhatsApp.
    call_icon_visibility: ?[]const u8 = null,

    pub const json_field_names = .{
        .callback_permission_status = "callbackPermissionStatus",
        .call_enabled = "callEnabled",
        .call_hours = "callHours",
        .call_icon_visibility = "callIconVisibility",
    };
};
