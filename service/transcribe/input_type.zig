pub const InputType = enum {
    real_time,
    post_call,

    pub const json_field_names = .{
        .real_time = "REAL_TIME",
        .post_call = "POST_CALL",
    };
};
