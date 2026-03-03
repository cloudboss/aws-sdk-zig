const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;

pub const CreateStorediSCSIVolumeInput = struct {
    /// The unique identifier for the gateway local disk that is configured as a
    /// stored volume.
    /// Use
    /// [ListLocalDisks](https://docs.aws.amazon.com/storagegateway/latest/userguide/API_ListLocalDisks.html) to
    /// list disk IDs for a gateway.
    disk_id: []const u8,

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

    /// The network interface of the gateway on which to expose the iSCSI target.
    /// Accepts IPv4
    /// and IPv6 addresses. Use DescribeGatewayInformation to get a list of the
    /// network interfaces available on a gateway.
    ///
    /// Valid Values: A valid IP address.
    network_interface_id: []const u8,

    /// Set to `true` if you want to preserve the data on the local disk. Otherwise,
    /// set to `false` to create an empty volume.
    ///
    /// Valid Values: `true` | `false`
    preserve_existing_data: ?bool = null,

    /// The snapshot ID (e.g., "snap-1122aabb") of the snapshot to restore as the
    /// new stored
    /// volume. Specify this field if you want to create the iSCSI storage volume
    /// from a snapshot;
    /// otherwise, do not include this field. To list snapshots for your account use
    /// [DescribeSnapshots](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-DescribeSnapshots.html) in the *Amazon Elastic Compute Cloud API
    /// Reference*.
    snapshot_id: ?[]const u8 = null,

    /// A list of up to 50 tags that can be assigned to a stored volume. Each tag is
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

    /// The name of the iSCSI target used by an initiator to connect to a volume and
    /// used as a
    /// suffix for the target ARN. For example, specifying `TargetName` as
    /// *myvolume* results in the target ARN of
    /// `arn:aws:storagegateway:us-east-2:111122223333:gateway/sgw-12A3456B/target/iqn.1997-05.com.amazon:myvolume`.
    /// The target name must be unique across all volumes on a gateway.
    ///
    /// If you don't specify a value, Storage Gateway uses the value that was
    /// previously
    /// used for this volume as the new target name.
    target_name: []const u8,

    pub const json_field_names = .{
        .disk_id = "DiskId",
        .gateway_arn = "GatewayARN",
        .kms_encrypted = "KMSEncrypted",
        .kms_key = "KMSKey",
        .network_interface_id = "NetworkInterfaceId",
        .preserve_existing_data = "PreserveExistingData",
        .snapshot_id = "SnapshotId",
        .tags = "Tags",
        .target_name = "TargetName",
    };
};

pub const CreateStorediSCSIVolumeOutput = struct {
    /// The Amazon Resource Name (ARN) of the volume target, which includes the
    /// iSCSI name that
    /// initiators can use to connect to the target.
    target_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the configured volume.
    volume_arn: ?[]const u8 = null,

    /// The size of the volume in bytes.
    volume_size_in_bytes: ?i64 = null,

    pub const json_field_names = .{
        .target_arn = "TargetARN",
        .volume_arn = "VolumeARN",
        .volume_size_in_bytes = "VolumeSizeInBytes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStorediSCSIVolumeInput, options: CallOptions) !CreateStorediSCSIVolumeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStorediSCSIVolumeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.CreateStorediSCSIVolume");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStorediSCSIVolumeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateStorediSCSIVolumeOutput, body, allocator);
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
