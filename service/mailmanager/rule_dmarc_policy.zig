pub const RuleDmarcPolicy = enum {
    none,
    quarantine,
    reject,

    pub const json_field_names = .{
        .none = "NONE",
        .quarantine = "QUARANTINE",
        .reject = "REJECT",
    };
};
