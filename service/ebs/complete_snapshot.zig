const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChecksumAggregationMethod = @import("checksum_aggregation_method.zig").ChecksumAggregationMethod;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const Status = @import("status.zig").Status;

pub const CompleteSnapshotInput = struct {
    /// The number of blocks that were written to the snapshot.
    changed_blocks_count: i32,

    /// An aggregated Base-64 SHA256 checksum based on the checksums of each written
    /// block.
    ///
    /// To generate the aggregated checksum using the linear aggregation method,
    /// arrange the
    /// checksums for each written block in ascending order of their block index,
    /// concatenate
    /// them to form a single string, and then generate the checksum on the entire
    /// string using
    /// the SHA256 algorithm.
    checksum: ?[]const u8 = null,

    /// The aggregation method used to generate the checksum. Currently, the only
    /// supported
    /// aggregation method is `LINEAR`.
    checksum_aggregation_method: ?ChecksumAggregationMethod = null,

    /// The algorithm used to generate the checksum. Currently, the only supported
    /// algorithm
    /// is `SHA256`.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The ID of the snapshot.
    snapshot_id: []const u8,

    pub const json_field_names = .{
        .changed_blocks_count = "ChangedBlocksCount",
        .checksum = "Checksum",
        .checksum_aggregation_method = "ChecksumAggregationMethod",
        .checksum_algorithm = "ChecksumAlgorithm",
        .snapshot_id = "SnapshotId",
    };
};

pub const CompleteSnapshotOutput = struct {
    /// The status of the snapshot.
    status: ?Status = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompleteSnapshotInput, options: CallOptions) !CompleteSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CompleteSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ebs", "EBS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/snapshots/completion/");
    try path_buf.appendSlice(allocator, input.snapshot_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.changed_blocks_count}) catch "";
        try request.headers.put(allocator, "x-amz-ChangedBlocksCount", num_str);
    }
    if (input.checksum) |v| {
        try request.headers.put(allocator, "x-amz-Checksum", v);
    }
    if (input.checksum_aggregation_method) |v| {
        try request.headers.put(allocator, "x-amz-Checksum-Aggregation-Method", v.wireName());
    }
    if (input.checksum_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-Checksum-Algorithm", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompleteSnapshotOutput {
    const result: CompleteSnapshotOutput = try aws.json.parseJsonObject(
        CompleteSnapshotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
