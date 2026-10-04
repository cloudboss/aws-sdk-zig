const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateAggregatorV2Input = struct {
    /// The ARN of the Aggregator V2.
    aggregator_v2_arn: []const u8,

    /// A list of Amazon Web Services Regions linked to the aggegation Region.
    linked_regions: ?[]const []const u8 = null,

    /// Determines how Amazon Web Services Regions should be linked to the
    /// Aggregator V2.
    region_linking_mode: []const u8,

    pub const json_field_names = .{
        .aggregator_v2_arn = "AggregatorV2Arn",
        .linked_regions = "LinkedRegions",
        .region_linking_mode = "RegionLinkingMode",
    };
};

pub const UpdateAggregatorV2Output = struct {
    /// The Amazon Web Services Region where data is aggregated.
    aggregation_region: ?[]const u8 = null,

    /// The ARN of the Aggregator V2.
    aggregator_v2_arn: ?[]const u8 = null,

    /// A list of Amazon Web Services Regions linked to the aggegation Region.
    linked_regions: ?[]const []const u8 = null,

    /// Determines how Amazon Web Services Regions should be linked to the
    /// Aggregator V2.
    region_linking_mode: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_region = "AggregationRegion",
        .aggregator_v2_arn = "AggregatorV2Arn",
        .linked_regions = "LinkedRegions",
        .region_linking_mode = "RegionLinkingMode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAggregatorV2Input, options: CallOptions) !UpdateAggregatorV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAggregatorV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/aggregatorv2/update/");
    try path_buf.appendSlice(allocator, input.aggregator_v2_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAggregatorV2Output {
    var result: UpdateAggregatorV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAggregatorV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
