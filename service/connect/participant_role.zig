pub const ParticipantRole = enum {
    agent,
    customer,
    system,
    custom_bot,
    supervisor,

    pub const json_field_names = .{
        .agent = "AGENT",
        .customer = "CUSTOMER",
        .system = "SYSTEM",
        .custom_bot = "CUSTOM_BOT",
        .supervisor = "SUPERVISOR",
    };
};
