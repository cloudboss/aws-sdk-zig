const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InventoryItemSchema = @import("inventory_item_schema.zig").InventoryItemSchema;

pub const GetInventorySchemaInput = struct {
    /// Returns inventory schemas that support aggregation. For example, this call
    /// returns the
    /// `AWS:InstanceInformation` type, because it supports aggregation based on the
    /// `PlatformName`, `PlatformType`, and `PlatformVersion`
    /// attributes.
    aggregator: ?bool = null,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// Returns the sub-type schema for a specified inventory type.
    sub_type: ?bool = null,

    /// The type of inventory item to return.
    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregator = "Aggregator",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sub_type = "SubType",
        .type_name = "TypeName",
    };
};

pub const GetInventorySchemaOutput = struct {
    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    /// Inventory schemas returned by the request.
    schemas: ?[]const InventoryItemSchema = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .schemas = "Schemas",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInventorySchemaInput, options: CallOptions) !GetInventorySchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInventorySchemaInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetInventorySchema");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInventorySchemaOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInventorySchemaOutput, body, allocator);
}
