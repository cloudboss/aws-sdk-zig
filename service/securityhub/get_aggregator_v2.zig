const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetAggregatorV2Input = struct {
    /// The ARN of the Aggregator V2.
    aggregator_v2_arn: []const u8,

    pub const json_field_names = .{
        .aggregator_v2_arn = "AggregatorV2Arn",
    };
};

pub const GetAggregatorV2Output = struct {
    /// The Amazon Web Services Region where data is aggregated.
    aggregation_region: ?[]const u8 = null,

    /// The ARN of the Aggregator V2.
    aggregator_v2_arn: ?[]const u8 = null,

    /// The list of Regions that are linked to the aggregation Region.
    linked_regions: ?[]const []const u8 = null,

    /// Determines how Regions are linked to an Aggregator V2.
    region_linking_mode: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_region = "AggregationRegion",
        .aggregator_v2_arn = "AggregatorV2Arn",
        .linked_regions = "LinkedRegions",
        .region_linking_mode = "RegionLinkingMode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAggregatorV2Input, options: CallOptions) !GetAggregatorV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAggregatorV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/aggregatorv2/get/");
    try path_buf.appendSlice(allocator, input.aggregator_v2_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAggregatorV2Output {
    var result: GetAggregatorV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAggregatorV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
