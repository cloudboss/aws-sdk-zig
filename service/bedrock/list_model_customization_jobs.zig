const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortJobsBy = @import("sort_jobs_by.zig").SortJobsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const FineTuningJobStatus = @import("fine_tuning_job_status.zig").FineTuningJobStatus;
const ModelCustomizationJobSummary = @import("model_customization_job_summary.zig").ModelCustomizationJobSummary;

pub const ListModelCustomizationJobsInput = struct {
    /// Return customization jobs created after the specified time.
    creation_time_after: ?i64 = null,

    /// Return customization jobs created before the specified time.
    creation_time_before: ?i64 = null,

    /// The maximum number of results to return in the response. If the total number
    /// of results is greater than this value, use the token returned in the
    /// response in the `nextToken` field when making another request to return the
    /// next batch of results.
    max_results: ?i32 = null,

    /// Return customization jobs only if the job name contains these characters.
    name_contains: ?[]const u8 = null,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, enter the token returned in the `nextToken` field
    /// in the response in this field to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// The field to sort by in the returned list of jobs.
    sort_by: ?SortJobsBy = null,

    /// The sort order of the results.
    sort_order: ?SortOrder = null,

    /// Return customization jobs with the specified status.
    status_equals: ?FineTuningJobStatus = null,

    pub const json_field_names = .{
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

pub const ListModelCustomizationJobsOutput = struct {
    /// Job summaries.
    model_customization_job_summaries: ?[]const ModelCustomizationJobSummary = null,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, use this token when making another request in the
    /// `nextToken` field to return the next batch of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_customization_job_summaries = "modelCustomizationJobSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelCustomizationJobsInput, options: CallOptions) !ListModelCustomizationJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelCustomizationJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/model-customization-jobs";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelCustomizationJobsOutput {
    const result: ListModelCustomizationJobsOutput = try aws.json.parseJsonObject(
        ListModelCustomizationJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
