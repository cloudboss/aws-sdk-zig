pub const PhoneNumberProductType = enum {
    business_calling,
    voice_connector,
    sip_media_application_dial_in,

    pub const json_field_names = .{
        .business_calling = "BusinessCalling",
        .voice_connector = "VoiceConnector",
        .sip_media_application_dial_in = "SipMediaApplicationDialIn",
    };
};
