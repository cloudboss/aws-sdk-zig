pub const IncludeGeneratedAnswer = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
