const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InventoryAggregator = @import("inventory_aggregator.zig").InventoryAggregator;
const InventoryFilter = @import("inventory_filter.zig").InventoryFilter;
const ResultAttribute = @import("result_attribute.zig").ResultAttribute;
const InventoryResultEntity = @import("inventory_result_entity.zig").InventoryResultEntity;

pub const GetInventoryInput = struct {
    /// Returns counts of inventory types based on one or more expressions. For
    /// example, if you
    /// aggregate by using an expression that uses the
    /// `AWS:InstanceInformation.PlatformType`
    /// type, you can see a count of how many Windows and Linux managed nodes exist
    /// in your inventoried
    /// fleet.
    aggregators: ?[]const InventoryAggregator = null,

    /// One or more filters. Use a filter to return a more specific list of results.
    filters: ?[]const InventoryFilter = null,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The list of inventory item types to return.
    result_attributes: ?[]const ResultAttribute = null,

    pub const json_field_names = .{
        .aggregators = "Aggregators",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .result_attributes = "ResultAttributes",
    };
};

pub const GetInventoryOutput = struct {
    /// Collection of inventory entities such as a collection of managed node
    /// inventory.
    entities: ?[]const InventoryResultEntity = null,

    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entities = "Entities",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInventoryInput, options: CallOptions) !GetInventoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInventoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetInventory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInventoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInventoryOutput, body, allocator);
}
