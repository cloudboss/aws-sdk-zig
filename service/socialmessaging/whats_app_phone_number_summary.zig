/// The details of a linked phone number.
pub const WhatsAppPhoneNumberSummary = struct {
    /// The full Amazon Resource Name (ARN) for the phone number.
    arn: []const u8,

    /// The geographic region where the WhatsApp phone number's data is stored and
    /// processed.
    data_localization_region: ?[]const u8 = null,

    /// The phone number that appears in the recipients display.
    display_phone_number: []const u8,

    /// The display name for this phone number.
    display_phone_number_name: []const u8,

    /// The phone number ID from Meta.
    meta_phone_number_id: []const u8,

    /// The phone number associated with the Linked WhatsApp Business Account.
    phone_number: []const u8,

    /// The phone number ID. Phone number identifiers are formatted as
    /// `phone-number-id-01234567890123456789012345678901`.
    phone_number_id: []const u8,

    /// The quality rating of the phone number. This is from Meta.
    quality_rating: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .data_localization_region = "dataLocalizationRegion",
        .display_phone_number = "displayPhoneNumber",
        .display_phone_number_name = "displayPhoneNumberName",
        .meta_phone_number_id = "metaPhoneNumberId",
        .phone_number = "phoneNumber",
        .phone_number_id = "phoneNumberId",
        .quality_rating = "qualityRating",
    };
};
