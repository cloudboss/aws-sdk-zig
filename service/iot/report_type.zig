pub const ReportType = enum {
    errors,
    results,

    pub const json_field_names = .{
        .errors = "ERRORS",
        .results = "RESULTS",
    };
};
