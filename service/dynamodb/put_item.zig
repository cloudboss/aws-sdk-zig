const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConditionalOperator = @import("conditional_operator.zig").ConditionalOperator;
const ExpectedAttributeValue = @import("expected_attribute_value.zig").ExpectedAttributeValue;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ReturnItemCollectionMetrics = @import("return_item_collection_metrics.zig").ReturnItemCollectionMetrics;
const ReturnValue = @import("return_value.zig").ReturnValue;
const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;
const ItemCollectionMetrics = @import("item_collection_metrics.zig").ItemCollectionMetrics;

/// Creates a new item, or replaces an old item with a new item. If an item that
/// has the
/// same primary key as the new item already exists in the specified table, the
/// new item
/// completely replaces the existing item. You can perform a conditional put
/// operation (add
/// a new item if one with the specified primary key doesn't exist), or replace
/// an existing
/// item if it has certain attribute values. You can return the item's attribute
/// values in
/// the same operation, using the `ReturnValues` parameter.
///
/// When you add an item, the primary key attributes are the only required
/// attributes.
///
/// Empty String and Binary attribute values are allowed. Attribute values of
/// type String
/// and Binary must have a length greater than zero if the attribute is used as
/// a key
/// attribute for a table or index. Set type attributes cannot be empty.
///
/// Invalid Requests with empty values will be rejected with a
/// `ValidationException` exception.
///
/// **Note:**
///
/// To prevent a new item from replacing an existing item, use a conditional
/// expression that contains the `attribute_not_exists` function with the
/// name of the attribute being used as the partition key for the table. Since
/// every
/// record must contain that attribute, the `attribute_not_exists` function
/// will only succeed if no matching item exists.
///
/// For more information about `PutItem`, see [Working with
/// Items](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithItems.html) in the *Amazon DynamoDB Developer Guide*.
pub const PutItemInput = struct {
    /// This is a legacy parameter. Use `ConditionExpression` instead. For more
    /// information, see
    /// [ConditionalOperator](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ConditionalOperator.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    conditional_operator: ?ConditionalOperator = null,

    /// A condition that must be satisfied in order for a conditional `PutItem`
    /// operation to succeed.
    ///
    /// An expression can contain any of the following:
    ///
    /// * Functions: `attribute_exists | attribute_not_exists | attribute_type |
    /// contains | begins_with | size`
    ///
    /// These function names are case-sensitive.
    ///
    /// * Comparison operators: `= | <> |
    /// | = |
    /// BETWEEN | IN `
    ///
    /// * Logical operators: `AND | OR | NOT`
    ///
    /// For more information on condition expressions, see [Condition
    /// Expressions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    condition_expression: ?[]const u8 = null,

    /// This is a legacy parameter. Use `ConditionExpression` instead. For more
    /// information, see
    /// [Expected](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.Expected.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    expected: ?[]const aws.map.MapEntry(ExpectedAttributeValue) = null,

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
    /// **Note:**
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
    /// the value of the *ProductStatus* attribute was one of the following:
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

    /// A map of attribute name/value pairs, one for each attribute. Only the
    /// primary key
    /// attributes are required; you can optionally provide other attribute
    /// name-value pairs for
    /// the item.
    ///
    /// You must provide all of the attributes for the primary key. For example,
    /// with a simple
    /// primary key, you only need to provide a value for the partition key. For a
    /// composite
    /// primary key, you must provide both values for both the partition key and the
    /// sort
    /// key.
    ///
    /// If you specify any attributes that are part of an index key, then the data
    /// types for
    /// those attributes must match those of the schema in the table's attribute
    /// definition.
    ///
    /// Empty String and Binary attribute values are allowed. Attribute values of
    /// type String
    /// and Binary must have a length greater than zero if the attribute is used as
    /// a key
    /// attribute for a table or index.
    ///
    /// For more information about primary keys, see [Primary
    /// Key](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.PrimaryKey) in the *Amazon DynamoDB Developer
    /// Guide*.
    ///
    /// Each element in the `Item` map is an `AttributeValue`
    /// object.
    item: []const aws.map.MapEntry(AttributeValue),

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// Determines whether item collection metrics are returned. If set to `SIZE`,
    /// the response includes statistics about item collections, if any, that were
    /// modified
    /// during the operation are returned in the response. If set to `NONE` (the
    /// default), no statistics are returned.
    return_item_collection_metrics: ?ReturnItemCollectionMetrics = null,

    /// Use `ReturnValues` if you want to get the item attributes as they appeared
    /// before they were updated with the `PutItem` request. For
    /// `PutItem`, the valid values are:
    ///
    /// * `NONE` - If `ReturnValues` is not specified, or if its
    /// value is `NONE`, then nothing is returned. (This setting is the
    /// default for `ReturnValues`.)
    ///
    /// * `ALL_OLD` - If `PutItem` overwrote an attribute name-value
    /// pair, then the content of the old item is returned.
    ///
    /// The values returned are strongly consistent.
    ///
    /// There is no additional cost associated with requesting a return value aside
    /// from the
    /// small network and processing overhead of receiving a larger response. No
    /// read capacity
    /// units are consumed.
    ///
    /// **Note:**
    ///
    /// The `ReturnValues` parameter is used by several DynamoDB operations;
    /// however, `PutItem` does not recognize any values other than
    /// `NONE` or `ALL_OLD`.
    return_values: ?ReturnValue = null,

    /// An optional parameter that returns the item attributes for a `PutItem`
    /// operation that failed a condition check.
    ///
    /// There is no additional cost associated with requesting a return value aside
    /// from the
    /// small network and processing overhead of receiving a larger response. No
    /// read capacity
    /// units are consumed.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure = null,

    /// The name of the table to contain the item. You can also provide the Amazon
    /// Resource Name (ARN) of the
    /// table in this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .conditional_operator = "ConditionalOperator",
        .condition_expression = "ConditionExpression",
        .expected = "Expected",
        .expression_attribute_names = "ExpressionAttributeNames",
        .expression_attribute_values = "ExpressionAttributeValues",
        .item = "Item",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .return_item_collection_metrics = "ReturnItemCollectionMetrics",
        .return_values = "ReturnValues",
        .return_values_on_condition_check_failure = "ReturnValuesOnConditionCheckFailure",
        .table_name = "TableName",
    };
};

pub const PutItemOutput = struct {
    /// The attribute values as they appeared before the `PutItem` operation, but
    /// only if `ReturnValues` is specified as `ALL_OLD` in the request.
    /// Each element consists of an attribute name and an attribute value.
    attributes: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The capacity units consumed by the `PutItem` operation. The data returned
    /// includes the total provisioned throughput consumed, along with statistics
    /// for the table
    /// and any indexes involved in the operation. `ConsumedCapacity` is only
    /// returned if the `ReturnConsumedCapacity` parameter was specified. For more
    /// information, see [Capacity unity consumption for write
    /// operations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/read-write-operations.html#write-operation-consumption) in the *Amazon
    /// DynamoDB Developer Guide*.
    consumed_capacity: ?ConsumedCapacity = null,

    /// Information about item collections, if any, that were affected by the
    /// `PutItem` operation. `ItemCollectionMetrics` is only returned
    /// if the `ReturnItemCollectionMetrics` parameter was specified. If the table
    /// does not have any local secondary indexes, this information is not returned
    /// in the
    /// response.
    ///
    /// Each `ItemCollectionMetrics` element consists of:
    ///
    /// * `ItemCollectionKey` - The partition key value of the item collection.
    /// This is the same as the partition key value of the item itself.
    ///
    /// * `SizeEstimateRangeGB` - An estimate of item collection size, in
    /// gigabytes. This value is a two-element array containing a lower bound and an
    /// upper bound for the estimate. The estimate includes the size of all the
    /// items in
    /// the table, plus the size of all attributes projected into all of the local
    /// secondary indexes on that table. Use this estimate to measure whether a
    /// local
    /// secondary index is approaching its size limit.
    ///
    /// The estimate is subject to change over time; therefore, do not rely on the
    /// precision or accuracy of the estimate.
    item_collection_metrics: ?ItemCollectionMetrics = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *PutItemOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .attributes = "Attributes",
        .consumed_capacity = "ConsumedCapacity",
        .item_collection_metrics = "ItemCollectionMetrics",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PutItemInput, options: Options) !PutItemOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PutItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("dynamodb", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.PutItem");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutItemOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

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
