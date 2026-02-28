const aws = @import("aws");

/// Configuration options for customizing buttons in a template from Meta's
/// library.
pub const LibraryTemplateButtonInput = struct {
    /// The type of one-time password for OTP buttons.
    otp_type: ?[]const u8,

    /// The phone number in E.164 format for CALL-type buttons.
    phone_number: ?[]const u8,

    /// List of supported applications for this button type.
    supported_apps: ?[]const []const aws.map.StringMapEntry,

    /// The type of button (for example, QUICK_REPLY, CALL, or URL).
    @"type": ?[]const u8,

    /// The URL with dynamic parameters for URL-type buttons.
    url: ?[]const aws.map.StringMapEntry,

    /// When true, indicates acceptance of zero-tap terms for the button.
    zero_tap_terms_accepted: ?bool,

    pub const json_field_names = .{
        .otp_type = "otpType",
        .phone_number = "phoneNumber",
        .supported_apps = "supportedApps",
        .@"type" = "type",
        .url = "url",
        .zero_tap_terms_accepted = "zeroTapTermsAccepted",
    };
};
