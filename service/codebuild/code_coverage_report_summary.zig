/// Contains a summary of a code coverage report.
///
/// Line coverage measures how many statements your tests cover. A statement is
/// a single
/// instruction, not including comments, conditionals, etc.
///
/// Branch coverage determines if your tests cover every possible branch of a
/// control
/// structure, such as an `if` or `case` statement.
pub const CodeCoverageReportSummary = struct {
    /// The percentage of branches that are covered by your tests.
    branch_coverage_percentage: ?f64 = null,

    /// The number of conditional branches that are covered by your tests.
    branches_covered: ?i32 = null,

    /// The number of conditional branches that are not covered by your tests.
    branches_missed: ?i32 = null,

    /// The percentage of lines that are covered by your tests.
    line_coverage_percentage: ?f64 = null,

    /// The number of lines that are covered by your tests.
    lines_covered: ?i32 = null,

    /// The number of lines that are not covered by your tests.
    lines_missed: ?i32 = null,

    pub const json_field_names = .{
        .branch_coverage_percentage = "branchCoveragePercentage",
        .branches_covered = "branchesCovered",
        .branches_missed = "branchesMissed",
        .line_coverage_percentage = "lineCoveragePercentage",
        .lines_covered = "linesCovered",
        .lines_missed = "linesMissed",
    };
};
