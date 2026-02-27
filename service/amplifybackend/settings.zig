const MfaTypesElement = @import("mfa_types_element.zig").MfaTypesElement;

/// The settings of your MFA configuration for the backend of your Amplify
/// project.
pub const Settings = struct {
    /// The supported MFA types.
    mfa_types: ?[]const MfaTypesElement,

    /// The body of the SMS message.
    sms_message: ?[]const u8,

    pub const json_field_names = .{
        .mfa_types = "MfaTypes",
        .sms_message = "SmsMessage",
    };
};
