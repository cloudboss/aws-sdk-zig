const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ETagAlgorithmFamily = @import("e_tag_algorithm_family.zig").ETagAlgorithmFamily;
const SequenceStoreS3Access = @import("sequence_store_s3_access.zig").SequenceStoreS3Access;
const SseConfig = @import("sse_config.zig").SseConfig;
const SequenceStoreStatus = @import("sequence_store_status.zig").SequenceStoreStatus;

pub const GetSequenceStoreInput = struct {
    /// The store's ID.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetSequenceStoreOutput = struct {
    /// The store's ARN.
    arn: []const u8,

    /// When the store was created.
    creation_time: i64,

    /// The store's description.
    description: ?[]const u8 = null,

    /// The algorithm family of the ETag.
    e_tag_algorithm_family: ?ETagAlgorithmFamily = null,

    /// An S3 location that is used to store files that have failed a direct upload.
    fallback_location: ?[]const u8 = null,

    /// The store's ID.
    id: []const u8,

    /// The store's name.
    name: ?[]const u8 = null,

    /// The tags keys to propagate to the S3 objects associated with read sets in
    /// the sequence store.
    propagated_set_level_tags: ?[]const []const u8 = null,

    /// The S3 metadata of a sequence store, including the ARN and S3 URI of the S3
    /// bucket.
    s_3_access: ?SequenceStoreS3Access = null,

    /// The store's server-side encryption (SSE) settings.
    sse_config: ?SseConfig = null,

    /// The status of the sequence store.
    status: ?SequenceStoreStatus = null,

    /// The status message of the sequence store.
    status_message: ?[]const u8 = null,

    /// The last-updated time of the sequence store.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .e_tag_algorithm_family = "eTagAlgorithmFamily",
        .fallback_location = "fallbackLocation",
        .id = "id",
        .name = "name",
        .propagated_set_level_tags = "propagatedSetLevelTags",
        .s_3_access = "s3Access",
        .sse_config = "sseConfig",
        .status = "status",
        .status_message = "statusMessage",
        .update_time = "updateTime",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSequenceStoreInput, options: Options) !GetSequenceStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "omics");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSequenceStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSequenceStoreOutput {
    var result: GetSequenceStoreOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSequenceStoreOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "NotSupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .not_supported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RangeNotSatisfiableException")) {
        return .{ .arena = arena, .kind = .{ .range_not_satisfiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .request_timeout_exception = .{
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
