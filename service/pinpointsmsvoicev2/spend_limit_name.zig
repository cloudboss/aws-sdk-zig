pub const SpendLimitName = enum {
    text_message_monthly_spend_limit,
    voice_message_monthly_spend_limit,
    media_message_monthly_spend_limit,

    pub const json_field_names = .{
        .text_message_monthly_spend_limit = "TEXT_MESSAGE_MONTHLY_SPEND_LIMIT",
        .voice_message_monthly_spend_limit = "VOICE_MESSAGE_MONTHLY_SPEND_LIMIT",
        .media_message_monthly_spend_limit = "MEDIA_MESSAGE_MONTHLY_SPEND_LIMIT",
    };
};
