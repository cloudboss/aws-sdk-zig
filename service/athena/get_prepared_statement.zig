const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PreparedStatement = @import("prepared_statement.zig").PreparedStatement;

pub const GetPreparedStatementInput = struct {
    /// The name of the prepared statement to retrieve.
    statement_name: []const u8,

    /// The workgroup to which the statement to be retrieved belongs.
    work_group: []const u8,

    pub const json_field_names = .{
        .statement_name = "StatementName",
        .work_group = "WorkGroup",
    };
};

pub const GetPreparedStatementOutput = struct {
    /// The name of the prepared statement that was retrieved.
    prepared_statement: ?PreparedStatement = null,

    pub const json_field_names = .{
        .prepared_statement = "PreparedStatement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPreparedStatementInput, options: CallOptions) !GetPreparedStatementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPreparedStatementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.GetPreparedStatement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPreparedStatementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPreparedStatementOutput, body, allocator);
}
