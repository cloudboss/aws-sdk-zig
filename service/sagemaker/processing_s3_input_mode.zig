pub const ProcessingS3InputMode = enum {
    pipe,
    file,

    pub const json_field_names = .{
        .pipe = "PIPE",
        .file = "FILE",
    };
};
