const ExportJobResponse = @import("export_job_response.zig").ExportJobResponse;

/// Provides information about all the export jobs that are associated with an
/// application or segment. An export job is a job that exports endpoint
/// definitions to a file.
pub const ExportJobsResponse = struct {
    /// An array of responses, one for each export job that's associated with the
    /// application (Export Jobs resource) or segment (Segment Export Jobs
    /// resource).
    item: []const ExportJobResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
