const Tag = @import("tag.zig").Tag;

/// The registration details for a linked phone number.
pub const WabaPhoneNumberSetupFinalization = struct {
    /// The two letter ISO region for the location of where Meta will store data.
    ///
    /// **Asia–Pacific (APAC)**
    ///
    /// * Australia **AU**
    ///
    /// * Indonesia **ID**
    ///
    /// * India **IN**
    ///
    /// * Japan **JP**
    ///
    /// * Singapore **SG**
    ///
    /// * South Korea **KR**
    ///
    /// **Europe**
    ///
    /// * Germany **DE**
    ///
    /// * Switzerland **CH**
    ///
    /// * United Kingdom **GB**
    ///
    /// **Latin America (LATAM)**
    ///
    /// * Brazil **BR**
    ///
    /// **Middle East and Africa (MEA)**
    ///
    /// * Bahrain **BH**
    ///
    /// * South Africa **ZA**
    ///
    /// * United Arab Emirates **AE**
    ///
    /// **North America (NORAM)**
    ///
    /// * Canada **CA**
    data_localization_region: ?[]const u8 = null,

    /// The unique identifier of the originating phone number associated with the
    /// media. Phone
    /// number identifiers are formatted as
    /// `phone-number-id-01234567890123456789012345678901`. Use the
    /// [GetLinkedWhatsAppBusinessAccount](https://docs.aws.amazon.com/social-messaging/latest/APIReference/API_GetLinkedWhatsAppBusinessAccount.html)
    /// API action to find a phone number's id.
    id: []const u8,

    /// An array of key and value pair tags.
    tags: ?[]const Tag = null,

    /// The PIN to use for two-step verification. To reset your PIN follow the
    /// directions in
    /// [Updating
    /// PIN](https://developers.facebook.com/docs/whatsapp/cloud-api/reference/two-step-verification/#updating-pin) in the *WhatsApp Business Platform Cloud API
    /// Reference*.
    two_factor_pin: []const u8,

    pub const json_field_names = .{
        .data_localization_region = "dataLocalizationRegion",
        .id = "id",
        .tags = "tags",
        .two_factor_pin = "twoFactorPin",
    };
};
