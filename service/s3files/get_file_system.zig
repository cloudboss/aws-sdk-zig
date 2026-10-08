const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;
const Tag = @import("tag.zig").Tag;

pub const GetFileSystemInput = struct {
    /// The ID or Amazon Resource Name (ARN) of the S3 File System to retrieve
    /// information for.
    file_system_id: []const u8,

    pub const json_field_names = .{
        .file_system_id = "fileSystemId",
    };
};

pub const GetFileSystemOutput = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket.
    bucket: ?[]const u8 = null,

    /// The client token used for idempotency when the file system was created.
    client_token: ?[]const u8 = null,

    /// The time when the file system was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the file system.
    file_system_arn: ?[]const u8 = null,

    /// The ID of the file system.
    file_system_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services KMS key used for
    /// encryption.
    kms_key_id: ?[]const u8 = null,

    /// The name of the file system.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the file system owner.
    owner_id: ?[]const u8 = null,

    /// The prefix in the S3 bucket that the file system provides access to.
    prefix: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role used for S3 access.
    role_arn: ?[]const u8 = null,

    /// The current status of the file system.
    status: ?LifeCycleState = null,

    /// Additional information about the file system status.
    status_message: ?[]const u8 = null,

    /// The tags associated with the file system.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .client_token = "clientToken",
        .creation_time = "creationTime",
        .file_system_arn = "fileSystemArn",
        .file_system_id = "fileSystemId",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .owner_id = "ownerId",
        .prefix = "prefix",
        .role_arn = "roleArn",
        .status = "status",
        .status_message = "statusMessage",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFileSystemInput, options: CallOptions) !GetFileSystemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3files", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/file-systems/");
    try path_buf.appendSlice(allocator, input.file_system_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFileSystemOutput {
    const result: GetFileSystemOutput = try aws.json.parseJsonObject(
        GetFileSystemOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
