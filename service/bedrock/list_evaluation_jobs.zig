const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationType = @import("application_type.zig").ApplicationType;
const SortJobsBy = @import("sort_jobs_by.zig").SortJobsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const EvaluationJobStatus = @import("evaluation_job_status.zig").EvaluationJobStatus;
const EvaluationSummary = @import("evaluation_summary.zig").EvaluationSummary;

pub const ListEvaluationJobsInput = struct {
    /// A filter to only list evaluation jobs that are either model evaluations or
    /// knowledge base evaluations.
    application_type_equals: ?ApplicationType = null,

    /// A filter to only list evaluation jobs created after a specified time.
    creation_time_after: ?i64 = null,

    /// A filter to only list evaluation jobs created before a specified time.
    creation_time_before: ?i64 = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// A filter to only list evaluation jobs that contain a specified string in the
    /// job name.
    name_contains: ?[]const u8 = null,

    /// Continuation token from the previous response, for Amazon Bedrock to list
    /// the next set of results.
    next_token: ?[]const u8 = null,

    /// Specifies a creation time to sort the list of evaluation jobs by when they
    /// were created.
    sort_by: ?SortJobsBy = null,

    /// Specifies whether to sort the list of evaluation jobs by either ascending or
    /// descending order.
    sort_order: ?SortOrder = null,

    /// A filter to only list evaluation jobs that are of a certain status.
    status_equals: ?EvaluationJobStatus = null,

    pub const json_field_names = .{
        .application_type_equals = "applicationTypeEquals",
        .creation_time_after = "creationTimeAfter",
        .creation_time_before = "creationTimeBefore",
        .max_results = "maxResults",
        .name_contains = "nameContains",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
        .status_equals = "statusEquals",
    };
};

pub const ListEvaluationJobsOutput = struct {
    /// A list of summaries of the evaluation jobs.
    job_summaries: ?[]const EvaluationSummary = null,

    /// Continuation token from the previous response, for Amazon Bedrock to list
    /// the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_summaries = "jobSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEvaluationJobsInput, options: CallOptions) !ListEvaluationJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEvaluationJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/evaluation-jobs";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.application_type_equals) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "applicationTypeEquals=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.creation_time_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "creationTimeAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.creation_time_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "creationTimeBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEvaluationJobsOutput {
    var result: ListEvaluationJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListEvaluationJobsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
