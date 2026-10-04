const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReturnConsumedCapacity = @import("return_consumed_capacity.zig").ReturnConsumedCapacity;
const ParameterizedStatement = @import("parameterized_statement.zig").ParameterizedStatement;
const ConsumedCapacity = @import("consumed_capacity.zig").ConsumedCapacity;
const ItemResponse = @import("item_response.zig").ItemResponse;

pub const ExecuteTransactionInput = struct {
    /// Set this value to get remaining results, if `NextToken` was returned in the
    /// statement response.
    client_request_token: ?[]const u8 = null,

    /// Determines the level of detail about either provisioned or on-demand
    /// throughput
    /// consumption that is returned in the response. For more information, see
    /// [TransactGetItems](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_TransactGetItems.html) and [TransactWriteItems](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_TransactWriteItems.html).
    return_consumed_capacity: ?ReturnConsumedCapacity = null,

    /// The list of PartiQL statements representing the transaction to run.
    transact_statements: []const ParameterizedStatement,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .return_consumed_capacity = "ReturnConsumedCapacity",
        .transact_statements = "TransactStatements",
    };
};

pub const ExecuteTransactionOutput = struct {
    /// The capacity units consumed by the entire operation. The values of the list
    /// are
    /// ordered according to the ordering of the statements.
    consumed_capacity: ?[]const ConsumedCapacity = null,

    /// The response to a PartiQL transaction.
    responses: ?[]const ItemResponse = null,

    pub const json_field_names = .{
        .consumed_capacity = "ConsumedCapacity",
        .responses = "Responses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteTransactionInput, options: CallOptions) !ExecuteTransactionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteTransactionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.ExecuteTransaction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteTransactionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExecuteTransactionOutput, body, allocator);
}
