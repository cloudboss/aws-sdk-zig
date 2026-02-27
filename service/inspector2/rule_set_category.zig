pub const RuleSetCategory = enum {
    sast,
    iac,
    sca,

    pub const json_field_names = .{
        .sast = "SAST",
        .iac = "IAC",
        .sca = "SCA",
    };
};
