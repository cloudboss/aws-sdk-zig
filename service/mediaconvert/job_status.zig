/// A job's status can be SUBMITTED, PROGRESSING, COMPLETE, CANCELED, or ERROR.
pub const JobStatus = enum {
    submitted,
    progressing,
    complete,
    canceled,
    @"error",

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .progressing = "PROGRESSING",
        .complete = "COMPLETE",
        .canceled = "CANCELED",
        .@"error" = "ERROR",
    };
};
