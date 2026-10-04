const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotFilter = @import("snapshot_filter.zig").SnapshotFilter;
const Snapshot = @import("snapshot.zig").Snapshot;

pub const DescribeSnapshotsInput = struct {
    /// The filters structure. The supported names are `file-system-id` or
    /// `volume-id`.
    filters: ?[]const SnapshotFilter = null,

    /// Set to `false` (default) if you want to only see the snapshots owned by your
    /// Amazon Web Services account. Set to `true` if you want to see the
    /// snapshots in your account and the ones shared with you from another account.
    include_shared: ?bool = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// The IDs of the snapshots that you want to retrieve. This parameter value
    /// overrides any
    /// filters. If any IDs aren't found, a `SnapshotNotFound` error occurs.
    snapshot_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .include_shared = "IncludeShared",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .snapshot_ids = "SnapshotIds",
    };
};

pub const DescribeSnapshotsOutput = struct {
    next_token: ?[]const u8 = null,

    /// An array of snapshots.
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DescribeSnapshots");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSnapshotsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSnapshotsOutput, body, allocator);
}
