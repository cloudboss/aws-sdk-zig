pub const ClientAuthenticationType = enum {
    smart_card,
    smart_card_or_password,

    pub const json_field_names = .{
        .smart_card = "SMART_CARD",
        .smart_card_or_password = "SMART_CARD_OR_PASSWORD",
    };
};
