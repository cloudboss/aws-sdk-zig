pub const TrainingInputMode = enum {
    file,
    fast_file,
    pipe,

    pub const json_field_names = .{
        .file = "FILE",
        .fast_file = "FAST_FILE",
        .pipe = "PIPE",
    };
};
