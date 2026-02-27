/// Information about metrics summaries.
pub const MetricsSummary = struct {
    /// Total number of recommendations found in the code review.
    findings_count: ?i64,

    /// Lines of code metered in the code review. For the initial code review pull
    /// request and
    /// all subsequent revisions, this includes all lines of code in the files added
    /// to the pull
    /// request. In subsequent revisions, for files that already existed in the pull
    /// request, this
    /// includes only the changed lines of code. In both cases, this does not
    /// include non-code
    /// lines such as comments and import statements. For example, if you submit a
    /// pull request
    /// containing 5 files, each with 500 lines of code, and in a subsequent
    /// revision you added a
    /// new file with 200 lines of code, and also modified a total of 25 lines
    /// across the initial 5
    /// files, `MeteredLinesOfCodeCount` includes the first 5 files (5 * 500 = 2,500
    /// lines), the new file (200 lines) and the 25 changed lines of code for a
    /// total of 2,725
    /// lines of code.
    metered_lines_of_code_count: ?i64,

    /// Lines of code suppressed in the code review based on the `excludeFiles`
    /// element in the `aws-codeguru-reviewer.yml` file. For full repository
    /// analyses,
    /// this number includes all lines of code in the files that are suppressed. For
    /// pull requests,
    /// this number only includes the *changed* lines of code that are
    /// suppressed. In both cases, this number does not include non-code lines such
    /// as comments and
    /// import statements. For example, if you initiate a full repository analysis
    /// on a repository
    /// containing 5 files, each file with 100 lines of code, and 2 files are listed
    /// as excluded in
    /// the `aws-codeguru-reviewer.yml` file, then
    /// `SuppressedLinesOfCodeCount` returns 200 (2 * 100) as the total number of
    /// lines of code suppressed. However, if you submit a pull request for the same
    /// repository,
    /// then `SuppressedLinesOfCodeCount` only includes the lines in the 2 files
    /// that
    /// changed. If only 1 of the 2 files changed in the pull request, then
    /// `SuppressedLinesOfCodeCount` returns 100 (1 * 100) as the total number of
    /// lines of code suppressed.
    suppressed_lines_of_code_count: ?i64,

    pub const json_field_names = .{
        .findings_count = "FindingsCount",
        .metered_lines_of_code_count = "MeteredLinesOfCodeCount",
        .suppressed_lines_of_code_count = "SuppressedLinesOfCodeCount",
    };
};
