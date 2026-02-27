pub const SenderIdFilterName = enum {
    sender_id,
    iso_country_code,
    message_type,
    deletion_protection_enabled,
    registered,

    pub const json_field_names = .{
        .sender_id = "SENDER_ID",
        .iso_country_code = "ISO_COUNTRY_CODE",
        .message_type = "MESSAGE_TYPE",
        .deletion_protection_enabled = "DELETION_PROTECTION_ENABLED",
        .registered = "REGISTERED",
    };
};
