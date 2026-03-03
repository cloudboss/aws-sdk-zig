const MetricsSummary = @import("metrics_summary.zig").MetricsSummary;
const ProviderType = @import("provider_type.zig").ProviderType;
const SourceCodeType = @import("source_code_type.zig").SourceCodeType;
const JobState = @import("job_state.zig").JobState;
const Type = @import("type.zig").Type;

/// Information about the summary of the code review.
pub const CodeReviewSummary = struct {
    /// The Amazon Resource Name (ARN) of the
    /// [CodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CodeReview.html) object.
    code_review_arn: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the code review was created.
    created_time_stamp: ?i64 = null,

    /// The time, in milliseconds since the epoch, when the code review was last
    /// updated.
    last_updated_time_stamp: ?i64 = null,

    /// The statistics from the code review.
    metrics_summary: ?MetricsSummary = null,

    /// The name of the code review.
    name: ?[]const u8 = null,

    /// The owner of the repository. For an Amazon Web Services CodeCommit
    /// repository, this is the Amazon Web Services account ID of the
    /// account that owns the repository. For a GitHub, GitHub Enterprise Server, or
    /// Bitbucket repository, this is the username for the account that owns the
    /// repository.
    /// For an S3 repository, it can be the username or Amazon Web Services account
    /// ID.
    owner: ?[]const u8 = null,

    /// The provider type of the repository association.
    provider_type: ?ProviderType = null,

    /// The pull request ID for the code review.
    pull_request_id: ?[]const u8 = null,

    /// The name of the repository.
    repository_name: ?[]const u8 = null,

    source_code_type: ?SourceCodeType = null,

    /// The state of the code review.
    ///
    /// The valid code review states are:
    ///
    /// * `Completed`: The code review is complete.
    ///
    /// * `Pending`: The code review started and has not completed or failed.
    ///
    /// * `Failed`: The code review failed.
    ///
    /// * `Deleting`: The code review is being deleted.
    state: ?JobState = null,

    /// The type of the code review.
    @"type": ?Type = null,

    pub const json_field_names = .{
        .code_review_arn = "CodeReviewArn",
        .created_time_stamp = "CreatedTimeStamp",
        .last_updated_time_stamp = "LastUpdatedTimeStamp",
        .metrics_summary = "MetricsSummary",
        .name = "Name",
        .owner = "Owner",
        .provider_type = "ProviderType",
        .pull_request_id = "PullRequestId",
        .repository_name = "RepositoryName",
        .source_code_type = "SourceCodeType",
        .state = "State",
        .@"type" = "Type",
    };
};
