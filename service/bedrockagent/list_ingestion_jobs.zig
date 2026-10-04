const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestionJobFilter = @import("ingestion_job_filter.zig").IngestionJobFilter;
const IngestionJobSortBy = @import("ingestion_job_sort_by.zig").IngestionJobSortBy;
const IngestionJobSummary = @import("ingestion_job_summary.zig").IngestionJobSummary;

pub const ListIngestionJobsInput = struct {
    /// The unique identifier of the data source for the list of data ingestion
    /// jobs.
    data_source_id: []const u8,

    /// Contains information about the filters for filtering the data.
    filters: ?[]const IngestionJobFilter = null,

    /// The unique identifier of the knowledge base for the list of data ingestion
    /// jobs.
    knowledge_base_id: []const u8,

    /// The maximum number of results to return in the response. If the total number
    /// of results is greater than this value, use the token returned in the
    /// response in the `nextToken` field when making another request to return the
    /// next batch of results.
    max_results: ?i32 = null,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, enter the token returned in the `nextToken` field
    /// in the response in this field to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// Contains details about how to sort the data.
    sort_by: ?IngestionJobSortBy = null,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .filters = "filters",
        .knowledge_base_id = "knowledgeBaseId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
    };
};

pub const ListIngestionJobsOutput = struct {
    /// A list of data ingestion jobs with information about each job.
    ingestion_job_summaries: ?[]const IngestionJobSummary = null,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, use this token when making another request in the
    /// `nextToken` field to return the next batch of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .ingestion_job_summaries = "ingestionJobSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIngestionJobsInput, options: CallOptions) !ListIngestionJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIngestionJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/datasources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    try path_buf.appendSlice(allocator, "/ingestionjobs/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIngestionJobsOutput {
    const result: ListIngestionJobsOutput = try aws.json.parseJsonObject(
        ListIngestionJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
