const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;

pub const GetItemInput = struct {
    /// This is a legacy parameter. Use `ProjectionExpression` instead. For more
    /// information, see
    /// [AttributesToGet](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    attributes_to_get: ?[]const []const u8 = null,

    /// Determines the read consistency model: If set to `true`, then the operation
    /// uses strongly consistent reads; otherwise, the operation uses eventually
    /// consistent
    /// reads.
    consistent_read: ?bool = null,

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

    /// A map of attribute names to `AttributeValue` objects, representing the
    /// primary key of the item to retrieve.
    ///
    /// For the primary key, you must provide all of the attributes. For example,
    /// with a
    /// simple primary key, you only need to provide a value for the partition key.
    /// For a
    /// composite primary key, you must provide values for both the partition key
    /// and the sort
    /// key.
    key: []const aws.map.MapEntry(AttributeValue),

    /// A string that identifies one or more attributes to retrieve from the table.
    /// These
    /// attributes can include scalars, sets, or elements of a JSON document. The
    /// attributes in
    /// the expression must be separated by commas.
    ///
    /// If no attribute names are specified, then all attributes are returned. If
    /// any of the
    /// requested attributes are not found, they do not appear in the result.
    ///
    /// For more information, see [Specifying Item
    /// Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    projection_expression: ?[]const u8 = null,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// The name of the table containing the requested item. You can also provide
    /// the
    /// Amazon Resource Name (ARN) of the table in this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .attributes_to_get = "AttributesToGet",
        .consistent_read = "ConsistentRead",
        .expression_attribute_names = "ExpressionAttributeNames",
        .key = "Key",
        .projection_expression = "ProjectionExpression",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .table_name = "TableName",
    };
};

pub const GetItemOutput = struct {
    /// The capacity units consumed by the `GetItem` operation. The data returned
    /// includes the total provisioned throughput consumed, along with statistics
    /// for the table
    /// and any indexes involved in the operation. `ConsumedCapacity` is only
    /// returned if the `ReturnConsumedCapacity` parameter was specified. For more
    /// information, see [Capacity unit consumption for read
    /// operations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/read-write-operations.html#read-operation-consumption) in the *Amazon
    /// DynamoDB Developer Guide*.
    consumed_capacity: ?ConsumedCapacity = null,

    /// A map of attribute names to `AttributeValue` objects, as specified by
    /// `ProjectionExpression`.
    item: ?[]const aws.map.MapEntry(AttributeValue) = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .item = "Item",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetItemInput, options: CallOptions) !GetItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetItemInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.GetItem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetItemOutput, body, allocator);
}
