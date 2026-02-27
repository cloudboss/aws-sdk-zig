pub const EvaluationType = enum {
    period_based,
    request_based,

    pub const json_field_names = .{
        .period_based = "PERIOD_BASED",
        .request_based = "REQUEST_BASED",
    };
};
