const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;

pub const ExecuteStatementInput = struct {
    /// The consistency of a read operation. If set to `true`, then a strongly
    /// consistent read is used; otherwise, an eventually consistent read is used.
    consistent_read: ?bool = null,

    /// The maximum number of items to evaluate (not necessarily the number of
    /// matching
    /// items). If DynamoDB processes the number of items up to the limit while
    /// processing the
    /// results, it stops the operation and returns the matching values up to that
    /// point, along
    /// with a key in `LastEvaluatedKey` to apply in a subsequent operation so you
    /// can pick up where you left off. Also, if the processed dataset size exceeds
    /// 1 MB before
    /// DynamoDB reaches this limit, it stops the operation and returns the matching
    /// values up
    /// to the limit, and a key in `LastEvaluatedKey` to apply in a subsequent
    /// operation to continue the operation.
    limit: ?i32 = null,

    /// Set this value to get remaining results, if `NextToken` was returned in the
    /// statement response.
    next_token: ?[]const u8 = null,

    /// The parameters for the PartiQL statement, if any.
    parameters: ?[]const AttributeValue = null,

    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// An optional parameter that returns the item attributes for an
    /// `ExecuteStatement` operation that failed a condition check.
    ///
    /// There is no additional cost associated with requesting a return value aside
    /// from the
    /// small network and processing overhead of receiving a larger response. No
    /// read capacity
    /// units are consumed.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure = null,

    /// The PartiQL statement representing the operation to run.
    statement: []const u8,

    pub const json_field_names = .{
        .consistent_read = "ConsistentRead",
        .limit = "Limit",
        .next_token = "NextToken",
        .parameters = "Parameters",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .return_values_on_condition_check_failure = "ReturnValuesOnConditionCheckFailure",
        .statement = "Statement",
    };
};

pub const ExecuteStatementOutput = struct {
    consumed_capacity: ?ConsumedCapacity = null,

    /// If a read operation was used, this property will contain the result of the
    /// read
    /// operation; a map of attribute names and their values. For the write
    /// operations this
    /// value will be empty.
    items: ?[]const []const aws.map.MapEntry(AttributeValue) = null,

    /// The primary key of the item where the operation stopped, inclusive of the
    /// previous
    /// result set. Use this value to start a new operation, excluding this value in
    /// the new
    /// request. If `LastEvaluatedKey` is empty, then the "last page" of results has
    /// been processed and there is no more data to be retrieved. If
    /// `LastEvaluatedKey` is not empty, it does not necessarily mean that there
    /// is more data in the result set. The only way to know when you have reached
    /// the end of
    /// the result set is when `LastEvaluatedKey` is empty.
    last_evaluated_key: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// If the response of a read request exceeds the response payload limit
    /// DynamoDB will set
    /// this value in the response. If set, you can use that this value in the
    /// subsequent
    /// request to get the remaining results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .items = "Items",
        .last_evaluated_key = "LastEvaluatedKey",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteStatementInput, options: CallOptions) !ExecuteStatementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteStatementInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.ExecuteStatement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteStatementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExecuteStatementOutput, body, allocator);
}
