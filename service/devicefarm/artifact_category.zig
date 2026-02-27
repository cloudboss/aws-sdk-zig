pub const ArtifactCategory = enum {
    screenshot,
    file,
    log,

    pub const json_field_names = .{
        .screenshot = "SCREENSHOT",
        .file = "FILE",
        .log = "LOG",
    };
};
