pub const ListFlowAssociationResourceType = enum {
    whatsapp_messaging_phone_number,
    voice_phone_number,
    inbound_email,
    outbound_email,
    analytics_connector,

    pub const json_field_names = .{
        .whatsapp_messaging_phone_number = "WHATSAPP_MESSAGING_PHONE_NUMBER",
        .voice_phone_number = "VOICE_PHONE_NUMBER",
        .inbound_email = "INBOUND_EMAIL",
        .outbound_email = "OUTBOUND_EMAIL",
        .analytics_connector = "ANALYTICS_CONNECTOR",
    };
};
