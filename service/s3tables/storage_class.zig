pub const StorageClass = enum {
    standard,
    intelligent_tiering,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .intelligent_tiering = "INTELLIGENT_TIERING",
    };
};
