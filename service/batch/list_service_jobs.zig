const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const KeyValuesPair = @import("key_values_pair.zig").KeyValuesPair;
const ServiceJobStatus = @import("service_job_status.zig").ServiceJobStatus;
const ServiceJobSummary = @import("service_job_summary.zig").ServiceJobSummary;

pub const ListServiceJobsInput = struct {
    /// The filter to apply to the query. Only one filter can be used at a time.
    /// When the filter
    /// is used, `jobStatus` is ignored. The results are sorted by the `createdAt`
    /// field,
    /// with the most recent jobs being first.
    ///
    /// **JOB_NAME**
    ///
    /// The value of the filter is a case-insensitive match for the job name. If the
    /// value
    /// ends with an asterisk (*), the filter matches any job name that begins with
    /// the string
    /// before the '*'. This corresponds to the `jobName` value. For example,
    /// `test1` matches both `Test1` and `test1`, and
    /// `test1*` matches both `test1` and `Test10`. When the
    /// `JOB_NAME` filter is used, the results are grouped by the job name and
    /// version.
    ///
    /// **BEFORE_CREATED_AT**
    ///
    /// The value for the filter is the time that's before the job was created. This
    /// corresponds to the `createdAt` value. The value is a string representation
    /// of
    /// the number of milliseconds since 00:00:00 UTC (midnight) on January 1, 1970.
    ///
    /// **AFTER_CREATED_AT**
    ///
    /// The value for the filter is the time that's after the job was created. This
    /// corresponds to the `createdAt` value. The value is a string representation
    /// of
    /// the number of milliseconds since 00:00:00 UTC (midnight) on January 1, 1970.
    filters: ?[]const KeyValuesPair = null,

    /// The name or ARN of the job queue with which to list service jobs.
    job_queue: ?[]const u8 = null,

    /// The job status with which to filter service jobs.
    job_status: ?ServiceJobStatus = null,

    /// The maximum number of results returned by `ListServiceJobs` in paginated
    /// output. When this parameter is used, `ListServiceJobs` only returns
    /// `maxResults` results in a single page and a `nextToken` response element.
    /// The remaining results of the initial request can be seen by sending another
    /// `ListServiceJobs` request with the returned `nextToken` value. This value
    /// can be between 1 and 100. If this parameter isn't used, then
    /// `ListServiceJobs` returns up to 100 results and a `nextToken` value if
    /// applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated `ListServiceJobs`
    /// request where `maxResults` was used and the results exceeded the value of
    /// that parameter. Pagination continues from the end of the previous results
    /// that returned the `nextToken` value. This value is `null` when there are no
    /// more results to return.
    ///
    /// Treat this token as an opaque identifier that's only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .job_queue = "jobQueue",
        .job_status = "jobStatus",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListServiceJobsOutput = struct {
    /// A list of service job summaries.
    job_summary_list: ?[]const ServiceJobSummary = null,

    /// The `nextToken` value to include in a future `ListServiceJobs` request. When
    /// the results of a `ListServiceJobs` request exceed `maxResults`, this value
    /// can be used to retrieve the next page of results. This value is `null` when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_summary_list = "jobSummaryList",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceJobsInput, options: Options) !ListServiceJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListServiceJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/listservicejobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.job_queue) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"jobQueue\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.job_status) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"jobStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListServiceJobsOutput {
    var result: ListServiceJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListServiceJobsOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
