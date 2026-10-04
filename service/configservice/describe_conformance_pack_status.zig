const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConformancePackStatusDetail = @import("conformance_pack_status_detail.zig").ConformancePackStatusDetail;

pub const DescribeConformancePackStatusInput = struct {
    /// Comma-separated list of conformance pack names.
    conformance_pack_names: ?[]const []const u8 = null,

    /// The maximum number of conformance packs status returned on each page.
    limit: ?i32 = null,

    /// The `nextToken` string returned in a previous request that you use to
    /// request the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .conformance_pack_names = "ConformancePackNames",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const DescribeConformancePackStatusOutput = struct {
    /// A list of `ConformancePackStatusDetail` objects.
    conformance_pack_status_details: ?[]const ConformancePackStatusDetail = null,

    /// The `nextToken` string returned in a previous request that you use to
    /// request the next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .conformance_pack_status_details = "ConformancePackStatusDetails",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConformancePackStatusInput, options: CallOptions) !DescribeConformancePackStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConformancePackStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeConformancePackStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConformancePackStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConformancePackStatusOutput, body, allocator);
}
