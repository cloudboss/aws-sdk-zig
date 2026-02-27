pub const IndexSource = enum {
    account,
    log_group,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .log_group = "LOG_GROUP",
    };
};
