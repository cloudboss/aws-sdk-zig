pub const InputCardComputeMode = enum {
    append,
    replace,

    pub const json_field_names = .{
        .append = "APPEND",
        .replace = "REPLACE",
    };
};
