pub const ContactParticipantRole = enum {
    agent,
    system,
    custom_bot,

    pub const json_field_names = .{
        .agent = "AGENT",
        .system = "SYSTEM",
        .custom_bot = "CUSTOM_BOT",
    };
};
