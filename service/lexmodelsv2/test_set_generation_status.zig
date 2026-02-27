pub const TestSetGenerationStatus = enum {
    generating,
    ready,
    failed,
    pending,

    pub const json_field_names = .{
        .generating = "Generating",
        .ready = "Ready",
        .failed = "Failed",
        .pending = "Pending",
    };
};
