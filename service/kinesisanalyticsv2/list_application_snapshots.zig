const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotDetails = @import("snapshot_details.zig").SnapshotDetails;

pub const ListApplicationSnapshotsInput = struct {
    /// The name of an existing application.
    application_name: []const u8,

    /// The maximum number of application snapshots to list.
    limit: ?i32 = null,

    /// Use this parameter if you receive a `NextToken` response in a previous
    /// request that indicates that there is more
    /// output available. Set it to the value of the previous call's `NextToken`
    /// response to indicate where the output should
    /// continue from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const ListApplicationSnapshotsOutput = struct {
    /// The token for the next set of results, or `null` if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    /// A collection of objects containing information about the application
    /// snapshots.
    snapshot_summaries: ?[]const SnapshotDetails = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .snapshot_summaries = "SnapshotSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApplicationSnapshotsInput, options: CallOptions) !ListApplicationSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisanalytics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApplicationSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.ListApplicationSnapshots");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApplicationSnapshotsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListApplicationSnapshotsOutput, body, allocator);
}
