const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SortJobsBy = @import("sort_jobs_by.zig").SortJobsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ModelInvocationJobStatus = @import("model_invocation_job_status.zig").ModelInvocationJobStatus;
const ModelInvocationJobSummary = @import("model_invocation_job_summary.zig").ModelInvocationJobSummary;

pub const ListModelInvocationJobsInput = struct {
    /// The maximum number of results to return. If there are more results than the
    /// number that you specify, a `nextToken` value is returned. Use the
    /// `nextToken` in a request to return the next batch of results.
    max_results: ?i32 = null,

    /// Specify a string to filter for batch inference jobs whose names contain the
    /// string.
    name_contains: ?[]const u8 = null,

    /// If there were more results than the value you specified in the `maxResults`
    /// field in a previous `ListModelInvocationJobs` request, the response would
    /// have returned a `nextToken` value. To see the next batch of results, send
    /// the `nextToken` value in another request.
    next_token: ?[]const u8 = null,

    /// An attribute by which to sort the results.
    sort_by: ?SortJobsBy = null,

    /// Specifies whether to sort the results by ascending or descending order.
    sort_order: ?SortOrder = null,

    /// Specify a status to filter for batch inference jobs whose statuses match the
    /// string you specify.
    ///
    /// The following statuses are possible:
    ///
    /// * Submitted – This job has been submitted to a queue for validation.
    /// * Validating – This job is being validated for the requirements described in
    ///   [Format and upload your batch inference
    ///   data](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-data.html). The criteria include the following:
    ///
    /// * Your IAM service role has access to the Amazon S3 buckets containing your
    ///   files.
    /// * Your files are .jsonl files and each individual record is a JSON object in
    ///   the correct format. Note that validation doesn't check if the `modelInput`
    ///   value matches the request body for the model.
    /// * Your files fulfill the requirements for file size and number of records.
    ///   For more information, see [Quotas for Amazon
    ///   Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/quotas.html).
    ///
    /// * Scheduled – This job has been validated and is now in a queue. The job
    ///   will automatically start when it reaches its turn.
    /// * Expired – This job timed out because it was scheduled but didn't begin
    ///   before the set timeout duration. Submit a new job request.
    /// * InProgress – This job has begun. You can start viewing the results in the
    ///   output S3 location.
    /// * Completed – This job has successfully completed. View the output files in
    ///   the output S3 location.
    /// * PartiallyCompleted – This job has partially completed. Not all of your
    ///   records could be processed in time. View the output files in the output S3
    ///   location.
    /// * Failed – This job has failed. Check the failure message for any further
    ///   details. For further assistance, reach out to the [Amazon Web Services
    ///   Support Center](https://console.aws.amazon.com/support/home/).
    /// * Stopped – This job was stopped by a user.
    /// * Stopping – This job is being stopped by a user.
    status_equals: ?ModelInvocationJobStatus = null,

    /// Specify a time to filter for batch inference jobs that were submitted after
    /// the time you specify.
    submit_time_after: ?i64 = null,

    /// Specify a time to filter for batch inference jobs that were submitted before
    /// the time you specify.
    submit_time_before: ?i64 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .name_contains = "nameContains",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
        .status_equals = "statusEquals",
        .submit_time_after = "submitTimeAfter",
        .submit_time_before = "submitTimeBefore",
    };
};

pub const ListModelInvocationJobsOutput = struct {
    /// A list of items, each of which contains a summary about a batch inference
    /// job.
    invocation_job_summaries: ?[]const ModelInvocationJobSummary = null,

    /// If there are more results than can fit in the response, a `nextToken` is
    /// returned. Use the `nextToken` in a request to return the next batch of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .invocation_job_summaries = "invocationJobSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelInvocationJobsInput, options: CallOptions) !ListModelInvocationJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelInvocationJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/model-invocation-jobs";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.name_contains) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nameContains=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.sort_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortOrder=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.status_equals) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "statusEquals=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.submit_time_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "submitTimeAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.submit_time_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "submitTimeBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelInvocationJobsOutput {
    var result: ListModelInvocationJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListModelInvocationJobsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
