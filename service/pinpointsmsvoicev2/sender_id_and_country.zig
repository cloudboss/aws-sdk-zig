/// The alphanumeric sender ID in a specific country that you want to describe.
/// For more information on sender IDs see [Requesting sender IDs
/// ](https://docs.aws.amazon.com/sms-voice/latest/userguide/sender-id-request.html) in the *End User Messaging SMS User Guide*.
pub const SenderIdAndCountry = struct {
    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The unique identifier of the sender.
    sender_id: []const u8,

    pub const json_field_names = .{
        .iso_country_code = "IsoCountryCode",
        .sender_id = "SenderId",
    };
};
