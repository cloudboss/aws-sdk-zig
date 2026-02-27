pub const ContinuousIntegrationScanEvent = enum {
    pull_request,
    push,

    pub const json_field_names = .{
        .pull_request = "PULL_REQUEST",
        .push = "PUSH",
    };
};
