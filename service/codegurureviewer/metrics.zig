/// Information about the statistics from the code review.
pub const Metrics = struct {
    /// Total number of recommendations found in the code review.
    findings_count: ?i64,

    /// `MeteredLinesOfCodeCount` is the number of lines of code in the repository
    /// where the code review happened. This does not include non-code lines such as
    /// comments and
    /// blank lines.
    metered_lines_of_code_count: ?i64,

    /// `SuppressedLinesOfCodeCount` is the number of lines of code in the
    /// repository
    /// where the code review happened that CodeGuru Reviewer did not analyze. The
    /// lines suppressed in the
    /// analysis is based on the `excludeFiles` variable in the
    /// `aws-codeguru-reviewer.yml` file. This number does not include non-code
    /// lines
    /// such as comments and blank lines.
    suppressed_lines_of_code_count: ?i64,

    pub const json_field_names = .{
        .findings_count = "FindingsCount",
        .metered_lines_of_code_count = "MeteredLinesOfCodeCount",
        .suppressed_lines_of_code_count = "SuppressedLinesOfCodeCount",
    };
};
