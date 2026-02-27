pub const Edition = enum {
    standard,
    enterprise,
    enterprise_and_q,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .enterprise = "ENTERPRISE",
        .enterprise_and_q = "ENTERPRISE_AND_Q",
    };
};
