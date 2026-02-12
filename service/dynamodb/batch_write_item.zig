const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ReturnItemCollectionMetrics = @import("return_item_collection_metrics.zig").ReturnItemCollectionMetrics;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;

/// The `BatchWriteItem` operation puts or deletes multiple items in one or
/// more tables. A single call to `BatchWriteItem` can transmit up to 16MB of
/// data over the network, consisting of up to 25 item put or delete operations.
/// While
/// individual items can be up to 400 KB once stored, it's important to note
/// that an item's
/// representation might be greater than 400KB while being sent in DynamoDB's
/// JSON format
/// for the API call. For more details on this distinction, see [Naming Rules
/// and Data
/// Types](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html).
///
/// **Note:**
///
/// `BatchWriteItem` cannot update items. If you perform a
/// `BatchWriteItem` operation on an existing item, that item's values
/// will be overwritten by the operation and it will appear like it was updated.
/// To
/// update items, we recommend you use the `UpdateItem` action.
///
/// The individual `PutItem` and `DeleteItem` operations specified
/// in `BatchWriteItem` are atomic; however `BatchWriteItem` as a
/// whole is not. If any requested operations fail because the table's
/// provisioned
/// throughput is exceeded or an internal processing failure occurs, the failed
/// operations
/// are returned in the `UnprocessedItems` response parameter. You can
/// investigate and optionally resend the requests. Typically, you would call
/// `BatchWriteItem` in a loop. Each iteration would check for unprocessed
/// items and submit a new `BatchWriteItem` request with those unprocessed items
/// until all items have been processed.
///
/// For tables and indexes with provisioned capacity, if none of the items can
/// be
/// processed due to insufficient provisioned throughput on all of the tables in
/// the
/// request, then `BatchWriteItem` returns a
/// `ProvisionedThroughputExceededException`. For all tables and indexes, if
/// none of the items can be processed due to other throttling scenarios (such
/// as exceeding
/// partition level limits), then `BatchWriteItem` returns a
/// `ThrottlingException`.
///
/// **Important:**
///
/// If DynamoDB returns any unprocessed items, you should retry the batch
/// operation on
/// those items. However, *we strongly recommend that you use an exponential
/// backoff algorithm*. If you retry the batch operation immediately, the
/// underlying read or write requests can still fail due to throttling on the
/// individual
/// tables. If you delay the batch operation using exponential backoff, the
/// individual
/// requests in the batch are much more likely to succeed.
///
/// For more information, see [Batch Operations and Error
/// Handling](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ErrorHandling.html#Programming.Errors.BatchOperations) in the *Amazon DynamoDB
/// Developer Guide*.
///
/// With `BatchWriteItem`, you can efficiently write or delete large amounts of
/// data, such as from Amazon EMR, or copy data from another database into
/// DynamoDB. In
/// order to improve performance with these large-scale operations,
/// `BatchWriteItem` does not behave in the same way as individual
/// `PutItem` and `DeleteItem` calls would. For example, you
/// cannot specify conditions on individual put and delete requests, and
/// `BatchWriteItem` does not return deleted items in the response.
///
/// If you use a programming language that supports concurrency, you can use
/// threads to
/// write items in parallel. Your application must include the necessary logic
/// to manage the
/// threads. With languages that don't support threading, you must update or
/// delete the
/// specified items one at a time. In both situations, `BatchWriteItem` performs
/// the specified put and delete operations in parallel, giving you the power of
/// the thread
/// pool approach without having to introduce complexity into your application.
///
/// Parallel processing reduces latency, but each specified put and delete
/// request
/// consumes the same number of write capacity units whether it is processed in
/// parallel or
/// not. Delete operations on nonexistent items consume one write capacity unit.
///
/// If one or more of the following is true, DynamoDB rejects the entire batch
/// write
/// operation:
///
/// * One or more tables specified in the `BatchWriteItem` request does
/// not exist.
///
/// * Primary key attributes specified on an item in the request do not match
///   those
/// in the corresponding table's primary key schema.
///
/// * You try to perform multiple operations on the same item in the same
/// `BatchWriteItem` request. For example, you cannot put and delete
/// the same item in the same `BatchWriteItem` request.
///
/// * Your request contains at least two items with identical hash and range
///   keys
/// (which essentially is two put operations).
///
/// * There are more than 25 requests in the batch.
///
/// * Any individual item in a batch exceeds 400 KB.
///
/// * The total request size exceeds 16 MB.
///
/// * Any individual items with keys exceeding the key length limits. For a
/// partition key, the limit is 2048 bytes and for a sort key, the limit is 1024
/// bytes.
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
    request_items: []const u8,

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
    item_collection_metrics: ?[]const u8 = null,

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
    unprocessed_items: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *BatchWriteItemOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .item_collection_metrics = "ItemCollectionMetrics",
        .unprocessed_items = "UnprocessedItems",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: BatchWriteItemInput, options: Options) !BatchWriteItemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dynamodb");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: BatchWriteItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("dynamodb", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.BatchWriteItem");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !BatchWriteItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchWriteItemOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = findJsonValue(body, "message") orelse findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "BackupInUseException")) {
        return .{ .backup_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "BackupNotFoundException")) {
        return .{ .backup_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ConditionalCheckFailedException")) {
        return .{ .conditional_check_failed_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ContinuousBackupsUnavailableException")) {
        return .{ .continuous_backups_unavailable_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateItemException")) {
        return .{ .duplicate_item_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ExportConflictException")) {
        return .{ .export_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ExportNotFoundException")) {
        return .{ .export_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableAlreadyExistsException")) {
        return .{ .global_table_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableNotFoundException")) {
        return .{ .global_table_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .idempotent_parameter_mismatch_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ImportConflictException")) {
        return .{ .import_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ImportNotFoundException")) {
        return .{ .import_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "IndexNotFoundException")) {
        return .{ .index_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .internal_server_error = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        return .{ .invalid_endpoint_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportTimeException")) {
        return .{ .invalid_export_time_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreTimeException")) {
        return .{ .invalid_restore_time_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ItemCollectionSizeLimitExceededException")) {
        return .{ .item_collection_size_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PointInTimeRecoveryUnavailableException")) {
        return .{ .point_in_time_recovery_unavailable_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        return .{ .policy_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        return .{ .provisioned_throughput_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaAlreadyExistsException")) {
        return .{ .replica_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaNotFoundException")) {
        return .{ .replica_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicatedWriteConflictException")) {
        return .{ .replicated_write_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        return .{ .request_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TableAlreadyExistsException")) {
        return .{ .table_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TableInUseException")) {
        return .{ .table_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TableNotFoundException")) {
        return .{ .table_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .throttling_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionCanceledException")) {
        return .{ .transaction_canceled_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionConflictException")) {
        return .{ .transaction_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionInProgressException")) {
        return .{ .transaction_in_progress_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}

fn findJsonValue(json: []const u8, key: []const u8) ?[]const u8 {
    // Build search pattern: "key"
    var buf: [258]u8 = undefined;
    if (key.len + 2 > buf.len) return null;
    buf[0] = 0x22; // double-quote
    @memcpy(buf[1..][0..key.len], key);
    buf[key.len + 1] = 0x22; // double-quote
    const search = buf[0 .. key.len + 2];
    const key_start = std.mem.indexOf(u8, json, search) orelse return null;
    var pos = key_start + search.len;

    // Skip whitespace and colon
    while (pos < json.len) : (pos += 1) {
        if (json[pos] != ' ' and json[pos] != ':') break;
    }
    if (pos >= json.len) return null;

    if (json[pos] == 0x22) {
        const start = pos + 1;
        const end = std.mem.indexOfScalarPos(u8, json, start, 0x22) orelse return null;
        return json[start..end];
    }

    const start = pos;
    while (pos < json.len) : (pos += 1) {
        if (json[pos] == ',' or json[pos] == '}' or json[pos] == ' ') break;
    }
    return json[start..pos];
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
