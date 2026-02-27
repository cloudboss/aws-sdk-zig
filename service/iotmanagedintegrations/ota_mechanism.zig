pub const OtaMechanism = enum {
    push,

    pub const json_field_names = .{
        .push = "PUSH",
    };
};
