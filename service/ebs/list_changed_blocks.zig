const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ebs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChangedBlocksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ebs", "EBS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/snapshots/");
    try path_buf.appendSlice(allocator, input.second_snapshot_id);
    try path_buf.appendSlice(allocator, "/changedblocks");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChangedBlocksOutput {
    const result: ListChangedBlocksOutput = try aws.json.parseJsonObject(
        ListChangedBlocksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
