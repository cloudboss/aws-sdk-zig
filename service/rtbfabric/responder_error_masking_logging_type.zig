pub const ResponderErrorMaskingLoggingType = enum {
    none,
    metric,
    response,

    pub const json_field_names = .{
        .none = "NONE",
        .metric = "METRIC",
        .response = "RESPONSE",
    };
};
