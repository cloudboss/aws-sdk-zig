const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AudienceGenerationJobSummary = @import("audience_generation_job_summary.zig").AudienceGenerationJobSummary;

pub const ListAudienceGenerationJobsInput = struct {
    /// The identifier of the collaboration that contains the audience generation
    /// jobs that you are interested in.
    collaboration_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the configured audience model that was
    /// used for the audience generation jobs that you are interested in.
    configured_audience_model_arn: ?[]const u8 = null,

    /// The maximum size of the results that is returned per call.
    max_results: ?i32 = null,

    /// The token value retrieved from a previous call to access the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .collaboration_id = "collaborationId",
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAudienceGenerationJobsOutput = struct {
    /// The audience generation jobs that match the request.
    audience_generation_jobs: ?[]const AudienceGenerationJobSummary = null,

    /// The token value used to access the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .audience_generation_jobs = "audienceGenerationJobs",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAudienceGenerationJobsInput, options: CallOptions) !ListAudienceGenerationJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAudienceGenerationJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audience-generation-job";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.collaboration_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "collaborationId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.configured_audience_model_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "configuredAudienceModelArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAudienceGenerationJobsOutput {
    const result: ListAudienceGenerationJobsOutput = try aws.json.parseJsonObject(
        ListAudienceGenerationJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
