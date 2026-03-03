const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RetentionLockType = @import("retention_lock_type.zig").RetentionLockType;
const TapeStorageClass = @import("tape_storage_class.zig").TapeStorageClass;
const Tag = @import("tag.zig").Tag;

pub const CreateTapePoolInput = struct {
    /// The name of the new custom tape pool.
    pool_name: []const u8,

    /// Tape retention lock time is set in days. Tape retention lock can be enabled
    /// for up to
    /// 100 years (36,500 days).
    retention_lock_time_in_days: ?i32 = null,

    /// Tape retention lock can be configured in two modes. When configured in
    /// governance mode,
    /// Amazon Web Services accounts with specific IAM permissions are authorized to
    /// remove the
    /// tape retention lock from archived virtual tapes. When configured in
    /// compliance mode, the
    /// tape retention lock cannot be removed by any user, including the root Amazon
    /// Web Services account.
    retention_lock_type: ?RetentionLockType = null,

    /// The storage class that is associated with the new custom pool. When you use
    /// your backup
    /// application to eject the tape, the tape is archived directly into the
    /// storage class (S3
    /// Glacier or S3 Glacier Deep Archive) that corresponds to the pool.
    storage_class: TapeStorageClass,

    /// A list of up to 50 tags that can be assigned to tape pool. Each tag is a
    /// key-value
    /// pair.
    ///
    /// Valid characters for key and value are letters, spaces, and numbers
    /// representable in
    /// UTF-8 format, and the following special characters: + - = . _ : / @. The
    /// maximum length
    /// of a tag's key is 128 characters, and the maximum length for a tag's value
    /// is
    /// 256.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .pool_name = "PoolName",
        .retention_lock_time_in_days = "RetentionLockTimeInDays",
        .retention_lock_type = "RetentionLockType",
        .storage_class = "StorageClass",
        .tags = "Tags",
    };
};

pub const CreateTapePoolOutput = struct {
    /// The unique Amazon Resource Name (ARN) that represents the custom tape pool.
    /// Use the
    /// ListTapePools operation to return a list of tape pools for your
    /// account and Amazon Web Services Region.
    pool_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .pool_arn = "PoolARN",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTapePoolInput, options: Options) !CreateTapePoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTapePoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.CreateTapePool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTapePoolOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTapePoolOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
