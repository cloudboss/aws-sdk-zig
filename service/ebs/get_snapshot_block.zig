const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;

pub const GetSnapshotBlockInput = struct {
    /// The block index of the block in which to read the data. A block index is a
    /// logical
    /// index in units of `512` KiB blocks. To identify the block index, divide
    /// the logical offset of the data in the logical volume by the block size
    /// (logical offset
    /// of data/`524288`). The logical offset of the data must be `512`
    /// KiB aligned.
    block_index: i32,

    /// The block token of the block from which to get data. You can obtain the
    /// `BlockToken`
    /// by running the `ListChangedBlocks` or `ListSnapshotBlocks` operations.
    block_token: []const u8,

    /// The ID of the snapshot containing the block from which to get data.
    ///
    /// If the specified snapshot is encrypted, you must have permission to use the
    /// KMS key that was used to encrypt the snapshot. For more information, see
    /// [
    /// Using
    /// encryption](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebsapis-using-encryption.html) in the *Amazon Elastic Compute Cloud User
    /// Guide*.
    snapshot_id: []const u8,

    pub const json_field_names = .{
        .block_index = "BlockIndex",
        .block_token = "BlockToken",
        .snapshot_id = "SnapshotId",
    };
};

pub const GetSnapshotBlockOutput = struct {
    /// The data content of the block.
    block_data: ?aws.http.StreamingBody = null,

    /// The checksum generated for the block, which is Base64 encoded.
    checksum: ?[]const u8 = null,

    /// The algorithm used to generate the checksum for the block, such as SHA256.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The size of the data in the block.
    data_length: ?i32 = null,

    pub fn deinit(self: *GetSnapshotBlockOutput) void {
        if (self.block_data) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .block_data = "BlockData",
        .checksum = "Checksum",
        .checksum_algorithm = "ChecksumAlgorithm",
        .data_length = "DataLength",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSnapshotBlockInput, options: CallOptions) !GetSnapshotBlockOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ebs");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, error_body, stream_resp.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetSnapshotBlockInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ebs", "EBS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/snapshots/");
    try path_buf.appendSlice(allocator, input.snapshot_id);
    try path_buf.appendSlice(allocator, "/blocks/");
    try path_buf.appendSlice(allocator, input.block_index);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "blockToken=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.block_token);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetSnapshotBlockOutput {
    var result: GetSnapshotBlockOutput = .{};
    result.block_data = stream_resp.body;
    if (stream_resp.headers.get("x-amz-checksum")) |value| {
        result.checksum = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-algorithm")) |value| {
        result.checksum_algorithm = ChecksumAlgorithm.fromWireName(value);
    }
    if (stream_resp.headers.get("x-amz-data-length")) |value| {
        result.data_length = std.fmt.parseInt(i32, value, 10) catch null;
    }
    stream_resp.deinitHeaders();

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestThrottledException")) {
        return .{ .arena = arena, .kind = .{ .request_throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
