const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OpsAggregator = @import("ops_aggregator.zig").OpsAggregator;
const OpsFilter = @import("ops_filter.zig").OpsFilter;
const OpsResultAttribute = @import("ops_result_attribute.zig").OpsResultAttribute;
const OpsEntity = @import("ops_entity.zig").OpsEntity;

pub const GetOpsSummaryInput = struct {
    /// Optional aggregators that return counts of OpsData based on one or more
    /// expressions.
    aggregators: ?[]const OpsAggregator = null,

    /// Optional filters used to scope down the returned OpsData.
    filters: ?[]const OpsFilter = null,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// A token to start the list. Use this token to get the next set of results.
    next_token: ?[]const u8 = null,

    /// The OpsData data type to return.
    result_attributes: ?[]const OpsResultAttribute = null,

    /// Specify the name of a resource data sync to get.
    sync_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregators = "Aggregators",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .result_attributes = "ResultAttributes",
        .sync_name = "SyncName",
    };
};

pub const GetOpsSummaryOutput = struct {
    /// The list of aggregated details and filtered OpsData.
    entities: ?[]const OpsEntity = null,

    /// The token for the next set of items to return. Use this token to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entities = "Entities",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOpsSummaryInput, options: CallOptions) !GetOpsSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOpsSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetOpsSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOpsSummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOpsSummaryOutput, body, allocator);
}
