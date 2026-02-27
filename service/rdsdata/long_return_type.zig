pub const LongReturnType = enum {
    string,
    long,

    pub const json_field_names = .{
        .string = "STRING",
        .long = "LONG",
    };
};
