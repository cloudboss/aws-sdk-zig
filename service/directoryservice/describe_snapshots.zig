const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Snapshot = @import("snapshot.zig").Snapshot;

pub const DescribeSnapshotsInput = struct {
    /// The identifier of the directory for which to retrieve snapshot information.
    directory_id: ?[]const u8 = null,

    /// The maximum number of objects to return.
    limit: ?i32 = null,

    /// The *DescribeSnapshotsResult.NextToken* value from a previous call to
    /// DescribeSnapshots. Pass null if this is the first call.
    next_token: ?[]const u8 = null,

    /// A list of identifiers of the snapshots to obtain the information for. If
    /// this member is
    /// null or empty, all snapshots are returned using the *Limit* and *NextToken*
    /// members.
    snapshot_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .limit = "Limit",
        .next_token = "NextToken",
        .snapshot_ids = "SnapshotIds",
    };
};

pub const DescribeSnapshotsOutput = struct {
    /// If not null, more results are available. Pass this value in the *NextToken*
    /// member of
    /// a subsequent call to DescribeSnapshots.
    next_token: ?[]const u8 = null,

    /// The list of Snapshot objects that were retrieved.
    ///
    /// It is possible that this list contains less than the number of items
    /// specified in the
    /// *Limit* member of the request. This occurs if there are less than the
    /// requested
    /// number of items left to retrieve, or if the limitations of the operation
    /// have been
    /// exceeded.
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeSnapshots");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSnapshotsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSnapshotsOutput, body, allocator);
}
