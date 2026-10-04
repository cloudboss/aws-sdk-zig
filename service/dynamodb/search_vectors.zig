const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const VectorCapacity = @import("vector_capacity.zig").VectorCapacity;
const SearchResultItem = @import("search_result_item.zig").SearchResultItem;

pub const SearchVectorsInput = struct {
    /// One or more substitution tokens for attribute names in an expression. Use
    /// the
    /// `#` character in an expression to dereference an attribute name.
    expression_attribute_names: ?[]const aws.map.StringMapEntry = null,

    /// One or more values that can be substituted in an expression. Use the
    /// `:` character in an expression to dereference an attribute value.
    expression_attribute_values: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The name of the vector index to search. The index must be in the
    /// `ACTIVE` state.
    index_name: []const u8,

    /// A string that identifies one or more attributes to retrieve from the index.
    /// Separate attribute names with commas. If not specified, the operation
    /// returns all
    /// attributes projected into the vector index.
    ///
    /// Only attributes projected into the vector index can be retrieved.
    projection_expression: ?[]const u8 = null,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// A condition expression used to filter the vector search results. The
    /// expression can
    /// reference attributes defined in the vector index search schema, including
    /// `HASH` and `INLINE_FILTER` key elements.
    ///
    /// Only the equality operator (`=`) is supported for `HASH`
    /// attributes. Comparison and range operators are supported for
    /// `INLINE_FILTER` attributes. Only top-level attributes from the search
    /// schema can be referenced.
    search_condition_expression: ?[]const u8 = null,

    /// The search vector to compare against the indexed vectors. Each element is a
    /// 32-bit
    /// IEEE-754 floating point number, provided in DynamoDB list format.
    ///
    /// The number of dimensions must match the number of dimensions configured for
    /// the
    /// vector index.
    search_vector: []const AttributeValue,

    /// The name or Amazon Resource Name (ARN) of the table containing the vector
    /// index.
    table_name: []const u8,

    /// The number of most similar results to return.
    top_k: i32,

    pub const json_field_names = .{
        .expression_attribute_names = "ExpressionAttributeNames",
        .expression_attribute_values = "ExpressionAttributeValues",
        .index_name = "IndexName",
        .projection_expression = "ProjectionExpression",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .search_condition_expression = "SearchConditionExpression",
        .search_vector = "SearchVector",
        .table_name = "TableName",
        .top_k = "TopK",
    };
};

pub const SearchVectorsOutput = struct {
    /// The capacity units consumed by the `SearchVectors` operation. Contains
    /// `VectorSearchRequestBytes`, which represents the vector search capacity
    /// consumed.
    consumed_capacity: ?VectorCapacity = null,

    /// A list of items returned by the vector similarity search, sorted by
    /// similarity
    /// with the most similar item first. Each item contains the projected
    /// attributes and
    /// a similarity score.
    search_results: ?[]const SearchResultItem = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .search_results = "SearchResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchVectorsInput, options: CallOptions) !SearchVectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchVectorsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.SearchVectors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchVectorsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchVectorsOutput, body, allocator);
}
