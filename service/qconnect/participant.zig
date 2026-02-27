pub const Participant = enum {
    customer,
    agent,
    bot,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .agent = "AGENT",
        .bot = "BOT",
    };
};
