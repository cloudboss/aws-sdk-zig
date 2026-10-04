const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EgressAccessLogs = @import("egress_access_logs.zig").EgressAccessLogs;
const HlsIngest = @import("hls_ingest.zig").HlsIngest;
const IngressAccessLogs = @import("ingress_access_logs.zig").IngressAccessLogs;

pub const RotateIngestEndpointCredentialsInput = struct {
    /// The ID of the channel the IngestEndpoint is on.
    id: []const u8,

    /// The id of the IngestEndpoint whose credentials should be rotated
    ingest_endpoint_id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .ingest_endpoint_id = "IngestEndpointId",
    };
};

pub const RotateIngestEndpointCredentialsOutput = struct {
    /// The Amazon Resource Name (ARN) assigned to the Channel.
    arn: ?[]const u8 = null,

    /// The date and time the Channel was created.
    created_at: ?[]const u8 = null,

    /// A short text description of the Channel.
    description: ?[]const u8 = null,

    egress_access_logs: ?EgressAccessLogs = null,

    hls_ingest: ?HlsIngest = null,

    /// The ID of the Channel.
    id: ?[]const u8 = null,

    ingress_access_logs: ?IngressAccessLogs = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .egress_access_logs = "EgressAccessLogs",
        .hls_ingest = "HlsIngest",
        .id = "Id",
        .ingress_access_logs = "IngressAccessLogs",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RotateIngestEndpointCredentialsInput, options: CallOptions) !RotateIngestEndpointCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackage", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RotateIngestEndpointCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackage", "MediaPackage", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/ingest_endpoints/");
    try path_buf.appendSlice(allocator, input.ingest_endpoint_id);
    try path_buf.appendSlice(allocator, "/credentials");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RotateIngestEndpointCredentialsOutput {
    var result: RotateIngestEndpointCredentialsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RotateIngestEndpointCredentialsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
