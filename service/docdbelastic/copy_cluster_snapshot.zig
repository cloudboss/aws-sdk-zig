const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClusterSnapshot = @import("cluster_snapshot.zig").ClusterSnapshot;

pub const CopyClusterSnapshotInput = struct {
    /// Set to `true` to copy all tags from the source cluster snapshot to the
    /// target elastic cluster snapshot.
    /// The default is `false`.
    copy_tags: ?bool = null,

    /// The Amazon Web Services KMS key ID for an encrypted elastic cluster
    /// snapshot.
    /// The Amazon Web Services KMS key ID is the Amazon Resource Name (ARN), Amazon
    /// Web Services KMS key identifier, or the Amazon Web Services KMS key alias
    /// for the Amazon Web Services KMS encryption key.
    ///
    /// If you copy an encrypted elastic cluster snapshot from your Amazon Web
    /// Services account, you can specify a value for `KmsKeyId` to encrypt the copy
    /// with a new Amazon Web ServicesS KMS encryption key.
    /// If you don't specify a value for `KmsKeyId`, then the copy of the elastic
    /// cluster snapshot is encrypted with the same `AWS` KMS key as the source
    /// elastic cluster snapshot.
    ///
    /// To copy an encrypted elastic cluster snapshot to another Amazon Web Services
    /// region, set `KmsKeyId` to the Amazon Web Services KMS key ID that you want
    /// to use to encrypt the copy of the elastic cluster snapshot in the
    /// destination region.
    /// Amazon Web Services KMS encryption keys are specific to the Amazon Web
    /// Services region that they are created in, and you can't use encryption keys
    /// from one Amazon Web Services region in another Amazon Web Services region.
    ///
    /// If you copy an unencrypted elastic cluster snapshot and specify a value for
    /// the `KmsKeyId` parameter, an error is returned.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) identifier of the elastic cluster snapshot.
    snapshot_arn: []const u8,

    /// The tags to be assigned to the elastic cluster snapshot.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the new elastic cluster snapshot to create from the source
    /// cluster snapshot.
    /// This parameter is not case sensitive.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    ///
    /// * The first character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `elastic-cluster-snapshot-5`
    target_snapshot_name: []const u8,

    pub const json_field_names = .{
        .copy_tags = "copyTags",
        .kms_key_id = "kmsKeyId",
        .snapshot_arn = "snapshotArn",
        .tags = "tags",
        .target_snapshot_name = "targetSnapshotName",
    };
};

pub const CopyClusterSnapshotOutput = struct {
    snapshot: ?ClusterSnapshot = null,

    pub const json_field_names = .{
        .snapshot = "snapshot",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyClusterSnapshotInput, options: Options) !CopyClusterSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "docdbelastic");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyClusterSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("docdbelastic", "DocDB Elastic", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/cluster-snapshot/");
    try path_buf.appendSlice(allocator, input.snapshot_arn);
    try path_buf.appendSlice(allocator, "/copy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.copy_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"copyTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetSnapshotName\":");
    try aws.json.writeValue(@TypeOf(input.target_snapshot_name), input.target_snapshot_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyClusterSnapshotOutput {
    var result: CopyClusterSnapshotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CopyClusterSnapshotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
