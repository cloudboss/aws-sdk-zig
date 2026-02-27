pub const ParticipantRole = enum {
    agent,
    customer,

    pub const json_field_names = .{
        .agent = "AGENT",
        .customer = "CUSTOMER",
    };
};
