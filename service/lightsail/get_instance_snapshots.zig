const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceSnapshot = @import("instance_snapshot.zig").InstanceSnapshot;

pub const GetInstanceSnapshotsInput = struct {
    /// The token to advance to the next page of results from your request.
    ///
    /// To get a page token, perform an initial `GetInstanceSnapshots` request. If
    /// your
    /// results are paginated, the response will return a next page token that you
    /// can specify as the
    /// page token in a subsequent request.
    page_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .page_token = "pageToken",
    };
};

pub const GetInstanceSnapshotsOutput = struct {
    /// An array of key-value pairs containing information about the results of your
    /// get instance
    /// snapshots request.
    instance_snapshots: ?[]const InstanceSnapshot = null,

    /// The token to advance to the next page of results from your request.
    ///
    /// A next page token is not returned if there are no more results to display.
    ///
    /// To get the next page of results, perform another `GetInstanceSnapshots`
    /// request
    /// and specify the next page token using the `pageToken` parameter.
    next_page_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_snapshots = "instanceSnapshots",
        .next_page_token = "nextPageToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstanceSnapshotsInput, options: CallOptions) !GetInstanceSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInstanceSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetInstanceSnapshots");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInstanceSnapshotsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInstanceSnapshotsOutput, body, allocator);
}
