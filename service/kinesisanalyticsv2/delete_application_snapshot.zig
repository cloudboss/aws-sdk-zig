const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteApplicationSnapshotInput = struct {
    /// The name of an existing application.
    application_name: []const u8,

    /// The creation timestamp of the application snapshot to delete. You can
    /// retrieve this value
    /// using
    /// or .
    snapshot_creation_timestamp: i64,

    /// The identifier for the snapshot delete.
    snapshot_name: []const u8,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .snapshot_creation_timestamp = "SnapshotCreationTimestamp",
        .snapshot_name = "SnapshotName",
    };
};

pub const DeleteApplicationSnapshotOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteApplicationSnapshotInput, options: CallOptions) !DeleteApplicationSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteApplicationSnapshotInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.DeleteApplicationSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteApplicationSnapshotOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
