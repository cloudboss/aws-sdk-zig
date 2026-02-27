pub const ApplicationTagStatus = enum {
    in_progress,
    success,
    failure,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failure = "FAILURE",
    };
};
