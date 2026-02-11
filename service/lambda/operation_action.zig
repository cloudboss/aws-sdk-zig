pub const OperationAction = enum {
    start,
    succeed,
    fail,
    retry,
    cancel,

    pub const json_field_names = .{
        .start = "START",
        .succeed = "SUCCEED",
        .fail = "FAIL",
        .retry = "RETRY",
        .cancel = "CANCEL",
    };
};
