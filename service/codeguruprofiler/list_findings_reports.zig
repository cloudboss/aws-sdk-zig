const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingsReportSummary = @import("findings_report_summary.zig").FindingsReportSummary;

pub const ListFindingsReportsInput = struct {
    /// A `Boolean` value indicating whether to only return reports from daily
    /// profiles. If set
    /// to `True`, only analysis data from daily profiles is returned. If set to
    /// `False`,
    /// analysis data is returned from smaller time windows (for example, one hour).
    daily_reports_only: ?bool = null,

    /// The end time of the profile to get analysis data about. You must specify
    /// `startTime` and `endTime`.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    end_time: i64,

    /// The maximum number of report results returned by `ListFindingsReports`
    /// in paginated output. When this parameter is used, `ListFindingsReports` only
    /// returns
    /// `maxResults` results in a single page along with a `nextToken` response
    /// element. The remaining results of the initial request
    /// can be seen by sending another `ListFindingsReports` request with the
    /// returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListFindingsReportsRequest`
    /// request where `maxResults` was used and the results exceeded the value of
    /// that parameter.
    /// Pagination continues from the end of the previous results that returned the
    /// `nextToken` value.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve
    /// the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The name of the profiling group from which to search for analysis data.
    profiling_group_name: []const u8,

    /// The start time of the profile to get analysis data about. You must specify
    /// `startTime` and `endTime`.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    start_time: i64,

    pub const json_field_names = .{
        .daily_reports_only = "dailyReportsOnly",
        .end_time = "endTime",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .profiling_group_name = "profilingGroupName",
        .start_time = "startTime",
    };
};

pub const ListFindingsReportsOutput = struct {
    /// The list of analysis results summaries.
    findings_report_summaries: ?[]const FindingsReportSummary = null,

    /// The `nextToken` value to include in a future `ListFindingsReports` request.
    /// When the results of a `ListFindingsReports` request exceed `maxResults`,
    /// this
    /// value can be used to retrieve the next page of results. This value is `null`
    /// when there are no more
    /// results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings_report_summaries = "findingsReportSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFindingsReportsInput, options: CallOptions) !ListFindingsReportsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-profiler", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFindingsReportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/internal/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/findingsReports");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.daily_reports_only) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dailyReportsOnly=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "startTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFindingsReportsOutput {
    const result: ListFindingsReportsOutput = try aws.json.parseJsonObject(
        ListFindingsReportsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
