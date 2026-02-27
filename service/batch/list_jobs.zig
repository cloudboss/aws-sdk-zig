const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const KeyValuesPair = @import("key_values_pair.zig").KeyValuesPair;
const JobStatus = @import("job_status.zig").JobStatus;
const JobSummary = @import("job_summary.zig").JobSummary;

pub const ListJobsInput = struct {
    /// The job ID for an array job. Specifying an array job ID with this parameter
    /// lists all
    /// child jobs from within the specified array.
    array_job_id: ?[]const u8 = null,

    /// The filter to apply to the query. Only one filter can be used at a time.
    /// When the filter
    /// is used, `jobStatus` is ignored. The filter doesn't apply to child jobs in
    /// an array
    /// or multi-node parallel (MNP) jobs. The results are sorted by the `createdAt`
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
    /// **JOB_DEFINITION**
    ///
    /// The value for the filter is the name or Amazon Resource Name (ARN) of the
    /// job definition. This
    /// corresponds to the `jobDefinition` value. The value is case sensitive. When
    /// the value for the filter is the job definition name, the results include all
    /// the jobs
    /// that used any revision of that job definition name. If the value ends with
    /// an asterisk
    /// (*), the filter matches any job definition name that begins with the string
    /// before the
    /// '*'. For example, `jd1` matches only `jd1`, and `jd1*`
    /// matches both `jd1` and `jd1A`. The version of the job definition
    /// that's used doesn't affect the sort order. When the `JOB_DEFINITION` filter
    /// is used and the ARN is used (which is in the form
    /// `arn:${Partition}:batch:${Region}:${Account}:job-definition/${JobDefinitionName}:${Revision}`),
    /// the results include jobs that used the specified revision of the job
    /// definition.
    /// Asterisk (*) isn't supported when the ARN is used.
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

    /// The name or full Amazon Resource Name (ARN) of the job queue used to list
    /// jobs.
    job_queue: ?[]const u8 = null,

    /// The job status used to filter jobs in the specified queue. If the `filters`
    /// parameter is specified, the `jobStatus` parameter is ignored and jobs with
    /// any
    /// status are returned. If you don't specify a status, only `RUNNING` jobs are
    /// returned.
    ///
    /// Array job parents are updated to `PENDING` when any child job is updated to
    /// `RUNNABLE` and remain in `PENDING` status while child jobs are running. To
    /// view these jobs, filter by `PENDING` status until all child jobs reach a
    /// terminal state.
    job_status: ?JobStatus = null,

    /// The maximum number of results returned by `ListJobs` in a paginated output.
    /// When this parameter is used, `ListJobs` returns up to `maxResults` results
    /// in a single page and a `nextToken` response element, if applicable. The
    /// remaining results of the initial request can be seen by sending another
    /// `ListJobs` request with the returned `nextToken` value.
    ///
    /// The following outlines key parameters and limitations:
    ///
    /// * The minimum value is 1.
    ///
    /// * When `--job-status` is used, Batch returns up to 1000 values.
    ///
    /// * When `--filters` is used, Batch returns up to 100 values.
    ///
    /// * If neither parameter is used, then `ListJobs` returns up to
    /// 1000 results (jobs that are in the `RUNNING` status) and a `nextToken`
    /// value, if applicable.
    max_results: ?i32 = null,

    /// The job ID for a multi-node parallel job. Specifying a multi-node parallel
    /// job ID with
    /// this parameter lists all nodes that are associated with the specified job.
    multi_node_job_id: ?[]const u8 = null,

    /// The `nextToken` value returned from a previous paginated `ListJobs`
    /// request where `maxResults` was used and the results exceeded the value of
    /// that
    /// parameter. Pagination continues from the end of the previous results that
    /// returned the
    /// `nextToken` value. This value is `null` when there are no more results
    /// to return.
    ///
    /// Treat this token as an opaque identifier that's only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .array_job_id = "arrayJobId",
        .filters = "filters",
        .job_queue = "jobQueue",
        .job_status = "jobStatus",
        .max_results = "maxResults",
        .multi_node_job_id = "multiNodeJobId",
        .next_token = "nextToken",
    };
};

pub const ListJobsOutput = struct {
    /// A list of job summaries that match the request.
    job_summary_list: ?[]const JobSummary = null,

    /// The `nextToken` value to include in a future `ListJobs` request.
    /// When the results of a `ListJobs` request exceed `maxResults`, this value
    /// can be used to retrieve the next page of results. This value is `null` when
    /// there
    /// are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_summary_list = "jobSummaryList",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobsInput, options: Options) !ListJobsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/listjobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.array_job_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"arrayJobId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
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
    if (input.multi_node_job_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"multiNodeJobId\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListJobsOutput {
    var result: ListJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListJobsOutput, body, alloc);
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
