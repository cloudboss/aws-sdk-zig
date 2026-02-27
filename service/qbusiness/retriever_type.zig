pub const RetrieverType = enum {
    native_index,
    kendra_index,

    pub const json_field_names = .{
        .native_index = "NATIVE_INDEX",
        .kendra_index = "KENDRA_INDEX",
    };
};
