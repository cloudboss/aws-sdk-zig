const TelephonySettings = @import("telephony_settings.zig").TelephonySettings;

/// Settings associated with an Amazon Chime user, including inbound and
/// outbound calling and text
/// messaging.
pub const UserSettings = struct {
    /// The telephony settings associated with the user.
    telephony: TelephonySettings,

    pub const json_field_names = .{
        .telephony = "Telephony",
    };
};
