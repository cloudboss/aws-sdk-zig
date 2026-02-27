pub const FraudDetectionAction = enum {
    ignore,
    fail,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .fail = "FAIL",
    };
};
