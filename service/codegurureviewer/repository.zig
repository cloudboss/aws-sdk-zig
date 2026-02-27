const ThirdPartySourceRepository = @import("third_party_source_repository.zig").ThirdPartySourceRepository;
const CodeCommitRepository = @import("code_commit_repository.zig").CodeCommitRepository;
const S3Repository = @import("s3_repository.zig").S3Repository;

/// Information about an associated Amazon Web Services CodeCommit repository or
/// an associated repository
/// that is managed by Amazon Web Services CodeStar Connections (for example,
/// Bitbucket). This
/// `Repository` object is not used if your source code is in an associated
/// GitHub repository.
pub const Repository = struct {
    /// Information about a Bitbucket repository.
    bitbucket: ?ThirdPartySourceRepository,

    /// Information about an Amazon Web Services CodeCommit repository.
    code_commit: ?CodeCommitRepository,

    /// Information about a GitHub Enterprise Server repository.
    git_hub_enterprise_server: ?ThirdPartySourceRepository,

    s3_bucket: ?S3Repository,

    pub const json_field_names = .{
        .bitbucket = "Bitbucket",
        .code_commit = "CodeCommit",
        .git_hub_enterprise_server = "GitHubEnterpriseServer",
        .s3_bucket = "S3Bucket",
    };
};
