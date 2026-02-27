pub const SummaryRuleOption = enum {
    sid,
    msg,
    metadata,

    pub const json_field_names = .{
        .sid = "SID",
        .msg = "MSG",
        .metadata = "METADATA",
    };
};
