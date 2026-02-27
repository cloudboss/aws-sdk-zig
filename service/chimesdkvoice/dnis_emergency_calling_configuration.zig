/// The Dialed Number Identification Service (DNIS) emergency calling
/// configuration
/// details associated with an Amazon Chime SDK Voice Connector's emergency
/// calling
/// configuration.
pub const DNISEmergencyCallingConfiguration = struct {
    /// The country from which emergency calls are allowed, in ISO 3166-1 alpha-2
    /// format.
    calling_country: []const u8,

    /// The DNIS phone number that you route emergency calls to, in E.164 format.
    emergency_phone_number: []const u8,

    /// The DNIS phone number for routing test emergency calls to, in E.164 format.
    test_phone_number: ?[]const u8,

    pub const json_field_names = .{
        .calling_country = "CallingCountry",
        .emergency_phone_number = "EmergencyPhoneNumber",
        .test_phone_number = "TestPhoneNumber",
    };
};
