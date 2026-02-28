pub const GuardrailStreamProcessingMode = enum {
    sync,
    async,

    pub const json_field_names = .{
        .sync = "SYNC",
        .async = "ASYNC",
    };
};
