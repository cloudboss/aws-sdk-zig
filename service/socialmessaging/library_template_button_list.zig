const aws = @import("aws");

/// Defines a button in a template from Meta's library.
pub const LibraryTemplateButtonList = struct {
    /// The type of one-time password for OTP buttons.
    otp_type: ?[]const u8 = null,

    /// The phone number in E.164 format for CALL-type buttons.
    phone_number: ?[]const u8 = null,

    /// List of supported applications for this button type.
    supported_apps: ?[]const []const aws.map.StringMapEntry = null,

    /// The text displayed on the button (maximum 40 characters).
    text: ?[]const u8 = null,

    /// The type of button (for example, QUICK_REPLY, CALL, or URL).
    @"type": ?[]const u8 = null,

    /// The URL for URL-type buttons.
    url: ?[]const u8 = null,

    /// When true, indicates acceptance of zero-tap terms for the button.
    zero_tap_terms_accepted: ?bool = null,

    pub const json_field_names = .{
        .otp_type = "otpType",
        .phone_number = "phoneNumber",
        .supported_apps = "supportedApps",
        .text = "text",
        .@"type" = "type",
        .url = "url",
        .zero_tap_terms_accepted = "zeroTapTermsAccepted",
    };
};
