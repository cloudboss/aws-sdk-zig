const RepositoryHeadSourceCodeType = @import("repository_head_source_code_type.zig").RepositoryHeadSourceCodeType;
const SourceCodeType = @import("source_code_type.zig").SourceCodeType;

/// A code review type that analyzes all code under a specified branch in an
/// associated
/// repository. The associated repository is specified using its ARN when you
/// call
/// [CreateCodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CreateCodeReview).
pub const RepositoryAnalysis = struct {
    /// A
    /// [SourceCodeType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_SourceCodeType) that specifies the tip of a branch in an associated
    /// repository.
    repository_head: ?RepositoryHeadSourceCodeType = null,

    source_code_type: ?SourceCodeType = null,

    pub const json_field_names = .{
        .repository_head = "RepositoryHead",
        .source_code_type = "SourceCodeType",
    };
};
