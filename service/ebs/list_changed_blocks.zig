const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ChangedBlock = @import("changed_block.zig").ChangedBlock;

pub const ListChangedBlocksInput = struct {
    /// The ID of the first snapshot to use for the comparison.
    ///
    /// The `FirstSnapshotID` parameter must be specified with a
    /// `SecondSnapshotId` parameter; otherwise, an error occurs.
    first_snapshot_id: ?[]const u8 = null,

    /// The maximum number of blocks to be returned by the request.
    ///
    /// Even if additional blocks can be retrieved from the snapshot, the request
    /// can
    /// return less blocks than **MaxResults** or an empty
    /// array of blocks.
    ///
    /// To retrieve the next set of blocks from the snapshot, make another request
    /// with
    /// the returned **NextToken** value. The value of
    /// **NextToken** is `null` when there are no
    /// more blocks to return.
    max_results: ?i32 = null,

    /// The token to request the next page of results.
    ///
    /// If you specify **NextToken**, then
    /// **StartingBlockIndex** is ignored.
    next_token: ?[]const u8 = null,

    /// The ID of the second snapshot to use for the comparison.
    ///
    /// The `SecondSnapshotId` parameter must be specified with a
    /// `FirstSnapshotID` parameter; otherwise, an error occurs.
    second_snapshot_id: []const u8,

    /// The block index from which the comparison should start.
    ///
    /// The list in the response will start from this block index or the next valid
    /// block
    /// index in the snapshots.
    ///
    /// If you specify **NextToken**, then
    /// **StartingBlockIndex** is ignored.
    starting_block_index: ?i32 = null,

    pub const json_field_names = .{
        .first_snapshot_id = "FirstSnapshotId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .second_snapshot_id = "SecondSnapshotId",
        .starting_block_index = "StartingBlockIndex",
    };
};

pub const ListChangedBlocksOutput = struct {
    /// The size of the blocks in the snapshot, in bytes.
    block_size: ?i32 = null,

    /// An array of objects containing information about the changed blocks.
    changed_blocks: ?[]const ChangedBlock = null,

    /// The time when the `BlockToken` expires.
    expiry_time: ?i64 = null,

    /// The token to use to retrieve the next page of results. This value is null
    /// when there
    /// are no more results to return.
    next_token: ?[]const u8 = null,

    /// The size of the volume in GB.
    volume_size: ?i64 = null,

    pub const json_field_names = .{
        .block_size = "BlockSize",
        .changed_blocks = "ChangedBlocks",
        .expiry_time = "ExpiryTime",
        .next_token = "NextToken",
        .volume_size = "VolumeSize",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListChangedBlocksInput, options: CallOptions) !ListChangedBlocksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ebs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChangedBlocksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ebs", "EBS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/snapshots/");
    try path_buf.appendSlice(allocator, input.second_snapshot_id);
    try path_buf.appendSlice(allocator, "/changedblocks");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.first_snapshot_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "firstSnapshotId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "pageToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.starting_block_index) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startingBlockIndex=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChangedBlocksOutput {
    var result: ListChangedBlocksOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListChangedBlocksOutput, body, allocator);
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
