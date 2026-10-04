const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobType = @import("job_type.zig").JobType;
const EnrichmentJobStatus = @import("enrichment_job_status.zig").EnrichmentJobStatus;
const EnrichmentJobSummary = @import("enrichment_job_summary.zig").EnrichmentJobSummary;

pub const ListEnrichmentJobsInput = struct {
    /// Filter jobs by dataset ID. Returns only jobs analyzing data from the
    /// specified dataset.
    dataset_id: ?[]const u8 = null,

    /// The inclusive end of the date range for filtering jobs by creation time.
    /// Jobs created on or before
    /// this timestamp are included. Use ISO 8601 format (e.g.,
    /// 2024-01-31T23:59:59Z).
    end_date: ?i64 = null,

    /// Filter by enrichment job type. Currently only EVENT_DETECTION is supported.
    /// Use this filter to future-proof queries when additional job types are added.
    job_type: ?JobType = null,

    /// Maximum number of jobs to return per page. Defaults to 50 if not specified.
    /// Use smaller values for faster responses, larger values to reduce API calls.
    max_results: ?i32 = null,

    /// Pagination token from a previous ListEnrichmentJobs response. Include this
    /// token to retrieve the
    /// next page of results. Omit for the first request.
    next_token: ?[]const u8 = null,

    /// Filter by property alias (human-readable sensor name). Specify either
    /// propertyAlias or timeSeriesId,
    /// but not both. Returns only jobs analyzing the specified property alias.
    property_alias: ?[]const u8 = null,

    /// The exclusive start of the date range for filtering jobs by creation time.
    /// Jobs created after this
    /// timestamp are included. Use ISO 8601 format (e.g., 2024-01-01T00:00:00Z).
    start_date: ?i64 = null,

    /// Filter by job status. Returns only jobs in the specified status.
    /// Use RUNNING to find active jobs, or FAILED to identify jobs requiring
    /// attention.
    status: ?EnrichmentJobStatus = null,

    /// Filter by time series ID (system identifier). Specify either timeSeriesId or
    /// propertyAlias, but not
    /// both. Returns only jobs analyzing the specified time series.
    time_series_id: ?[]const u8 = null,

    /// The name of the IoT SiteWise workspace to list enrichment jobs from.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .end_date = "endDate",
        .job_type = "jobType",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .property_alias = "propertyAlias",
        .start_date = "startDate",
        .status = "status",
        .time_series_id = "timeSeriesId",
        .workspace_name = "workspaceName",
    };
};

pub const ListEnrichmentJobsOutput = struct {
    /// Array of job summaries matching the filter criteria, ordered by creation
    /// time descending (newest first).
    /// Each summary includes key identifiers (jobId, datasetId,
    /// propertyAlias/timeSeriesId) and status
    /// information without the full job configuration. Use DescribeEnrichmentJob to
    /// retrieve complete details.
    jobs: ?[]const EnrichmentJobSummary = null,

    /// Pagination token to retrieve the next page of results. If present, more jobs
    /// exist that match the
    /// filter criteria. Include this token in a subsequent ListEnrichmentJobs
    /// request to retrieve the next
    /// page. If absent, you have retrieved all matching jobs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .jobs = "jobs",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnrichmentJobsInput, options: CallOptions) !ListEnrichmentJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnrichmentJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/enrichment-jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.dataset_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "datasetId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.end_date) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endDate=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.job_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "jobType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.property_alias) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "propertyAlias=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.start_date) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startDate=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.time_series_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "timeSeriesId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnrichmentJobsOutput {
    const result: ListEnrichmentJobsOutput = try aws.json.parseJsonObject(
        ListEnrichmentJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
