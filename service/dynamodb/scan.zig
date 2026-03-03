const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConditionalOperator = @import("conditional_operator.zig").ConditionalOperator;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const Condition = @import("condition.zig").Condition;
const Select = @import("select.zig").Select;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;

pub const ScanInput = struct {
    /// This is a legacy parameter. Use `ProjectionExpression` instead. For more
    /// information, see
    /// [AttributesToGet](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    attributes_to_get: ?[]const []const u8 = null,

    /// This is a legacy parameter. Use `FilterExpression` instead. For more
    /// information, see
    /// [ConditionalOperator](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ConditionalOperator.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    conditional_operator: ?ConditionalOperator = null,

    /// A Boolean value that determines the read consistency model during the scan:
    ///
    /// * If `ConsistentRead` is `false`, then the data returned
    /// from `Scan` might not contain the results from other recently
    /// completed write operations (`PutItem`, `UpdateItem`, or
    /// `DeleteItem`).
    ///
    /// * If `ConsistentRead` is `true`, then all of the write
    /// operations that completed before the `Scan` began are guaranteed to
    /// be contained in the `Scan` response.
    ///
    /// The default setting for `ConsistentRead` is `false`.
    ///
    /// The `ConsistentRead` parameter is not supported on global secondary
    /// indexes. If you scan a global secondary index with `ConsistentRead` set to
    /// true, you will receive a `ValidationException`.
    consistent_read: ?bool = null,

    /// The primary key of the first item that this operation will evaluate. Use the
    /// value
    /// that was returned for `LastEvaluatedKey` in the previous operation.
    ///
    /// The data type for `ExclusiveStartKey` must be String, Number or Binary. No
    /// set data types are allowed.
    ///
    /// In a parallel scan, a `Scan` request that includes
    /// `ExclusiveStartKey` must specify the same segment whose previous
    /// `Scan` returned the corresponding value of
    /// `LastEvaluatedKey`.
    exclusive_start_key: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// One or more substitution tokens for attribute names in an expression. The
    /// following
    /// are some use cases for using `ExpressionAttributeNames`:
    ///
    /// * To access an attribute whose name conflicts with a DynamoDB reserved
    /// word.
    ///
    /// * To create a placeholder for repeating occurrences of an attribute name in
    ///   an
    /// expression.
    ///
    /// * To prevent special characters in an attribute name from being
    ///   misinterpreted
    /// in an expression.
    ///
    /// Use the **#** character in an expression to dereference
    /// an attribute name. For example, consider the following attribute name:
    ///
    /// * `Percentile`
    ///
    /// The name of this attribute conflicts with a reserved word, so it cannot be
    /// used
    /// directly in an expression. (For the complete list of reserved words, see
    /// [Reserved
    /// Words](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html) in the *Amazon DynamoDB Developer
    /// Guide*). To work around this, you could specify the following for
    /// `ExpressionAttributeNames`:
    ///
    /// * `{"#P":"Percentile"}`
    ///
    /// You could then use this substitution in an expression, as in this example:
    ///
    /// * `#P = :val`
    ///
    /// Tokens that begin with the **:** character are
    /// *expression attribute values*, which are placeholders for the
    /// actual value at runtime.
    ///
    /// For more information on expression attribute names, see [Specifying Item
    /// Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    expression_attribute_names: ?[]const aws.map.StringMapEntry = null,

    /// One or more values that can be substituted in an expression.
    ///
    /// Use the **:** (colon) character in an expression to
    /// dereference an attribute value. For example, suppose that you wanted to
    /// check whether
    /// the value of the `ProductStatus` attribute was one of the following:
    ///
    /// `Available | Backordered | Discontinued`
    ///
    /// You would first need to specify `ExpressionAttributeValues` as
    /// follows:
    ///
    /// `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"},
    /// ":disc":{"S":"Discontinued"} }`
    ///
    /// You could then use these values in an expression, such as this:
    ///
    /// `ProductStatus IN (:avail, :back, :disc)`
    ///
    /// For more information on expression attribute values, see [Condition
    /// Expressions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    expression_attribute_values: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// A string that contains conditions that DynamoDB applies after the `Scan`
    /// operation, but before the data is returned to you. Items that do not satisfy
    /// the
    /// `FilterExpression` criteria are not returned.
    ///
    /// A `FilterExpression` is applied after the items have already been read;
    /// the process of filtering does not consume any additional read capacity
    /// units.
    ///
    /// For more information, see [Filter
    /// Expressions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Scan.html#Scan.FilterExpression) in the *Amazon DynamoDB Developer
    /// Guide*.
    filter_expression: ?[]const u8 = null,

    /// The name of a secondary index to scan. This index can be any local secondary
    /// index or
    /// global secondary index. Note that if you use the `IndexName` parameter, you
    /// must also provide `TableName`.
    index_name: ?[]const u8 = null,

    /// The maximum number of items to evaluate (not necessarily the number of
    /// matching
    /// items). If DynamoDB processes the number of items up to the limit while
    /// processing the
    /// results, it stops the operation and returns the matching values up to that
    /// point, and a
    /// key in `LastEvaluatedKey` to apply in a subsequent operation, so that you
    /// can
    /// pick up where you left off. Also, if the processed dataset size exceeds 1 MB
    /// before
    /// DynamoDB reaches this limit, it stops the operation and returns the matching
    /// values up
    /// to the limit, and a key in `LastEvaluatedKey` to apply in a subsequent
    /// operation to continue the operation. For more information, see [Working with
    /// Queries](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    limit: ?i32 = null,

    /// A string that identifies one or more attributes to retrieve from the
    /// specified table
    /// or index. These attributes can include scalars, sets, or elements of a JSON
    /// document.
    /// The attributes in the expression must be separated by commas.
    ///
    /// If no attribute names are specified, then all attributes will be returned.
    /// If any of
    /// the requested attributes are not found, they will not appear in the result.
    ///
    /// For more information, see [Specifying Item
    /// Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    projection_expression: ?[]const u8 = null,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// This is a legacy parameter. Use `FilterExpression` instead. For more
    /// information, see
    /// [ScanFilter](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ScanFilter.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    scan_filter: ?[]const aws.map.MapEntry(Condition) = null,

    /// For a parallel `Scan` request, `Segment` identifies an
    /// individual segment to be scanned by an application worker.
    ///
    /// Segment IDs are zero-based, so the first segment is always 0. For example,
    /// if you want
    /// to use four application threads to scan a table or an index, then the first
    /// thread
    /// specifies a `Segment` value of 0, the second thread specifies 1, and so
    /// on.
    ///
    /// The value of `LastEvaluatedKey` returned from a parallel `Scan`
    /// request must be used as `ExclusiveStartKey` with the same segment ID in a
    /// subsequent `Scan` operation.
    ///
    /// The value for `Segment` must be greater than or equal to 0, and less than
    /// the value provided for `TotalSegments`.
    ///
    /// If you provide `Segment`, you must also provide
    /// `TotalSegments`.
    segment: ?i32 = null,

    /// The attributes to be returned in the result. You can retrieve all item
    /// attributes,
    /// specific item attributes, the count of matching items, or in the case of an
    /// index, some
    /// or all of the attributes projected into the index.
    ///
    /// * `ALL_ATTRIBUTES` - Returns all of the item attributes from the
    /// specified table or index. If you query a local secondary index, then for
    /// each
    /// matching item in the index, DynamoDB fetches the entire item from the parent
    /// table. If the index is configured to project all item attributes, then all
    /// of
    /// the data can be obtained from the local secondary index, and no fetching is
    /// required.
    ///
    /// * `ALL_PROJECTED_ATTRIBUTES` - Allowed only when querying an index.
    /// Retrieves all attributes that have been projected into the index. If the
    /// index
    /// is configured to project all attributes, this return value is equivalent to
    /// specifying `ALL_ATTRIBUTES`.
    ///
    /// * `COUNT` - Returns the number of matching items, rather than the
    /// matching items themselves. Note that this uses the same quantity of read
    /// capacity units as getting the items, and is subject to the same item size
    /// calculations.
    ///
    /// * `SPECIFIC_ATTRIBUTES` - Returns only the attributes listed in
    /// `ProjectionExpression`. This return value is equivalent to
    /// specifying `ProjectionExpression` without specifying any value for
    /// `Select`.
    ///
    /// If you query or scan a local secondary index and request only attributes
    /// that
    /// are projected into that index, the operation reads only the index and not
    /// the
    /// table. If any of the requested attributes are not projected into the local
    /// secondary index, DynamoDB fetches each of these attributes from the parent
    /// table. This extra fetching incurs additional throughput cost and latency.
    ///
    /// If you query or scan a global secondary index, you can only request
    /// attributes
    /// that are projected into the index. Global secondary index queries cannot
    /// fetch
    /// attributes from the parent table.
    ///
    /// If neither `Select` nor `ProjectionExpression` are specified,
    /// DynamoDB defaults to `ALL_ATTRIBUTES` when accessing a table, and
    /// `ALL_PROJECTED_ATTRIBUTES` when accessing an index. You cannot use both
    /// `Select` and `ProjectionExpression` together in a single
    /// request, unless the value for `Select` is `SPECIFIC_ATTRIBUTES`.
    /// (This usage is equivalent to specifying `ProjectionExpression` without any
    /// value for `Select`.)
    ///
    /// If you use the `ProjectionExpression` parameter, then the value for
    /// `Select` can only be `SPECIFIC_ATTRIBUTES`. Any other
    /// value for `Select` will return an error.
    select: ?Select = null,

    /// The name of the table containing the requested items or if you provide
    /// `IndexName`, the name of the table to which that index belongs.
    ///
    /// You can also provide the Amazon Resource Name (ARN) of the table in this
    /// parameter.
    table_name: []const u8,

    /// For a parallel `Scan` request, `TotalSegments` represents the
    /// total number of segments into which the `Scan` operation will be divided.
    /// The
    /// value of `TotalSegments` corresponds to the number of application workers
    /// that will perform the parallel scan. For example, if you want to use four
    /// application
    /// threads to scan a table or an index, specify a `TotalSegments` value of
    /// 4.
    ///
    /// The value for `TotalSegments` must be greater than or equal to 1, and less
    /// than or equal to 1000000. If you specify a `TotalSegments` value of 1, the
    /// `Scan` operation will be sequential rather than parallel.
    ///
    /// If you specify `TotalSegments`, you must also specify
    /// `Segment`.
    total_segments: ?i32 = null,

    pub const json_field_names = .{
        .attributes_to_get = "AttributesToGet",
        .conditional_operator = "ConditionalOperator",
        .consistent_read = "ConsistentRead",
        .exclusive_start_key = "ExclusiveStartKey",
        .expression_attribute_names = "ExpressionAttributeNames",
        .expression_attribute_values = "ExpressionAttributeValues",
        .filter_expression = "FilterExpression",
        .index_name = "IndexName",
        .limit = "Limit",
        .projection_expression = "ProjectionExpression",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .scan_filter = "ScanFilter",
        .segment = "Segment",
        .select = "Select",
        .table_name = "TableName",
        .total_segments = "TotalSegments",
    };
};

pub const ScanOutput = struct {
    /// The capacity units consumed by the `Scan` operation. The data returned
    /// includes the total provisioned throughput consumed, along with statistics
    /// for the table
    /// and any indexes involved in the operation. `ConsumedCapacity` is only
    /// returned if the `ReturnConsumedCapacity` parameter was specified. For more
    /// information, see [Capacity unit consumption for read
    /// operations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/read-write-operations.html#read-operation-consumption) in the *Amazon
    /// DynamoDB Developer Guide*.
    consumed_capacity: ?ConsumedCapacity = null,

    /// The number of items in the response.
    ///
    /// If you set `ScanFilter` in the request, then `Count` is the
    /// number of items returned after the filter was applied, and `ScannedCount` is
    /// the number of matching items before the filter was applied.
    ///
    /// If you did not use a filter in the request, then `Count` is the same as
    /// `ScannedCount`.
    count: ?i32 = null,

    /// An array of item attributes that match the scan criteria. Each element in
    /// this array
    /// consists of an attribute name and the value for that attribute.
    items: ?[]const []const aws.map.MapEntry(AttributeValue) = null,

    /// The primary key of the item where the operation stopped, inclusive of the
    /// previous
    /// result set. Use this value to start a new operation, excluding this value in
    /// the new
    /// request.
    ///
    /// If `LastEvaluatedKey` is empty, then the "last page" of results has been
    /// processed and there is no more data to be retrieved.
    ///
    /// If `LastEvaluatedKey` is not empty, it does not necessarily mean that there
    /// is more data in the result set. The only way to know when you have reached
    /// the end of
    /// the result set is when `LastEvaluatedKey` is empty.
    last_evaluated_key: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The number of items evaluated, before any `ScanFilter` is applied. A high
    /// `ScannedCount` value with few, or no, `Count` results
    /// indicates an inefficient `Scan` operation. For more information, see [Count
    /// and
    /// ScannedCount](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html#Count) in the *Amazon DynamoDB Developer
    /// Guide*.
    ///
    /// If you did not use a filter in the request, then `ScannedCount` is the same
    /// as `Count`.
    scanned_count: ?i32 = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .count = "Count",
        .items = "Items",
        .last_evaluated_key = "LastEvaluatedKey",
        .scanned_count = "ScannedCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ScanInput, options: CallOptions) !ScanOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ScanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.Scan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ScanOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ScanOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BackupInUseException")) {
        return .{ .arena = arena, .kind = .{ .backup_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackupNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .backup_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConditionalCheckFailedException")) {
        return .{ .arena = arena, .kind = .{ .conditional_check_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ContinuousBackupsUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .continuous_backups_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateItemException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExportConflictException")) {
        return .{ .arena = arena, .kind = .{ .export_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExportNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .export_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .global_table_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalTableNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .global_table_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImportConflictException")) {
        return .{ .arena = arena, .kind = .{ .import_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImportNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .import_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IndexNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .index_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        return .{ .arena = arena, .kind = .{ .invalid_endpoint_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportTimeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_time_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreTimeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_restore_time_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ItemCollectionSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .item_collection_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PointInTimeRecoveryUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .point_in_time_recovery_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_throughput_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .replica_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicaNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .replica_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicatedWriteConflictException")) {
        return .{ .arena = arena, .kind = .{ .replicated_write_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .request_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .table_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableInUseException")) {
        return .{ .arena = arena, .kind = .{ .table_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .table_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionCanceledException")) {
        return .{ .arena = arena, .kind = .{ .transaction_canceled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionConflictException")) {
        return .{ .arena = arena, .kind = .{ .transaction_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionInProgressException")) {
        return .{ .arena = arena, .kind = .{ .transaction_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
