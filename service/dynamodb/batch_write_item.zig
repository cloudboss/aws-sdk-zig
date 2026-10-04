const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WriteRequest = @import("write_request.zig").WriteRequest;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ReturnItemCollectionMetrics = @import("return_item_collection_metrics.zig").ReturnItemCollectionMetrics;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;
const ItemCollectionMetrics = @import("item_collection_metrics.zig").ItemCollectionMetrics;

pub const BatchWriteItemInput = struct {
    /// A map of one or more table names or table ARNs and, for each table, a list
    /// of
    /// operations to be performed (`DeleteRequest` or `PutRequest`). Each
    /// element in the map consists of the following:
    ///
    /// * `DeleteRequest` - Perform a `DeleteItem` operation on the
    /// specified item. The item to be deleted is identified by a `Key`
    /// subelement:
    ///
    /// * `Key` - A map of primary key attribute values that uniquely
    /// identify the item. Each entry in this map consists of an attribute name
    /// and an attribute value. For each primary key, you must provide
    /// *all* of the key attributes. For example, with a
    /// simple primary key, you only need to provide a value for the partition
    /// key. For a composite primary key, you must provide values for
    /// *both* the partition key and the sort key.
    ///
    /// * `PutRequest` - Perform a `PutItem` operation on the
    /// specified item. The item to be put is identified by an `Item`
    /// subelement:
    ///
    /// * `Item` - A map of attributes and their values. Each entry in
    /// this map consists of an attribute name and an attribute value. Attribute
    /// values must not be null; string and binary type attributes must have
    /// lengths greater than zero; and set type attributes must not be empty.
    /// Requests that contain empty values are rejected with a
    /// `ValidationException` exception.
    ///
    /// If you specify any attributes that are part of an index key, then the
    /// data types for those attributes must match those of the schema in the
    /// table's attribute definition.
    request_items: []const aws.map.MapEntry([]const WriteRequest),

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// Determines whether item collection metrics are returned. If set to `SIZE`,
    /// the response includes statistics about item collections, if any, that were
    /// modified
    /// during the operation are returned in the response. If set to `NONE` (the
    /// default), no statistics are returned.
    return_item_collection_metrics: ?ReturnItemCollectionMetrics = null,

    pub const json_field_names = .{
        .request_items = "RequestItems",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .return_item_collection_metrics = "ReturnItemCollectionMetrics",
    };
};

pub const BatchWriteItemOutput = struct {
    /// The capacity units consumed by the entire `BatchWriteItem`
    /// operation.
    ///
    /// Each element consists of:
    ///
    /// * `TableName` - The table that consumed the provisioned
    /// throughput.
    ///
    /// * `CapacityUnits` - The total number of capacity units consumed.
    consumed_capacity: ?[]const ConsumedCapacity = null,

    /// A list of tables that were processed by `BatchWriteItem` and, for each
    /// table, information about any item collections that were affected by
    /// individual
    /// `DeleteItem` or `PutItem` operations.
    ///
    /// Each entry consists of the following subelements:
    ///
    /// * `ItemCollectionKey` - The partition key value of the item collection.
    /// This is the same as the partition key value of the item.
    ///
    /// * `SizeEstimateRangeGB` - An estimate of item collection size,
    /// expressed in GB. This is a two-element array containing a lower bound and an
    /// upper bound for the estimate. The estimate includes the size of all the
    /// items in
    /// the table, plus the size of all attributes projected into all of the local
    /// secondary indexes on the table. Use this estimate to measure whether a local
    /// secondary index is approaching its size limit.
    ///
    /// The estimate is subject to change over time; therefore, do not rely on the
    /// precision or accuracy of the estimate.
    item_collection_metrics: ?[]const aws.map.MapEntry([]const ItemCollectionMetrics) = null,

    /// A map of tables and requests against those tables that were not processed.
    /// The
    /// `UnprocessedItems` value is in the same form as
    /// `RequestItems`, so you can provide this value directly to a subsequent
    /// `BatchWriteItem` operation. For more information, see
    /// `RequestItems` in the Request Parameters section.
    ///
    /// Each `UnprocessedItems` entry consists of a table name or table ARN
    /// and, for that table, a list of operations to perform (`DeleteRequest` or
    /// `PutRequest`).
    ///
    /// * `DeleteRequest` - Perform a `DeleteItem` operation on the
    /// specified item. The item to be deleted is identified by a `Key`
    /// subelement:
    ///
    /// * `Key` - A map of primary key attribute values that uniquely
    /// identify the item. Each entry in this map consists of an attribute name
    /// and an attribute value.
    ///
    /// * `PutRequest` - Perform a `PutItem` operation on the
    /// specified item. The item to be put is identified by an `Item`
    /// subelement:
    ///
    /// * `Item` - A map of attributes and their values. Each entry in
    /// this map consists of an attribute name and an attribute value. Attribute
    /// values must not be null; string and binary type attributes must have
    /// lengths greater than zero; and set type attributes must not be empty.
    /// Requests that contain empty values will be rejected with a
    /// `ValidationException` exception.
    ///
    /// If you specify any attributes that are part of an index key, then the
    /// data types for those attributes must match those of the schema in the
    /// table's attribute definition.
    ///
    /// If there are no unprocessed items remaining, the response contains an empty
    /// `UnprocessedItems` map.
    unprocessed_items: ?[]const aws.map.MapEntry([]const WriteRequest) = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .item_collection_metrics = "ItemCollectionMetrics",
        .unprocessed_items = "UnprocessedItems",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchWriteItemInput, options: CallOptions) !BatchWriteItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchWriteItemInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.BatchWriteItem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchWriteItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchWriteItemOutput, body, allocator);
}
