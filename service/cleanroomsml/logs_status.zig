pub const LogsStatus = enum {
    publish_succeeded,
    publish_failed,

    pub const json_field_names = .{
        .publish_succeeded = "PUBLISH_SUCCEEDED",
        .publish_failed = "PUBLISH_FAILED",
    };
};
