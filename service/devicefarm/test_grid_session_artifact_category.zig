pub const TestGridSessionArtifactCategory = enum {
    video,
    log,

    pub const json_field_names = .{
        .video = "VIDEO",
        .log = "LOG",
    };
};
