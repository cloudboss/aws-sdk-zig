const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RenameTableInput = struct {
    /// The current name of the table.
    name: []const u8,

    /// The namespace associated with the table.
    namespace: []const u8,

    /// The new name for the table.
    new_name: ?[]const u8 = null,

    /// The new name for the namespace.
    new_namespace_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the table bucket.
    table_bucket_arn: []const u8,

    /// The version token of the table.
    version_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .namespace = "namespace",
        .new_name = "newName",
        .new_namespace_name = "newNamespaceName",
        .table_bucket_arn = "tableBucketARN",
        .version_token = "versionToken",
    };
};

pub const RenameTableOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RenameTableInput, options: CallOptions) !RenameTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RenameTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tables/");
    try path_buf.appendSlice(allocator, input.table_bucket_arn);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/rename");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.new_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"newName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.new_namespace_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"newNamespaceName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"versionToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RenameTableOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RenameTableOutput = .{};

    return result;
}
