const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
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
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, "");
    errdefer alloc.free(owned_request_id);

    if (std.mem.eql(u8, error_code, "BackupInUseException")) {
        return .{ .backup_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "BackupNotFoundException")) {
        return .{ .backup_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ConditionalCheckFailedException")) {
        return .{ .conditional_check_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ContinuousBackupsUnavailableException")) {
        return .{ .continuous_backups_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateItemException")) {
        return .{ .duplicate_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ExportConflictException")) {
        return .{ .export_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ExportNotFoundException")) {
        return .{ .export_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableAlreadyExistsException")) {
        return .{ .global_table_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableNotFoundException")) {
        return .{ .global_table_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ImportConflictException")) {
        return .{ .import_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ImportNotFoundException")) {
        return .{ .import_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "IndexNotFoundException")) {
        return .{ .index_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        return .{ .invalid_endpoint_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportTimeException")) {
        return .{ .invalid_export_time_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreTimeException")) {
        return .{ .invalid_restore_time_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ItemCollectionSizeLimitExceededException")) {
        return .{ .item_collection_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "PointInTimeRecoveryUnavailableException")) {
        return .{ .point_in_time_recovery_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        return .{ .policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        return .{ .provisioned_throughput_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaAlreadyExistsException")) {
        return .{ .replica_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaNotFoundException")) {
        return .{ .replica_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ReplicatedWriteConflictException")) {
        return .{ .replicated_write_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        return .{ .request_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TableAlreadyExistsException")) {
        return .{ .table_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TableInUseException")) {
        return .{ .table_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TableNotFoundException")) {
        return .{ .table_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionCanceledException")) {
        return .{ .transaction_canceled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionConflictException")) {
        return .{ .transaction_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TransactionInProgressException")) {
        return .{ .transaction_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }

    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
