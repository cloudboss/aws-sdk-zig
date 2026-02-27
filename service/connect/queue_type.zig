pub const QueueType = enum {
    standard,
    agent,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .agent = "AGENT",
    };
};
