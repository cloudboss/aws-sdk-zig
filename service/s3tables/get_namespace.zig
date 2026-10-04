const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetNamespaceInput = struct {
    /// The name of the namespace.
    namespace: []const u8,

    /// The Amazon Resource Name (ARN) of the table bucket.
    table_bucket_arn: []const u8,

    pub const json_field_names = .{
        .namespace = "namespace",
        .table_bucket_arn = "tableBucketARN",
    };
};

pub const GetNamespaceOutput = struct {
    /// The date and time the namespace was created at.
    created_at: i64,

    /// The ID of the account that created the namespace.
    created_by: []const u8,

    /// The name of the namespace.
    namespace: ?[]const []const u8 = null,

    /// The unique identifier of the namespace.
    namespace_id: ?[]const u8 = null,

    /// The ID of the account that owns the namespcace.
    owner_account_id: []const u8,

    /// The unique identifier of the table bucket containing this namespace.
    table_bucket_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .namespace = "namespace",
        .namespace_id = "namespaceId",
        .owner_account_id = "ownerAccountId",
        .table_bucket_id = "tableBucketId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNamespaceInput, options: CallOptions) !GetNamespaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.table_bucket_arn);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.namespace);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNamespaceOutput {
    const result: GetNamespaceOutput = try aws.json.parseJsonObject(
        GetNamespaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
