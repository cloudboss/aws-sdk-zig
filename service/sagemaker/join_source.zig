pub const JoinSource = enum {
    input,
    none,

    pub const json_field_names = .{
        .input = "INPUT",
        .none = "NONE",
    };
};
