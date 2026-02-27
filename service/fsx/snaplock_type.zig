pub const SnaplockType = enum {
    compliance,
    enterprise,

    pub const json_field_names = .{
        .compliance = "COMPLIANCE",
        .enterprise = "ENTERPRISE",
    };
};
