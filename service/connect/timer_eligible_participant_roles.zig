pub const TimerEligibleParticipantRoles = enum {
    customer,
    agent,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .agent = "AGENT",
    };
};
