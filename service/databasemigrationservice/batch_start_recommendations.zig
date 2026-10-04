const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StartRecommendationsRequestEntry = @import("start_recommendations_request_entry.zig").StartRecommendationsRequestEntry;
const BatchStartRecommendationsErrorEntry = @import("batch_start_recommendations_error_entry.zig").BatchStartRecommendationsErrorEntry;

pub const BatchStartRecommendationsInput = struct {
    /// Provides information about source databases to analyze. After this analysis,
    /// Fleet
    /// Advisor recommends target engines for each source database.
    data: ?[]const StartRecommendationsRequestEntry = null,

    pub const json_field_names = .{
        .data = "Data",
    };
};

pub const BatchStartRecommendationsOutput = struct {
    /// A list with error details about the analysis of each source database.
    error_entries: ?[]const BatchStartRecommendationsErrorEntry = null,

    pub const json_field_names = .{
        .error_entries = "ErrorEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchStartRecommendationsInput, options: CallOptions) !BatchStartRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchStartRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.BatchStartRecommendations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchStartRecommendationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchStartRecommendationsOutput, body, allocator);
}
