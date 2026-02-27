pub const JobType = enum {
    release,
    retry,
    manual,
    web_hook,

    pub const json_field_names = .{
        .release = "RELEASE",
        .retry = "RETRY",
        .manual = "MANUAL",
        .web_hook = "WEB_HOOK",
    };
};
