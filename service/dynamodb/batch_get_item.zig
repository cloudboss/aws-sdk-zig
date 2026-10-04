const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeysAndAttributes = @import("keys_and_attributes.zig").KeysAndAttributes;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;
const AttributeValue = @import("attribute_value.zig").AttributeValue;

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
    request_items: []const aws.map.MapEntry(KeysAndAttributes),

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
    responses: ?[]const aws.map.MapEntry([]const []const aws.map.MapEntry(AttributeValue)) = null,

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
    unprocessed_keys: ?[]const aws.map.MapEntry(KeysAndAttributes) = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .responses = "Responses",
        .unprocessed_keys = "UnprocessedKeys",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetItemInput, options: CallOptions) !BatchGetItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetItemInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.BatchGetItem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetItemOutput, body, allocator);
}
