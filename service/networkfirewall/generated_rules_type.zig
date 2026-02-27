pub const GeneratedRulesType = enum {
    allowlist,
    denylist,
    rejectlist,
    alertlist,

    pub const json_field_names = .{
        .allowlist = "ALLOWLIST",
        .denylist = "DENYLIST",
        .rejectlist = "REJECTLIST",
        .alertlist = "ALERTLIST",
    };
};
