pub const ParticipantType = enum {
    all,
    manager,
    agent,
    customer,
    thirdparty,

    pub const json_field_names = .{
        .all = "ALL",
        .manager = "MANAGER",
        .agent = "AGENT",
        .customer = "CUSTOMER",
        .thirdparty = "THIRDPARTY",
    };
};
