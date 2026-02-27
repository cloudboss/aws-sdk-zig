pub const ReportLevel = enum {
    errors_only,
    successes_and_errors,

    pub const json_field_names = .{
        .errors_only = "ERRORS_ONLY",
        .successes_and_errors = "SUCCESSES_AND_ERRORS",
    };
};
