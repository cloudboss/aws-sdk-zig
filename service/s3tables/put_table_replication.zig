const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableReplicationConfiguration = @import("table_replication_configuration.zig").TableReplicationConfiguration;

pub const PutTableReplicationInput = struct {
    /// The replication configuration to apply to the table, including the IAM role
    /// and replication rules.
    configuration: TableReplicationConfiguration,

    /// The Amazon Resource Name (ARN) of the source table.
    table_arn: []const u8,

    /// A version token from a previous GetTableReplication call. Use this token to
    /// ensure you're updating the expected version of the configuration.
    version_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .table_arn = "tableArn",
        .version_token = "versionToken",
    };
};

pub const PutTableReplicationOutput = struct {
    /// The status of the replication configuration operation.
    status: []const u8,

    /// A new version token representing the updated replication configuration.
    version_token: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .version_token = "versionToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutTableReplicationInput, options: CallOptions) !PutTableReplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutTableReplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/table-replication";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "tableArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.table_arn);
    query_has_prev = true;
    if (input.version_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutTableReplicationOutput {
    var result: PutTableReplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutTableReplicationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
