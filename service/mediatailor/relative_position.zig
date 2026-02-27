pub const RelativePosition = enum {
    before_program,
    after_program,

    pub const json_field_names = .{
        .before_program = "BEFORE_PROGRAM",
        .after_program = "AFTER_PROGRAM",
    };
};
