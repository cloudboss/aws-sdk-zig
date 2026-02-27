/// A job query's status can be SUBMITTED, PROGRESSING, COMPLETE, or ERROR.
pub const JobsQueryStatus = enum {
    submitted,
    progressing,
    complete,
    @"error",

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .progressing = "PROGRESSING",
        .complete = "COMPLETE",
        .@"error" = "ERROR",
    };
};
