pub const MessageTemplateAttributeType = enum {
    system,
    agent,
    customer_profile,
    custom,

    pub const json_field_names = .{
        .system = "SYSTEM",
        .agent = "AGENT",
        .customer_profile = "CUSTOMER_PROFILE",
        .custom = "CUSTOM",
    };
};
