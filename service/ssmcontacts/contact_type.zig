pub const ContactType = enum {
    personal,
    escalation,
    oncall_schedule,

    pub const json_field_names = .{
        .personal = "PERSONAL",
        .escalation = "ESCALATION",
        .oncall_schedule = "ONCALL_SCHEDULE",
    };
};
