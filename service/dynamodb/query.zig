const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConditionalOperator = @import("conditional_operator.zig").ConditionalOperator;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const Condition = @import("condition.zig").Condition;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const Select = @import("select.zig").Select;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;

pub const QueryInput = struct {
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

    /// Determines the read consistency model: If set to `true`, then the operation
    /// uses strongly consistent reads; otherwise, the operation uses eventually
    /// consistent
    /// reads.
    ///
    /// Strongly consistent reads are not supported on global secondary indexes. If
    /// you query
    /// a global secondary index with `ConsistentRead` set to `true`, you
    /// will receive a `ValidationException`.
    consistent_read: ?bool = null,

    /// The primary key of the first item that this operation will evaluate. Use the
    /// value
    /// that was returned for `LastEvaluatedKey` in the previous operation.
    ///
    /// The data type for `ExclusiveStartKey` must be String, Number, or Binary. No
    /// set data types are allowed.
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
    /// For more information on expression attribute values, see [Specifying
    /// Conditions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    expression_attribute_values: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// A string that contains conditions that DynamoDB applies after the `Query`
    /// operation, but before the data is returned to you. Items that do not satisfy
    /// the
    /// `FilterExpression` criteria are not returned.
    ///
    /// A `FilterExpression` does not allow key attributes. You cannot define a
    /// filter expression based on a partition key or a sort key.
    ///
    /// A `FilterExpression` is applied after the items have already been read;
    /// the process of filtering does not consume any additional read capacity
    /// units.
    ///
    /// For more information, see [Filter
    /// Expressions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.FilterExpression.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    filter_expression: ?[]const u8 = null,

    /// The name of an index to query. This index can be any local secondary index
    /// or global
    /// secondary index on the table. Note that if you use the `IndexName`
    /// parameter,
    /// you must also provide `TableName.`
    index_name: ?[]const u8 = null,

    /// The condition that specifies the key values for items to be retrieved by the
    /// `Query` action.
    ///
    /// The condition must perform an equality test on a single partition key value.
    ///
    /// The condition can optionally perform one of several comparison tests on a
    /// single sort
    /// key value. This allows `Query` to retrieve one item with a given partition
    /// key value and sort key value, or several items that have the same partition
    /// key value
    /// but different sort key values.
    ///
    /// The partition key equality test is required, and must be specified in the
    /// following
    /// format:
    ///
    /// `partitionKeyName`
    /// *=*
    /// `:partitionkeyval`
    ///
    /// If you also want to provide a condition for the sort key, it must be
    /// combined using
    /// `AND` with the condition for the sort key. Following is an example, using
    /// the **=** comparison operator for the sort key:
    ///
    /// `partitionKeyName`
    /// `=`
    /// `:partitionkeyval`
    /// `AND`
    /// `sortKeyName`
    /// `=`
    /// `:sortkeyval`
    ///
    /// Valid comparisons for the sort key condition are as follows:
    ///
    /// * `sortKeyName`
    /// `=`
    /// `:sortkeyval` - true if the sort key value is equal to
    /// `:sortkeyval`.
    ///
    /// * `sortKeyName`
    /// ``
    /// `:sortkeyval` - true if the sort key value is greater than
    /// `:sortkeyval`.
    ///
    /// * `sortKeyName`
    /// `>= `
    /// `:sortkeyval` - true if the sort key value is greater than or equal
    /// to `:sortkeyval`.
    ///
    /// * `sortKeyName`
    /// `BETWEEN`
    /// `:sortkeyval1`
    /// `AND`
    /// `:sortkeyval2` - true if the sort key value is greater than or equal
    /// to `:sortkeyval1`, and less than or equal to
    /// `:sortkeyval2`.
    ///
    /// * `begins_with (`
    /// `sortKeyName`, `:sortkeyval`
    /// `)` - true if the sort key value begins with a particular operand.
    /// (You cannot use this function with a sort key that is of type Number.) Note
    /// that
    /// the function name `begins_with` is case-sensitive.
    ///
    /// Use the `ExpressionAttributeValues` parameter to replace tokens such as
    /// `:partitionval` and `:sortval` with actual values at
    /// runtime.
    ///
    /// You can optionally use the `ExpressionAttributeNames` parameter to replace
    /// the names of the partition key and sort key with placeholder tokens. This
    /// option might
    /// be necessary if an attribute name conflicts with a DynamoDB reserved word.
    /// For example,
    /// the following `KeyConditionExpression` parameter causes an error because
    /// *Size* is a reserved word:
    ///
    /// * `Size = :myval`
    ///
    /// To work around this, define a placeholder (such a `#S`) to represent the
    /// attribute name *Size*. `KeyConditionExpression` then is as
    /// follows:
    ///
    /// * `#S = :myval`
    ///
    /// For a list of reserved words, see [Reserved
    /// Words](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html)
    /// in the *Amazon DynamoDB Developer Guide*.
    ///
    /// For more information on `ExpressionAttributeNames` and
    /// `ExpressionAttributeValues`, see [Using
    /// Placeholders for Attribute Names and
    /// Values](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ExpressionPlaceholders.html) in the *Amazon DynamoDB
    /// Developer Guide*.
    key_condition_expression: ?[]const u8 = null,

    /// This is a legacy parameter. Use `KeyConditionExpression` instead. For more
    /// information, see
    /// [KeyConditions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.KeyConditions.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    key_conditions: ?[]const aws.map.MapEntry(Condition) = null,

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
    /// operation to continue the operation. For more information, see [Query and
    /// Scan](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    limit: ?i32 = null,

    /// A string that identifies one or more attributes to retrieve from the table.
    /// These
    /// attributes can include scalars, sets, or elements of a JSON document. The
    /// attributes in
    /// the expression must be separated by commas.
    ///
    /// If no attribute names are specified, then all attributes will be returned.
    /// If any of
    /// the requested attributes are not found, they will not appear in the result.
    ///
    /// For more information, see [Accessing Item
    /// Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    projection_expression: ?[]const u8 = null,

    /// This is a legacy parameter. Use `FilterExpression` instead. For more
    /// information, see
    /// [QueryFilter](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.QueryFilter.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    query_filter: ?[]const aws.map.MapEntry(Condition) = null,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// Specifies the order for index traversal: If `true` (default), the traversal
    /// is performed in ascending order; if `false`, the traversal is performed in
    /// descending order.
    ///
    /// Items with the same partition key value are stored in sorted order by sort
    /// key. If the
    /// sort key data type is Number, the results are stored in numeric order. For
    /// type String,
    /// the results are stored in order of UTF-8 bytes. For type Binary, DynamoDB
    /// treats each
    /// byte of the binary data as unsigned.
    ///
    /// If `ScanIndexForward` is `true`, DynamoDB returns the results in
    /// the order in which they are stored (by sort key value). This is the default
    /// behavior. If
    /// `ScanIndexForward` is `false`, DynamoDB reads the results in
    /// reverse order by sort key value, and then returns the results to the client.
    scan_index_forward: ?bool = null,

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
    /// are projected into that index, the operation will read only the index and
    /// not
    /// the table. If any of the requested attributes are not projected into the
    /// local
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

    /// The name of the table containing the requested items. You can also provide
    /// the
    /// Amazon Resource Name (ARN) of the table in this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .attributes_to_get = "AttributesToGet",
        .conditional_operator = "ConditionalOperator",
        .consistent_read = "ConsistentRead",
        .exclusive_start_key = "ExclusiveStartKey",
        .expression_attribute_names = "ExpressionAttributeNames",
        .expression_attribute_values = "ExpressionAttributeValues",
        .filter_expression = "FilterExpression",
        .index_name = "IndexName",
        .key_condition_expression = "KeyConditionExpression",
        .key_conditions = "KeyConditions",
        .limit = "Limit",
        .projection_expression = "ProjectionExpression",
        .query_filter = "QueryFilter",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .scan_index_forward = "ScanIndexForward",
        .select = "Select",
        .table_name = "TableName",
    };
};

pub const QueryOutput = struct {
    /// The capacity units consumed by the `Query` operation. The data returned
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
    /// If you used a `QueryFilter` in the request, then `Count` is the
    /// number of items returned after the filter was applied, and `ScannedCount` is
    /// the number of matching items before the filter was applied.
    ///
    /// If you did not use a filter in the request, then `Count` and
    /// `ScannedCount` are the same.
    count: ?i32 = null,

    /// An array of item attributes that match the query criteria. Each element in
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

    /// The number of items evaluated, before any `QueryFilter` is applied. A high
    /// `ScannedCount` value with few, or no, `Count` results
    /// indicates an inefficient `Query` operation. For more information, see [Count
    /// and
    /// ScannedCount](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Scan.html#Scan.Count) in the *Amazon DynamoDB Developer
    /// Guide*.
    ///
    /// If you did not use a filter in the request, then `ScannedCount` is the same
    /// as `Count`.
    scanned_count: ?i32 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *QueryOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .count = "Count",
        .items = "Items",
        .last_evaluated_key = "LastEvaluatedKey",
        .scanned_count = "ScannedCount",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: QueryInput, options: Options) !QueryOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: QueryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.Query");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !QueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(QueryOutput, body, alloc);
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
