pub const ResourceType = enum {
    bot,
    intent,
    slot_type,

    pub const json_field_names = .{
        .bot = "BOT",
        .intent = "INTENT",
        .slot_type = "SLOT_TYPE",
    };
};
