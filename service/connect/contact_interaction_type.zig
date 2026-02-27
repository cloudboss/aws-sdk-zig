pub const ContactInteractionType = enum {
    agent,
    automated,

    pub const json_field_names = .{
        .agent = "AGENT",
        .automated = "AUTOMATED",
    };
};
