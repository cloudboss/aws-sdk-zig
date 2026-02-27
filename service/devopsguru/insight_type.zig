pub const InsightType = enum {
    reactive,
    proactive,

    pub const json_field_names = .{
        .reactive = "REACTIVE",
        .proactive = "PROACTIVE",
    };
};
