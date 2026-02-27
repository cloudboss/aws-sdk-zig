pub const ReportCodeCoverageSortByType = enum {
    line_coverage_percentage,
    file_path,

    pub const json_field_names = .{
        .line_coverage_percentage = "LINE_COVERAGE_PERCENTAGE",
        .file_path = "FILE_PATH",
    };
};
