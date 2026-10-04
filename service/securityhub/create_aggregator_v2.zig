const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateAggregatorV2Input = struct {
    /// A unique identifier used to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The list of Regions that are linked to the aggregation Region.
    linked_regions: ?[]const []const u8 = null,

    /// Determines how Regions are linked to an Aggregator V2.
    region_linking_mode: []const u8,

    /// A list of key-value pairs to be applied to the AggregatorV2.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .linked_regions = "LinkedRegions",
        .region_linking_mode = "RegionLinkingMode",
        .tags = "Tags",
    };
};

pub const CreateAggregatorV2Output = struct {
    /// The Amazon Web Services Region where data is aggregated.
    aggregation_region: ?[]const u8 = null,

    /// The ARN of the AggregatorV2.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAggregatorV2Input, options: CallOptions) !CreateAggregatorV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAggregatorV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/aggregatorv2/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.linked_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkedRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RegionLinkingMode\":");
    try aws.json.writeValue(@TypeOf(input.region_linking_mode), input.region_linking_mode, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAggregatorV2Output {
    var result: CreateAggregatorV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAggregatorV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
