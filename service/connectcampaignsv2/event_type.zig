/// Enumeration of Customer Profiles event type
pub const EventType = enum {
    campaign_email,
    campaign_sms,
    campaign_telephony,
    campaign_orchestration,

    pub const json_field_names = .{
        .campaign_email = "CAMPAIGN_EMAIL",
        .campaign_sms = "CAMPAIGN_SMS",
        .campaign_telephony = "CAMPAIGN_TELEPHONY",
        .campaign_orchestration = "CAMPAIGN_ORCHESTRATION",
    };
};
