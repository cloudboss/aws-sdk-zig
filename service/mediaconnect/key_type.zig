pub const KeyType = enum {
    speke,
    static_key,
    srt_password,

    pub const json_field_names = .{
        .speke = "speke",
        .static_key = "static_key",
        .srt_password = "srt_password",
    };
};
