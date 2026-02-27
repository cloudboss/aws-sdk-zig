pub const TestGridSessionArtifactType = enum {
    unknown,
    video,
    selenium_log,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .video = "VIDEO",
        .selenium_log = "SELENIUM_LOG",
    };
};
