pub const RecoveryResult = enum {
    not_started,
    in_progress,
    success,
    fail,
    partial_success,
    associate_success,
    associate_fail,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .fail = "FAIL",
        .partial_success = "PARTIAL_SUCCESS",
        .associate_success = "ASSOCIATE_SUCCESS",
        .associate_fail = "ASSOCIATE_FAIL",
    };
};
