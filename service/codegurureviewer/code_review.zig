const AnalysisType = @import("analysis_type.zig").AnalysisType;
const ConfigFileState = @import("config_file_state.zig").ConfigFileState;
const Metrics = @import("metrics.zig").Metrics;
const ProviderType = @import("provider_type.zig").ProviderType;
const SourceCodeType = @import("source_code_type.zig").SourceCodeType;
const JobState = @import("job_state.zig").JobState;
const Type = @import("type.zig").Type;

/// Information about a code review. A code review belongs to the associated
/// repository that
/// contains the reviewed code.
pub const CodeReview = struct {
    /// The types of analysis performed during a repository analysis or a pull
    /// request review.
    /// You can specify either `Security`, `CodeQuality`, or both.
    analysis_types: ?[]const AnalysisType,

    /// The Amazon Resource Name (ARN) of the
    /// [RepositoryAssociation](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociation.html) that contains the reviewed source code. You can retrieve
    /// associated repository ARNs by calling
    /// [ListRepositoryAssociations](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_ListRepositoryAssociations.html).
    association_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the
    /// [CodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CodeReview.html) object.
    code_review_arn: ?[]const u8,

    /// The state of the `aws-codeguru-reviewer.yml` configuration file that allows
    /// the configuration of the CodeGuru Reviewer analysis. The file either exists,
    /// doesn't exist, or exists
    /// with errors at the root directory of your repository.
    config_file_state: ?ConfigFileState,

    /// The time, in milliseconds since the epoch, when the code review was created.
    created_time_stamp: ?i64,

    /// The time, in milliseconds since the epoch, when the code review was last
    /// updated.
    last_updated_time_stamp: ?i64,

    /// The statistics from the code review.
    metrics: ?Metrics,

    /// The name of the code review.
    name: ?[]const u8,

    /// The owner of the repository. For an Amazon Web Services CodeCommit
    /// repository, this is the Amazon Web Services account ID of the
    /// account that owns the repository. For a GitHub, GitHub Enterprise Server, or
    /// Bitbucket repository, this is the username for the account that owns the
    /// repository.
    /// For an S3 repository, it can be the username or Amazon Web Services account
    /// ID.
    owner: ?[]const u8,

    /// The type of repository that contains the reviewed code (for example, GitHub
    /// or
    /// Bitbucket).
    provider_type: ?ProviderType,

    /// The pull request ID for the code review.
    pull_request_id: ?[]const u8,

    /// The name of the repository.
    repository_name: ?[]const u8,

    /// The type of the source code for the code review.
    source_code_type: ?SourceCodeType,

    /// The valid code review states are:
    ///
    /// * `Completed`: The code review is complete.
    ///
    /// * `Pending`: The code review started and has not completed or failed.
    ///
    /// * `Failed`: The code review failed.
    ///
    /// * `Deleting`: The code review is being deleted.
    state: ?JobState,

    /// The reason for the state of the code review.
    state_reason: ?[]const u8,

    /// The type of code review.
    @"type": ?Type,

    pub const json_field_names = .{
        .analysis_types = "AnalysisTypes",
        .association_arn = "AssociationArn",
        .code_review_arn = "CodeReviewArn",
        .config_file_state = "ConfigFileState",
        .created_time_stamp = "CreatedTimeStamp",
        .last_updated_time_stamp = "LastUpdatedTimeStamp",
        .metrics = "Metrics",
        .name = "Name",
        .owner = "Owner",
        .provider_type = "ProviderType",
        .pull_request_id = "PullRequestId",
        .repository_name = "RepositoryName",
        .source_code_type = "SourceCodeType",
        .state = "State",
        .state_reason = "StateReason",
        .@"type" = "Type",
    };
};
