pub const FlowAssociationResourceType = enum {
    sms_phone_number,
    inbound_email,
    outbound_email,
    analytics_connector,
    whatsapp_messaging_phone_number,

    pub const json_field_names = .{
        .sms_phone_number = "SMS_PHONE_NUMBER",
        .inbound_email = "INBOUND_EMAIL",
        .outbound_email = "OUTBOUND_EMAIL",
        .analytics_connector = "ANALYTICS_CONNECTOR",
        .whatsapp_messaging_phone_number = "WHATSAPP_MESSAGING_PHONE_NUMBER",
    };
};
