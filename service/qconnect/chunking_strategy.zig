pub const ChunkingStrategy = enum {
    fixed_size,
    none,
    hierarchical,
    semantic,

    pub const json_field_names = .{
        .fixed_size = "FIXED_SIZE",
        .none = "NONE",
        .hierarchical = "HIERARCHICAL",
        .semantic = "SEMANTIC",
    };
};
