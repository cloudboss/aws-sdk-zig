pub const VocabularyState = enum {
    pending,
    ready,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .ready = "READY",
        .failed = "FAILED",
    };
};
