const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetFindingAggregatorInput = struct {
    /// The ARN of the finding aggregator to return details for. To obtain the ARN,
    /// use `ListFindingAggregators`.
    finding_aggregator_arn: []const u8,

    pub const json_field_names = .{
        .finding_aggregator_arn = "FindingAggregatorArn",
    };
};

pub const GetFindingAggregatorOutput = struct {
    /// The home Region. Findings generated in linked Regions are replicated and
    /// sent to the home Region.
    finding_aggregation_region: ?[]const u8 = null,

    /// The ARN of the finding aggregator.
    finding_aggregator_arn: ?[]const u8 = null,

    /// Indicates whether to link all Regions, all Regions except for a list of
    /// excluded Regions, or a list of included Regions.
    region_linking_mode: ?[]const u8 = null,

    /// The list of excluded Regions or included Regions.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .finding_aggregation_region = "FindingAggregationRegion",
        .finding_aggregator_arn = "FindingAggregatorArn",
        .region_linking_mode = "RegionLinkingMode",
        .regions = "Regions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingAggregatorInput, options: CallOptions) !GetFindingAggregatorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingAggregatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/findingAggregator/get/");
    try path_buf.appendSlice(allocator, input.finding_aggregator_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingAggregatorOutput {
    var result: GetFindingAggregatorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFindingAggregatorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
