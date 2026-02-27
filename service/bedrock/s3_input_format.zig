pub const S3InputFormat = enum {
    jsonl,

    pub const json_field_names = .{
        .jsonl = "JSONL",
    };
};
