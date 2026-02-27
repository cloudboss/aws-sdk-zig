pub const PhoneNumberProductType = enum {
    voice_connector,
    sip_media_application_dial_in,

    pub const json_field_names = .{
        .voice_connector = "VoiceConnector",
        .sip_media_application_dial_in = "SipMediaApplicationDialIn",
    };
};
