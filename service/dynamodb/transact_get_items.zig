const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const TransactGetItem = @import("transact_get_item.zig").TransactGetItem;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;
const ItemResponse = @import("item_response.zig").ItemResponse;

pub const TransactGetItemsInput = struct {
    /// A value of `TOTAL` causes consumed capacity information to be returned, and
    /// a value of `NONE` prevents that information from being returned. No other
    /// value is valid.
    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// An ordered array of up to 100 `TransactGetItem` objects, each of which
    /// contains a `Get` structure.
    transact_items: []const TransactGetItem,

    pub const json_field_names = .{
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .transact_items = "TransactItems",
    };
};

pub const TransactGetItemsOutput = struct {
    /// If the *ReturnConsumedCapacity* value was `TOTAL`, this
    /// is an array of `ConsumedCapacity` objects, one for each table addressed by
    /// `TransactGetItem` objects in the *TransactItems*
    /// parameter. These `ConsumedCapacity` objects report the read-capacity units
    /// consumed by the `TransactGetItems` call in that table.
    consumed_capacity: ?[]const ConsumedCapacity = null,

    /// An ordered array of up to 100 `ItemResponse` objects, each of which
    /// corresponds to the `TransactGetItem` object in the same position in the
    /// *TransactItems* array. Each `ItemResponse` object
    /// contains a Map of the name-value pairs that are the projected attributes of
    /// the
    /// requested item.
    ///
    /// If a requested item could not be retrieved, the corresponding
    /// `ItemResponse` object is Null, or if the requested item has no projected
    /// attributes, the corresponding `ItemResponse` object is an empty Map.
    responses: ?[]const ItemResponse = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .responses = "Responses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TransactGetItemsInput, options: CallOptions) !TransactGetItemsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TransactGetItemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.TransactGetItems");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TransactGetItemsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TransactGetItemsOutput, body, allocator);
}
