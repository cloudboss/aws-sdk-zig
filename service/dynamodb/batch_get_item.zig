const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;

/// The `BatchGetItem` operation returns the attributes of one or more items
/// from one or more tables. You identify requested items by primary key.
///
/// A single operation can retrieve up to 16 MB of data, which can contain as
/// many as 100
/// items. `BatchGetItem` returns a partial result if the response size limit is
/// exceeded, the table's provisioned throughput is exceeded, more than 1MB per
/// partition is
/// requested, or an internal processing failure occurs. If a partial result is
/// returned,
/// the operation returns a value for `UnprocessedKeys`. You can use this value
/// to retry the operation starting with the next item to get.
///
/// **Important:**
///
/// If you request more than 100 items, `BatchGetItem` returns a
/// `ValidationException` with the message "Too many items requested for
/// the BatchGetItem call."
///
/// For example, if you ask to retrieve 100 items, but each individual item is
/// 300 KB in
/// size, the system returns 52 items (so as not to exceed the 16 MB limit). It
/// also returns
/// an appropriate `UnprocessedKeys` value so you can get the next page of
/// results. If desired, your application can include its own logic to assemble
/// the pages of
/// results into one dataset.
///
/// If *none* of the items can be processed due to insufficient
/// provisioned throughput on all of the tables in the request, then
/// `BatchGetItem` returns a
/// `ProvisionedThroughputExceededException`. If *at least
/// one* of the items is successfully processed, then
/// `BatchGetItem` completes successfully, while returning the keys of the
/// unread items in `UnprocessedKeys`.
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
/// Handling](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ErrorHandling.html#BatchOperations) in the *Amazon DynamoDB
/// Developer Guide*.
///
/// By default, `BatchGetItem` performs eventually consistent reads on every
/// table in the request. If you want strongly consistent reads instead, you can
/// set
/// `ConsistentRead` to `true` for any or all tables.
///
/// In order to minimize response latency, `BatchGetItem` may retrieve items in
/// parallel.
///
/// When designing your application, keep in mind that DynamoDB does not return
/// items in
/// any particular order. To help parse the response by item, include the
/// primary key values
/// for the items in your request in the `ProjectionExpression` parameter.
///
/// If a requested item does not exist, it is not returned in the result.
/// Requests for
/// nonexistent items consume the minimum read capacity units according to the
/// type of read.
/// For more information, see [Working with
/// Tables](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#CapacityUnitCalculations) in the *Amazon DynamoDB Developer
/// Guide*.
///
/// **Note:**
///
/// `BatchGetItem` will result in a `ValidationException` if the
/// same key is specified multiple times.
pub const BatchGetItemInput = struct {
    /// A map of one or more table names or table ARNs and, for each table, a map
    /// that
    /// describes one or more items to retrieve from that table. Each table name or
    /// ARN can be
    /// used only once per `BatchGetItem` request.
    ///
    /// Each element in the map of items to retrieve consists of the following:
    ///
    /// * `ConsistentRead` - If `true`, a strongly consistent read
    /// is used; if `false` (the default), an eventually consistent read is
    /// used.
    ///
    /// * `ExpressionAttributeNames` - One or more substitution tokens for
    /// attribute names in the `ProjectionExpression` parameter. The
    /// following are some use cases for using
    /// `ExpressionAttributeNames`:
    ///
    /// * To access an attribute whose name conflicts with a DynamoDB reserved
    /// word.
    ///
    /// * To create a placeholder for repeating occurrences of an attribute name
    /// in an expression.
    ///
    /// * To prevent special characters in an attribute name from being
    /// misinterpreted in an expression.
    ///
    /// Use the **#** character in an expression to
    /// dereference an attribute name. For example, consider the following attribute
    /// name:
    ///
    /// * `Percentile`
    ///
    /// The name of this attribute conflicts with a reserved word, so it cannot be
    /// used directly in an expression. (For the complete list of reserved words,
    /// see
    /// [Reserved
    /// Words](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html) in the *Amazon DynamoDB Developer Guide*).
    /// To work around this, you could specify the following for
    /// `ExpressionAttributeNames`:
    ///
    /// * `{"#P":"Percentile"}`
    ///
    /// You could then use this substitution in an expression, as in this
    /// example:
    ///
    /// * `#P = :val`
    ///
    /// **Note:**
    ///
    /// Tokens that begin with the **:** character
    /// are *expression attribute values*, which are placeholders
    /// for the actual value at runtime.
    ///
    /// For more information about expression attribute names, see [Accessing Item
    /// Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html) in the *Amazon DynamoDB
    /// Developer Guide*.
    ///
    /// * `Keys` - An array of primary key attribute values that define
    /// specific items in the table. For each primary key, you must provide
    /// *all* of the key attributes. For example, with a simple
    /// primary key, you only need to provide the partition key value. For a
    /// composite
    /// key, you must provide *both* the partition key value and the
    /// sort key value.
    ///
    /// * `ProjectionExpression` - A string that identifies one or more
    /// attributes to retrieve from the table. These attributes can include scalars,
    /// sets, or elements of a JSON document. The attributes in the expression must
    /// be
    /// separated by commas.
    ///
    /// If no attribute names are specified, then all attributes are returned. If
    /// any
    /// of the requested attributes are not found, they do not appear in the
    /// result.
    ///
    /// For more information, see [Accessing Item
    /// Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html) in the *Amazon DynamoDB
    /// Developer Guide*.
    ///
    /// * `AttributesToGet` - This is a legacy parameter. Use
    /// `ProjectionExpression` instead. For more information, see
    /// [AttributesToGet](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    request_items: []const u8,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    pub const json_field_names = .{
        .request_items = "RequestItems",
        .return_consumed_capacity = "ReturnConsumedCapacity",
    };
};

pub const BatchGetItemOutput = struct {
    /// The read capacity units consumed by the entire `BatchGetItem`
    /// operation.
    ///
    /// Each element consists of:
    ///
    /// * `TableName` - The table that consumed the provisioned
    /// throughput.
    ///
    /// * `CapacityUnits` - The total number of capacity units consumed.
    consumed_capacity: ?[]const ConsumedCapacity = null,

    /// A map of table name or table ARN to a list of items. Each object in
    /// `Responses` consists of a table name or ARN, along with a map of
    /// attribute data consisting of the data type and attribute value.
    responses: ?[]const u8 = null,

    /// A map of tables and their respective keys that were not processed with the
    /// current
    /// response. The `UnprocessedKeys` value is in the same form as
    /// `RequestItems`, so the value can be provided directly to a subsequent
    /// `BatchGetItem` operation. For more information, see
    /// `RequestItems` in the Request Parameters section.
    ///
    /// Each element consists of:
    ///
    /// * `Keys` - An array of primary key attribute values that define
    /// specific items in the table.
    ///
    /// * `ProjectionExpression` - One or more attributes to be retrieved from
    /// the table or index. By default, all attributes are returned. If a requested
    /// attribute is not found, it does not appear in the result.
    ///
    /// * `ConsistentRead` - The consistency of a read operation. If set to
    /// `true`, then a strongly consistent read is used; otherwise, an
    /// eventually consistent read is used.
    ///
    /// If there are no unprocessed keys remaining, the response contains an empty
    /// `UnprocessedKeys` map.
    unprocessed_keys: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const BatchGetItemOutput) void {
        if (self.responses) |v| {
            self.allocator.free(v);
        }
        if (self.unprocessed_keys) |v| {
            self.allocator.free(v);
        }
    }

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .responses = "Responses",
        .unprocessed_keys = "UnprocessedKeys",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: BatchGetItemInput, options: Options) !BatchGetItemOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: BatchGetItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("dynamodb", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RequestItems\":\"");
    try appendJsonEscaped(alloc, &body_buf, input.request_items);
    try body_buf.appendSlice(alloc, "\"");
    has_prev = true;
    if (input.return_consumed_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ReturnConsumedCapacity\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.BatchGetItem");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !BatchGetItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{ .allocator = alloc };
    return aws.json.parseJsonObject(BatchGetItemOutput, body, alloc);
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

fn appendJsonEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            0x22 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x22); },
            0x5C => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x5C); },
            0x0A => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'n'); },
            0x0D => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'r'); },
            0x09 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 't'); },
            else => {
                if (c < 0x20) {
                    const hex = "0123456789abcdef";
                    try buf.append(alloc, 0x5C); // backslash
                    try buf.append(alloc, 'u');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, hex[c >> 4]);
                    try buf.append(alloc, hex[c & 0x0F]);
                } else {
                    try buf.append(alloc, c);
                }
            }
        }
    }
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
