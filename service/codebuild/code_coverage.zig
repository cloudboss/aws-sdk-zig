/// Contains code coverage report information.
///
/// Line coverage measures how many statements your tests cover. A statement is
/// a single
/// instruction, not including comments, conditionals, etc.
///
/// Branch coverage determines if your tests cover every possible branch of a
/// control
/// structure, such as an `if` or `case` statement.
pub const CodeCoverage = struct {
    /// The percentage of branches that are covered by your tests.
    branch_coverage_percentage: ?f64 = null,

    /// The number of conditional branches that are covered by your tests.
    branches_covered: ?i32 = null,

    /// The number of conditional branches that are not covered by your tests.
    branches_missed: ?i32 = null,

    /// The date and time that the tests were run.
    expired: ?i64 = null,

    /// The path of the test report file.
    file_path: ?[]const u8 = null,

    /// The identifier of the code coverage report.
    id: ?[]const u8 = null,

    /// The percentage of lines that are covered by your tests.
    line_coverage_percentage: ?f64 = null,

    /// The number of lines that are covered by your tests.
    lines_covered: ?i32 = null,

    /// The number of lines that are not covered by your tests.
    lines_missed: ?i32 = null,

    /// The ARN of the report.
    report_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .branch_coverage_percentage = "branchCoveragePercentage",
        .branches_covered = "branchesCovered",
        .branches_missed = "branchesMissed",
        .expired = "expired",
        .file_path = "filePath",
        .id = "id",
        .line_coverage_percentage = "lineCoveragePercentage",
        .lines_covered = "linesCovered",
        .lines_missed = "linesMissed",
        .report_arn = "reportARN",
    };
};
