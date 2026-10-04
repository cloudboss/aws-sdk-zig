const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CommitTransactionInput = struct {
    /// The Amazon Resource Name (ARN) of the Aurora Serverless DB cluster.
    resource_arn: []const u8,

    /// The name or ARN of the secret that enables access to the DB cluster.
    secret_arn: []const u8,

    /// The identifier of the transaction to end and commit.
    transaction_id: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .secret_arn = "secretArn",
        .transaction_id = "transactionId",
    };
};

pub const CommitTransactionOutput = struct {
    /// The status of the commit operation.
    transaction_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .transaction_status = "transactionStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CommitTransactionInput, options: CallOptions) !CommitTransactionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds-data", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CommitTransactionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds-data", "RDS Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CommitTransaction";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"secretArn\":");
    try aws.json.writeValue(@TypeOf(input.secret_arn), input.secret_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"transactionId\":");
    try aws.json.writeValue(@TypeOf(input.transaction_id), input.transaction_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CommitTransactionOutput {
    var result: CommitTransactionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CommitTransactionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
