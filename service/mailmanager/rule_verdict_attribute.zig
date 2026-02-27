pub const RuleVerdictAttribute = enum {
    spf,
    dkim,

    pub const json_field_names = .{
        .spf = "SPF",
        .dkim = "DKIM",
    };
};
