pub const ReportGroupTrendFieldType = enum {
    pass_rate,
    duration,
    total,
    line_coverage,
    lines_covered,
    lines_missed,
    branch_coverage,
    branches_covered,
    branches_missed,

    pub const json_field_names = .{
        .pass_rate = "PASS_RATE",
        .duration = "DURATION",
        .total = "TOTAL",
        .line_coverage = "LINE_COVERAGE",
        .lines_covered = "LINES_COVERED",
        .lines_missed = "LINES_MISSED",
        .branch_coverage = "BRANCH_COVERAGE",
        .branches_covered = "BRANCHES_COVERED",
        .branches_missed = "BRANCHES_MISSED",
    };
};
