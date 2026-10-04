const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableReplicationConfiguration = @import("table_replication_configuration.zig").TableReplicationConfiguration;

pub const GetTableReplicationInput = struct {
    /// The Amazon Resource Name (ARN) of the table.
    table_arn: []const u8,

    pub const json_field_names = .{
        .table_arn = "tableArn",
    };
};

pub const GetTableReplicationOutput = struct {
    /// The replication configuration for the table, including the IAM role and
    /// replication rules.
    configuration: ?TableReplicationConfiguration = null,

    /// A version token that represents the current state of the table's replication
    /// configuration. Use this token when updating the configuration to ensure
    /// consistency.
    version_token: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .version_token = "versionToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableReplicationInput, options: CallOptions) !GetTableReplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3tables", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableReplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/table-replication";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "tableArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.table_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableReplicationOutput {
    const result: GetTableReplicationOutput = try aws.json.parseJsonObject(
        GetTableReplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
