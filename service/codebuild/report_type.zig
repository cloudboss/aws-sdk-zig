pub const ReportType = enum {
    @"test",
    code_coverage,

    pub const json_field_names = .{
        .@"test" = "TEST",
        .code_coverage = "CODE_COVERAGE",
    };
};
