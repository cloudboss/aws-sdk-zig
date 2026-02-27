pub const FirelensConfigurationType = enum {
    fluentd,
    fluentbit,

    pub const json_field_names = .{
        .fluentd = "FLUENTD",
        .fluentbit = "FLUENTBIT",
    };
};
