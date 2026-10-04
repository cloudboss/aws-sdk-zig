const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Snapshot = @import("snapshot.zig").Snapshot;

pub const DescribeSnapshotsInput = struct {
    /// A user-supplied cluster identifier. If this parameter is specified, only
    /// snapshots associated with that specific cluster are described.
    cluster_name: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified MaxResults value, a token is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// An optional argument to pass in case the total number of records exceeds the
    /// value of MaxResults. If nextToken is returned, there are more results
    /// available. The value of nextToken is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged.
    next_token: ?[]const u8 = null,

    /// A Boolean value which if true, the shard configuration is included in the
    /// snapshot description.
    show_detail: ?bool = null,

    /// A user-supplied name of the snapshot. If this parameter is specified, only
    /// this named snapshot is described.
    snapshot_name: ?[]const u8 = null,

    /// If set to system, the output shows snapshots that were automatically created
    /// by MemoryDB. If set to user the output shows snapshots that were manually
    /// created. If omitted, the output shows both automatically and manually
    /// created snapshots.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .show_detail = "ShowDetail",
        .snapshot_name = "SnapshotName",
        .source = "Source",
    };
};

pub const DescribeSnapshotsOutput = struct {
    /// An optional argument to pass in case the total number of records exceeds the
    /// value of MaxResults. If nextToken is returned, there are more results
    /// available. The value of nextToken is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged.
    next_token: ?[]const u8 = null,

    /// A list of snapshots. Each item in the list contains detailed information
    /// about one snapshot.
    snapshots: ?[]const Snapshot = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .snapshots = "Snapshots",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSnapshotsInput, options: CallOptions) !DescribeSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.DescribeSnapshots");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSnapshotsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSnapshotsOutput, body, allocator);
}
