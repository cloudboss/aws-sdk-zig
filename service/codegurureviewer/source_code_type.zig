const BranchDiffSourceCodeType = @import("branch_diff_source_code_type.zig").BranchDiffSourceCodeType;
const CommitDiffSourceCodeType = @import("commit_diff_source_code_type.zig").CommitDiffSourceCodeType;
const RepositoryHeadSourceCodeType = @import("repository_head_source_code_type.zig").RepositoryHeadSourceCodeType;
const RequestMetadata = @import("request_metadata.zig").RequestMetadata;
const S3BucketRepository = @import("s3_bucket_repository.zig").S3BucketRepository;

/// Specifies the source code that is analyzed in a code review.
pub const SourceCodeType = struct {
    /// A type of
    /// [SourceCodeType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_SourceCodeType) that
    /// specifies a source branch name and a destination branch name in an
    /// associated
    /// repository.
    branch_diff: ?BranchDiffSourceCodeType = null,

    /// A
    /// [SourceCodeType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_SourceCodeType) that specifies a commit diff created by a pull request on an
    /// associated repository.
    commit_diff: ?CommitDiffSourceCodeType = null,

    repository_head: ?RepositoryHeadSourceCodeType = null,

    /// Metadata that is associated with a code review. This applies to any type of
    /// code review
    /// supported by CodeGuru Reviewer. The `RequestMetadaa` field captures any
    /// event metadata. For
    /// example, it might capture metadata associated with an event trigger, such as
    /// a push or a
    /// pull request.
    request_metadata: ?RequestMetadata = null,

    /// Information about an associated repository in an S3 bucket that includes its
    /// name and an `S3RepositoryDetails` object. The `S3RepositoryDetails` object
    /// includes the name of an S3 bucket, an S3 key for a source code .zip file,
    /// and an S3 key for a build artifacts .zip file. `S3BucketRepository` is
    /// required in
    /// [SourceCodeType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_SourceCodeType) for `S3BucketRepository` based code reviews.
    s3_bucket_repository: ?S3BucketRepository = null,

    pub const json_field_names = .{
        .branch_diff = "BranchDiff",
        .commit_diff = "CommitDiff",
        .repository_head = "RepositoryHead",
        .request_metadata = "RequestMetadata",
        .s3_bucket_repository = "S3BucketRepository",
    };
};
