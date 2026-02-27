pub const JobRunMode = enum {
    batch,
    streaming,

    pub const json_field_names = .{
        .batch = "BATCH",
        .streaming = "STREAMING",
    };
};
