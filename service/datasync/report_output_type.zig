pub const ReportOutputType = enum {
    summary_only,
    standard,

    pub const json_field_names = .{
        .summary_only = "SUMMARY_ONLY",
        .standard = "STANDARD",
    };
};
