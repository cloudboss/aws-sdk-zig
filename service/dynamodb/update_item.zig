const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConditionalOperator = @import("conditional_operator.zig").ConditionalOperator;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ReturnItemCollectionMetrics = @import("return_item_collection_metrics.zig").ReturnItemCollectionMetrics;
const ReturnValue = @import("return_value.zig").ReturnValue;
const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;
const ItemCollectionMetrics = @import("item_collection_metrics.zig").ItemCollectionMetrics;

/// Edits an existing item's attributes, or adds a new item to the table if it
/// does not
/// already exist. You can put, delete, or add attribute values. You can also
/// perform a
/// conditional update on an existing item (insert a new attribute name-value
/// pair if it
/// doesn't exist, or replace an existing name-value pair if it has certain
/// expected
/// attribute values).
///
/// You can also return the item's attribute values in the same `UpdateItem`
/// operation using the `ReturnValues` parameter.
pub const UpdateItemInput = struct {
    /// This is a legacy parameter. Use `UpdateExpression` instead. For more
    /// information, see
    /// [AttributeUpdates](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributeUpdates.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    attribute_updates: ?[]const u8 = null,

    /// This is a legacy parameter. Use `ConditionExpression` instead. For more
    /// information, see
    /// [ConditionalOperator](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.ConditionalOperator.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    conditional_operator: ?ConditionalOperator = null,

    /// A condition that must be satisfied in order for a conditional update to
    /// succeed.
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
    /// For more information about condition expressions, see [Specifying
    /// Conditions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    condition_expression: ?[]const u8 = null,

    /// This is a legacy parameter. Use `ConditionExpression` instead. For more
    /// information, see
    /// [Expected](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.Expected.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    expected: ?[]const u8 = null,

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
    /// Guide*.) To work around this, you could specify the following for
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
    /// For more information about expression attribute names, see [Specifying Item
    /// Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    expression_attribute_names: ?[]const u8 = null,

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
    expression_attribute_values: ?[]const u8 = null,

    /// The primary key of the item to be updated. Each element consists of an
    /// attribute name
    /// and a value for that attribute.
    ///
    /// For the primary key, you must provide all of the attributes. For example,
    /// with a
    /// simple primary key, you only need to provide a value for the partition key.
    /// For a
    /// composite primary key, you must provide values for both the partition key
    /// and the sort
    /// key.
    key: []const u8,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// Determines whether item collection metrics are returned. If set to `SIZE`,
    /// the response includes statistics about item collections, if any, that were
    /// modified
    /// during the operation are returned in the response. If set to `NONE` (the
    /// default), no statistics are returned.
    return_item_collection_metrics: ?ReturnItemCollectionMetrics = null,

    /// Use `ReturnValues` if you want to get the item attributes as they appear
    /// before or after they are successfully updated. For `UpdateItem`, the valid
    /// values are:
    ///
    /// * `NONE` - If `ReturnValues` is not specified, or if its
    /// value is `NONE`, then nothing is returned. (This setting is the
    /// default for `ReturnValues`.)
    ///
    /// * `ALL_OLD` - Returns all of the attributes of the item, as they
    /// appeared before the UpdateItem operation.
    ///
    /// * `UPDATED_OLD` - Returns only the updated attributes, as they appeared
    /// before the UpdateItem operation.
    ///
    /// * `ALL_NEW` - Returns all of the attributes of the item, as they appear
    /// after the UpdateItem operation.
    ///
    /// * `UPDATED_NEW` - Returns only the updated attributes, as they appear
    /// after the UpdateItem operation.
    ///
    /// There is no additional cost associated with requesting a return value aside
    /// from the
    /// small network and processing overhead of receiving a larger response. No
    /// read capacity
    /// units are consumed.
    ///
    /// The values returned are strongly consistent.
    return_values: ?ReturnValue = null,

    /// An optional parameter that returns the item attributes for an `UpdateItem`
    /// operation that failed a condition check.
    ///
    /// There is no additional cost associated with requesting a return value aside
    /// from the
    /// small network and processing overhead of receiving a larger response. No
    /// read capacity
    /// units are consumed.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure = null,

    /// The name of the table containing the item to update. You can also provide
    /// the
    /// Amazon Resource Name (ARN) of the table in this parameter.
    table_name: []const u8,

    /// An expression that defines one or more attributes to be updated, the action
    /// to be
    /// performed on them, and new values for them.
    ///
    /// The following action values are available for `UpdateExpression`.
    ///
    /// * `SET` - Adds one or more attributes and values to an item. If any of
    /// these attributes already exist, they are replaced by the new values. You can
    /// also use `SET` to add or subtract from an attribute that is of type
    /// Number. For example: `SET myNum = myNum + :val`
    ///
    /// `SET` supports the following functions:
    ///
    /// * `if_not_exists (path, operand)` - if the item does not
    /// contain an attribute at the specified path, then
    /// `if_not_exists` evaluates to operand; otherwise, it
    /// evaluates to path. You can use this function to avoid overwriting an
    /// attribute that may already be present in the item.
    ///
    /// * `list_append (operand, operand)` - evaluates to a list with a
    /// new element added to it. You can append the new element to the start or
    /// the end of the list by reversing the order of the operands.
    ///
    /// These function names are case-sensitive.
    ///
    /// * `REMOVE` - Removes one or more attributes from an item.
    ///
    /// * `ADD` - Adds the specified value to the item, if the attribute does
    /// not already exist. If the attribute does exist, then the behavior of
    /// `ADD` depends on the data type of the attribute:
    ///
    /// * If the existing attribute is a number, and if `Value` is
    /// also a number, then `Value` is mathematically added to the
    /// existing attribute. If `Value` is a negative number, then it
    /// is subtracted from the existing attribute.
    ///
    /// **Note:**
    ///
    /// If you use `ADD` to increment or decrement a number
    /// value for an item that doesn't exist before the update, DynamoDB
    /// uses `0` as the initial value.
    ///
    /// Similarly, if you use `ADD` for an existing item to
    /// increment or decrement an attribute value that doesn't exist before
    /// the update, DynamoDB uses `0` as the initial value. For
    /// example, suppose that the item you want to update doesn't have an
    /// attribute named `itemcount`, but you decide to
    /// `ADD` the number `3` to this attribute
    /// anyway. DynamoDB will create the `itemcount` attribute,
    /// set its initial value to `0`, and finally add
    /// `3` to it. The result will be a new
    /// `itemcount` attribute in the item, with a value of
    /// `3`.
    ///
    /// * If the existing data type is a set and if `Value` is also a
    /// set, then `Value` is added to the existing set. For example,
    /// if the attribute value is the set `[1,2]`, and the
    /// `ADD` action specified `[3]`, then the final
    /// attribute value is `[1,2,3]`. An error occurs if an
    /// `ADD` action is specified for a set attribute and the
    /// attribute type specified does not match the existing set type.
    ///
    /// Both sets must have the same primitive data type. For example, if the
    /// existing data type is a set of strings, the `Value` must also
    /// be a set of strings.
    ///
    /// **Important:**
    ///
    /// The `ADD` action only supports Number and set data types. In
    /// addition, `ADD` can only be used on top-level attributes, not
    /// nested attributes.
    ///
    /// * `DELETE` - Deletes an element from a set.
    ///
    /// If a set of values is specified, then those values are subtracted from the
    /// old
    /// set. For example, if the attribute value was the set `[a,b,c]` and
    /// the `DELETE` action specifies `[a,c]`, then the final
    /// attribute value is `[b]`. Specifying an empty set is an error.
    ///
    /// **Important:**
    ///
    /// The `DELETE` action only supports set data types. In addition,
    /// `DELETE` can only be used on top-level attributes, not nested
    /// attributes.
    ///
    /// You can have many actions in a single expression, such as the following:
    /// `SET
    /// a=:value1, b=:value2 DELETE :value3, :value4, :value5`
    ///
    /// For more information on update expressions, see [Modifying
    /// Items and
    /// Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.Modifying.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    update_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_updates = "AttributeUpdates",
        .conditional_operator = "ConditionalOperator",
        .condition_expression = "ConditionExpression",
        .expected = "Expected",
        .expression_attribute_names = "ExpressionAttributeNames",
        .expression_attribute_values = "ExpressionAttributeValues",
        .key = "Key",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .return_item_collection_metrics = "ReturnItemCollectionMetrics",
        .return_values = "ReturnValues",
        .return_values_on_condition_check_failure = "ReturnValuesOnConditionCheckFailure",
        .table_name = "TableName",
        .update_expression = "UpdateExpression",
    };
};

pub const UpdateItemOutput = struct {
    /// A map of attribute values as they appear before or after the `UpdateItem`
    /// operation, as determined by the `ReturnValues` parameter.
    ///
    /// The `Attributes` map is only present if the update was successful and
    /// `ReturnValues` was specified as something other than `NONE` in
    /// the request. Each element represents one attribute.
    attributes: ?[]const u8 = null,

    /// The capacity units consumed by the `UpdateItem` operation. The data
    /// returned includes the total provisioned throughput consumed, along with
    /// statistics for
    /// the table and any indexes involved in the operation. `ConsumedCapacity` is
    /// only returned if the `ReturnConsumedCapacity` parameter was specified. For
    /// more information, see [Capacity unity consumption for write
    /// operations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/read-write-operations.html#write-operation-consumption) in the *Amazon
    /// DynamoDB Developer Guide*.
    consumed_capacity: ?ConsumedCapacity = null,

    /// Information about item collections, if any, that were affected by the
    /// `UpdateItem` operation. `ItemCollectionMetrics` is only
    /// returned if the `ReturnItemCollectionMetrics` parameter was specified. If
    /// the
    /// table does not have any local secondary indexes, this information is not
    /// returned in the
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const UpdateItemOutput) void {
        if (self.attributes) |v| {
            self.allocator.free(v);
        }
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

pub fn execute(client: *Client, input: UpdateItemInput, options: Options) !UpdateItemOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("dynamodb", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.attribute_updates) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AttributeUpdates\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.conditional_operator) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ConditionalOperator\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.condition_expression) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ConditionExpression\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.expected) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Expected\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.expression_attribute_names) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ExpressionAttributeNames\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.expression_attribute_values) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ExpressionAttributeValues\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Key\":\"");
    try appendJsonEscaped(alloc, &body_buf, input.key);
    try body_buf.appendSlice(alloc, "\"");
    has_prev = true;
    if (input.return_consumed_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ReturnConsumedCapacity\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.return_item_collection_metrics) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ReturnItemCollectionMetrics\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.return_values) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ReturnValues\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.return_values_on_condition_check_failure) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ReturnValuesOnConditionCheckFailure\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"TableName\":\"");
    try appendJsonEscaped(alloc, &body_buf, input.table_name);
    try body_buf.appendSlice(alloc, "\"");
    has_prev = true;
    if (input.update_expression) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"UpdateExpression\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
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
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDB_20120810.UpdateItem");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{ .allocator = alloc };
    return aws.json.parseJsonObject(UpdateItemOutput, body, alloc);
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
