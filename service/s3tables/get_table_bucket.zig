const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableBucketType = @import("table_bucket_type.zig").TableBucketType;

pub const GetTableBucketInput = struct {
    /// The Amazon Resource Name (ARN) of the table bucket.
    table_bucket_arn: []const u8,

    pub const json_field_names = .{
        .table_bucket_arn = "tableBucketARN",
    };
};

pub const GetTableBucketOutput = struct {
    /// The Amazon Resource Name (ARN) of the table bucket.
    arn: []const u8,

    /// The date and time the table bucket was created.
    created_at: i64,

    /// The name of the table bucket
    name: []const u8,

    /// The ID of the account that owns the table bucket.
    owner_account_id: []const u8,

    /// The unique identifier of the table bucket.
    table_bucket_id: ?[]const u8 = null,

    /// The type of the table bucket.
    @"type": ?TableBucketType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .name = "name",
        .owner_account_id = "ownerAccountId",
        .table_bucket_id = "tableBucketId",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableBucketInput, options: CallOptions) !GetTableBucketOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/buckets/");
    try path_buf.appendSlice(allocator, input.table_bucket_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableBucketOutput {
    const result: GetTableBucketOutput = try aws.json.parseJsonObject(
        GetTableBucketOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
