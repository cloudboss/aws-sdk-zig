pub const DataFusionRuntimeType = enum {
    multi_thread,
    multi_thread_alt,

    pub const json_field_names = .{
        .multi_thread = "MULTI_THREAD",
        .multi_thread_alt = "MULTI_THREAD_ALT",
    };
};
