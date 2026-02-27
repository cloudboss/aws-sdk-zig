const SearchScopeSummary = @import("search_scope_summary.zig").SearchScopeSummary;
const SearchJobState = @import("search_job_state.zig").SearchJobState;

/// This is information pertaining to a search job.
pub const SearchJobSummary = struct {
    /// This is the completion time of the search job.
    completion_time: ?i64,

    /// This is the creation time of the search job.
    creation_time: ?i64,

    /// This is the name of the search job.
    name: ?[]const u8,

    /// The unique string that identifies the Amazon Resource Name (ARN) of the
    /// specified search job.
    search_job_arn: ?[]const u8,

    /// The unique string that specifies the search job.
    search_job_identifier: ?[]const u8,

    /// Returned summary of the specified search job scope, including:
    ///
    /// * TotalBackupsToScanCount, the number of recovery points returned by the
    ///   search.
    /// * TotalItemsToScanCount, the number of items returned by the search.
    search_scope_summary: ?SearchScopeSummary,

    /// This is the status of the search job.
    status: ?SearchJobState,

    /// A status message will be returned for either a earch job with a status of
    /// `ERRORED` or a status of `COMPLETED` jobs with issues.
    ///
    /// For example, a message may say that a search contained recovery points
    /// unable to be scanned because of a permissions issue.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .name = "Name",
        .search_job_arn = "SearchJobArn",
        .search_job_identifier = "SearchJobIdentifier",
        .search_scope_summary = "SearchScopeSummary",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
