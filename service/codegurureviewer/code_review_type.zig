const AnalysisType = @import("analysis_type.zig").AnalysisType;
const RepositoryAnalysis = @import("repository_analysis.zig").RepositoryAnalysis;

/// The type of a code review. There are two code review types:
///
/// * `PullRequest` - A code review that is automatically triggered by a pull
/// request on an associated repository.
///
/// * `RepositoryAnalysis` - A code review that analyzes all code under a
/// specified branch in an associated repository. The associated repository is
/// specified
/// using its ARN in
/// [CreateCodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CreateCodeReview).
pub const CodeReviewType = struct {
    /// They types of analysis performed during a repository analysis or a pull
    /// request review.
    /// You can specify either `Security`, `CodeQuality`, or both.
    analysis_types: ?[]const AnalysisType = null,

    /// A code review that analyzes all code under a specified branch in an
    /// associated
    /// repository. The associated repository is specified using its ARN in
    /// [CreateCodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CreateCodeReview).
    repository_analysis: RepositoryAnalysis,

    pub const json_field_names = .{
        .analysis_types = "AnalysisTypes",
        .repository_analysis = "RepositoryAnalysis",
    };
};
