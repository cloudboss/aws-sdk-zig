const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;

pub const CreateTapesInput = struct {
    /// A unique identifier that you use to retry a request. If you retry a request,
    /// use the
    /// same `ClientToken` you specified in the initial request.
    ///
    /// Using the same `ClientToken` prevents creating the tape multiple
    /// times.
    client_token: []const u8,

    /// The unique Amazon Resource Name (ARN) that represents the gateway to
    /// associate the
    /// virtual tapes with. Use the ListGateways operation to return a list of
    /// gateways for your account and Amazon Web Services Region.
    gateway_arn: []const u8,

    /// Set to `true` to use Amazon S3 server-side encryption with your own
    /// KMS key, or `false` to use a key managed by Amazon S3.
    /// Optional.
    ///
    /// Valid Values: `true` | `false`
    kms_encrypted: ?bool = null,

    /// The Amazon Resource Name (ARN) of a symmetric customer master key (CMK) used
    /// for Amazon S3 server-side encryption. Storage Gateway does not support
    /// asymmetric CMKs. This
    /// value can only be set when `KMSEncrypted` is `true`. Optional.
    kms_key: ?[]const u8 = null,

    /// The number of virtual tapes that you want to create.
    num_tapes_to_create: i32,

    /// The ID of the pool that you want to add your tape to for archiving. The tape
    /// in this
    /// pool is archived in the S3 storage class that is associated with the pool.
    /// When you use
    /// your backup application to eject the tape, the tape is archived directly
    /// into the storage
    /// class (S3 Glacier or S3 Glacier Deep Archive) that corresponds to the pool.
    pool_id: ?[]const u8 = null,

    /// A list of up to 50 tags that can be assigned to a virtual tape. Each tag is
    /// a key-value
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

    /// A prefix that you append to the barcode of the virtual tape you are
    /// creating. This
    /// prefix makes the barcode unique.
    ///
    /// The prefix must be 1-4 characters in length and must be one of the uppercase
    /// letters
    /// from A to Z.
    tape_barcode_prefix: []const u8,

    /// The size, in bytes, of the virtual tapes that you want to create.
    ///
    /// The size must be aligned by gigabyte (1024*1024*1024 bytes).
    tape_size_in_bytes: i64,

    /// Set to `TRUE` if the tape you are creating is to be configured as a
    /// write-once-read-many (WORM) tape.
    worm: bool = false,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .gateway_arn = "GatewayARN",
        .kms_encrypted = "KMSEncrypted",
        .kms_key = "KMSKey",
        .num_tapes_to_create = "NumTapesToCreate",
        .pool_id = "PoolId",
        .tags = "Tags",
        .tape_barcode_prefix = "TapeBarcodePrefix",
        .tape_size_in_bytes = "TapeSizeInBytes",
        .worm = "Worm",
    };
};

pub const CreateTapesOutput = struct {
    /// A list of unique Amazon Resource Names (ARNs) that represents the virtual
    /// tapes that
    /// were created.
    tape_ar_ns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .tape_ar_ns = "TapeARNs",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTapesInput, options: Options) !CreateTapesOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTapesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "StorageGateway_20130630.CreateTapes");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateTapesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTapesOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
