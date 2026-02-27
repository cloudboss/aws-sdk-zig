pub const SizeInspectionLimit = enum {
    kb_16,
    kb_32,
    kb_48,
    kb_64,

    pub const json_field_names = .{
        .kb_16 = "KB_16",
        .kb_32 = "KB_32",
        .kb_48 = "KB_48",
        .kb_64 = "KB_64",
    };
};
