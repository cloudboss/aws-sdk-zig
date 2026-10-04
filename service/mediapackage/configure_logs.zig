const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EgressAccessLogs = @import("egress_access_logs.zig").EgressAccessLogs;
const IngressAccessLogs = @import("ingress_access_logs.zig").IngressAccessLogs;
const HlsIngest = @import("hls_ingest.zig").HlsIngest;

pub const ConfigureLogsInput = struct {
    egress_access_logs: ?EgressAccessLogs = null,

    /// The ID of the channel to log subscription.
    id: []const u8,

    ingress_access_logs: ?IngressAccessLogs = null,

    pub const json_field_names = .{
        .egress_access_logs = "EgressAccessLogs",
        .id = "Id",
        .ingress_access_logs = "IngressAccessLogs",
    };
};

pub const ConfigureLogsOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConfigureLogsInput, options: CallOptions) !ConfigureLogsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ConfigureLogsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackage", "MediaPackage", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/configure_logs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.egress_access_logs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EgressAccessLogs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ingress_access_logs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IngressAccessLogs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ConfigureLogsOutput {
    var result: ConfigureLogsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ConfigureLogsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
