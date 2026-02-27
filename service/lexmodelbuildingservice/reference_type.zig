pub const ReferenceType = enum {
    intent,
    bot,
    botalias,
    botchannel,

    pub const json_field_names = .{
        .intent = "INTENT",
        .bot = "BOT",
        .botalias = "BOTALIAS",
        .botchannel = "BOTCHANNEL",
    };
};
