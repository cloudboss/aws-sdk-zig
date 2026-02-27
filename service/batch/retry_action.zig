pub const RetryAction = enum {
    retry,
    exit,

    pub const json_field_names = .{
        .retry = "RETRY",
        .exit = "EXIT",
    };
};
