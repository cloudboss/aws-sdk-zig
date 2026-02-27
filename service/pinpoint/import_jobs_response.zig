const ImportJobResponse = @import("import_job_response.zig").ImportJobResponse;

/// Provides information about the status and settings of all the import jobs
/// that are associated with an application or segment. An import job is a job
/// that imports endpoint definitions from one or more files.
pub const ImportJobsResponse = struct {
    /// An array of responses, one for each import job that's associated with the
    /// application (Import Jobs resource) or segment (Segment Import Jobs
    /// resource).
    item: []const ImportJobResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
