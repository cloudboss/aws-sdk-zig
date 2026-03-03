/// The proxy configuration for an Amazon Chime SDK Voice Connector.
pub const Proxy = struct {
    /// The default number of minutes allowed for proxy sessions.
    default_session_expiry_minutes: ?i32 = null,

    /// When true, stops proxy sessions from being created on the specified Amazon
    /// Chime SDK Voice Connector.
    disabled: ?bool = null,

    /// The phone number to route calls to after a proxy session expires.
    fall_back_phone_number: ?[]const u8 = null,

    /// The countries for proxy phone numbers to be selected from.
    phone_number_countries: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .default_session_expiry_minutes = "DefaultSessionExpiryMinutes",
        .disabled = "Disabled",
        .fall_back_phone_number = "FallBackPhoneNumber",
        .phone_number_countries = "PhoneNumberCountries",
    };
};
