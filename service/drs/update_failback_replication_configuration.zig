const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InternetProtocol = @import("internet_protocol.zig").InternetProtocol;

pub const UpdateFailbackReplicationConfigurationInput = struct {
    /// Configure bandwidth throttling for the outbound data transfer rate of the
    /// Recovery Instance in Mbps.
    bandwidth_throttling: ?i64 = null,

    /// Which version of the Internet Protocol to use for replication of data. (IPv4
    /// or IPv6)
    internet_protocol: ?InternetProtocol = null,

    /// The name of the Failback Replication Configuration.
    name: ?[]const u8 = null,

    /// The ID of the Recovery Instance.
    recovery_instance_id: []const u8,

    /// Whether to use Private IP for the failback replication of the Recovery
    /// Instance.
    use_private_ip: ?bool = null,

    pub const json_field_names = .{
        .bandwidth_throttling = "bandwidthThrottling",
        .internet_protocol = "internetProtocol",
        .name = "name",
        .recovery_instance_id = "recoveryInstanceID",
        .use_private_ip = "usePrivateIP",
    };
};

pub const UpdateFailbackReplicationConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFailbackReplicationConfigurationInput, options: CallOptions) !UpdateFailbackReplicationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "drs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFailbackReplicationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateFailbackReplicationConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bandwidth_throttling) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"bandwidthThrottling\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.internet_protocol) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"internetProtocol\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"recoveryInstanceID\":");
    try aws.json.writeValue(@TypeOf(input.recovery_instance_id), input.recovery_instance_id, allocator, &body_buf);
    has_prev = true;
    if (input.use_private_ip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"usePrivateIP\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFailbackReplicationConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateFailbackReplicationConfigurationOutput = .{};

    return result;
}
