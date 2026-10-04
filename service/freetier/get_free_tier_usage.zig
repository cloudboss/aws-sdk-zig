const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Expression = @import("expression.zig").Expression;
const FreeTierUsage = @import("free_tier_usage.zig").FreeTierUsage;

pub const GetFreeTierUsageInput = struct {
    /// An expression that specifies the conditions that you want each
    /// `FreeTierUsage` object to meet.
    filter: ?Expression = null,

    /// The maximum number of results to return in the response. `MaxResults` means
    /// that there can be up to the specified number of values, but there might be
    /// fewer results based on your filters.
    max_results: ?i32 = null,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetFreeTierUsageOutput = struct {
    /// The list of Free Tier usage objects that meet your filter expression.
    free_tier_usages: ?[]const FreeTierUsage = null,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .free_tier_usages = "freeTierUsages",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFreeTierUsageInput, options: CallOptions) !GetFreeTierUsageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsfreetierservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFreeTierUsageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("freetier", "FreeTier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFreeTierService.GetFreeTierUsage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFreeTierUsageOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetFreeTierUsageOutput, body, allocator);
}
