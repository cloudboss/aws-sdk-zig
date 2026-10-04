const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageClassConfiguration = @import("storage_class_configuration.zig").StorageClassConfiguration;

pub const GetTableBucketStorageClassInput = struct {
    /// The Amazon Resource Name (ARN) of the table bucket.
    table_bucket_arn: []const u8,

    pub const json_field_names = .{
        .table_bucket_arn = "tableBucketARN",
    };
};

pub const GetTableBucketStorageClassOutput = struct {
    /// The storage class configuration for the table bucket.
    storage_class_configuration: ?StorageClassConfiguration = null,

    pub const json_field_names = .{
        .storage_class_configuration = "storageClassConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableBucketStorageClassInput, options: CallOptions) !GetTableBucketStorageClassOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableBucketStorageClassInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/buckets/");
    try path_buf.appendSlice(allocator, input.table_bucket_arn);
    try path_buf.appendSlice(allocator, "/storage-class");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableBucketStorageClassOutput {
    var result: GetTableBucketStorageClassOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTableBucketStorageClassOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
