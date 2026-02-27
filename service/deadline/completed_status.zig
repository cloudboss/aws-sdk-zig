pub const CompletedStatus = enum {
    succeeded,
    failed,
    interrupted,
    canceled,
    never_attempted,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
        .canceled = "CANCELED",
        .never_attempted = "NEVER_ATTEMPTED",
    };
};
