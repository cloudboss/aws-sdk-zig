const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ReturnItemCollectionMetrics = @import("return_item_collection_metrics.zig").ReturnItemCollectionMetrics;
const TransactWriteItem = @import("transact_write_item.zig").TransactWriteItem;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;
const ItemCollectionMetrics = @import("item_collection_metrics.zig").ItemCollectionMetrics;

pub const TransactWriteItemsInput = struct {
    /// Providing a `ClientRequestToken` makes the call to
    /// `TransactWriteItems` idempotent, meaning that multiple identical calls
    /// have the same effect as one single call.
    ///
    /// Although multiple identical calls using the same client request token
    /// produce the same
    /// result on the server (no side effects), the responses to the calls might not
    /// be the
    /// same. If the `ReturnConsumedCapacity` parameter is set, then the initial
    /// `TransactWriteItems` call returns the amount of write capacity units
    /// consumed in making the changes. Subsequent `TransactWriteItems` calls with
    /// the same client token return the number of read capacity units consumed in
    /// reading the
    /// item.
    ///
    /// A client request token is valid for 10 minutes after the first request that
    /// uses it is
    /// completed. After 10 minutes, any request with the same client token is
    /// treated as a new
    /// request. Do not resubmit the same request with the same client token for
    /// more than 10
    /// minutes, or the result might not be idempotent.
    ///
    /// If you submit a request with the same client token but a change in other
    /// parameters
    /// within the 10-minute idempotency window, DynamoDB returns an
    /// `IdempotentParameterMismatch` exception.
    client_request_token: ?[]const u8 = null,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// Determines whether item collection metrics are returned. If set to `SIZE`,
    /// the response includes statistics about item collections (if any), that were
    /// modified
    /// during the operation and are returned in the response. If set to `NONE` (the
    /// default), no statistics are returned.
    return_item_collection_metrics: ?ReturnItemCollectionMetrics = null,

    /// An ordered array of up to 100 `TransactWriteItem` objects, each of which
    /// contains a `ConditionCheck`, `Put`, `Update`, or
    /// `Delete` object. These can operate on items in different tables, but the
    /// tables must reside in the same Amazon Web Services account and Region, and
    /// no two of them
    /// can operate on the same item.
    transact_items: []const TransactWriteItem,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .return_item_collection_metrics = "ReturnItemCollectionMetrics",
        .transact_items = "TransactItems",
    };
};

pub const TransactWriteItemsOutput = struct {
    /// The capacity units consumed by the entire `TransactWriteItems` operation.
    /// The values of the list are ordered according to the ordering of the
    /// `TransactItems` request parameter.
    consumed_capacity: ?[]const ConsumedCapacity = null,

    /// A list of tables that were processed by `TransactWriteItems` and, for each
    /// table, information about any item collections that were affected by
    /// individual
    /// `UpdateItem`, `PutItem`, or `DeleteItem`
    /// operations.
    item_collection_metrics: ?[]const aws.map.MapEntry([]const ItemCollectionMetrics) = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .item_collection_metrics = "ItemCollectionMetrics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TransactWriteItemsInput, options: CallOptions) !TransactWriteItemsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TransactWriteItemsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.TransactWriteItems");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TransactWriteItemsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TransactWriteItemsOutput, body, allocator);
}
