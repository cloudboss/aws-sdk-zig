const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Protocol = @import("protocol.zig").Protocol;
const ProbeState = @import("probe_state.zig").ProbeState;
const AddressFamily = @import("address_family.zig").AddressFamily;

pub const UpdateProbeInput = struct {
    /// The updated IP address for the probe destination. This must be either an
    /// IPv4 or IPv6 address.
    destination: ?[]const u8 = null,

    /// The updated port for the probe destination. This is required only if the
    /// `protocol` is `TCP` and must be a number between `1` and `65536`.
    destination_port: ?i32 = null,

    /// The name of the monitor that the probe was updated for.
    monitor_name: []const u8,

    /// he updated packets size for network traffic between the source and
    /// destination. This must be a number between `56` and `8500`.
    packet_size: ?i32 = null,

    /// The ID of the probe to update.
    probe_id: []const u8,

    /// The updated network protocol for the destination. This can be either `TCP`
    /// or `ICMP`. If the protocol is `TCP`, then `port` is also required.
    protocol: ?Protocol = null,

    /// The state of the probe update.
    state: ?ProbeState = null,

    pub const json_field_names = .{
        .destination = "destination",
        .destination_port = "destinationPort",
        .monitor_name = "monitorName",
        .packet_size = "packetSize",
        .probe_id = "probeId",
        .protocol = "protocol",
        .state = "state",
    };
};

pub const UpdateProbeOutput = struct {
    /// The updated IP address family. This must be either `IPV4` or `IPV6`.
    address_family: ?AddressFamily = null,

    /// The time and date that the probe was created.
    created_at: ?i64 = null,

    /// The updated destination IP address for the probe.
    destination: []const u8,

    /// The updated destination port. This must be a number between `1` and `65536`.
    destination_port: ?i32 = null,

    /// The time and date that the probe was last updated.
    modified_at: ?i64 = null,

    /// The updated packet size for the probe.
    packet_size: ?i32 = null,

    /// The updated ARN of the probe.
    probe_arn: ?[]const u8 = null,

    /// The updated ID of the probe.
    probe_id: ?[]const u8 = null,

    /// The updated protocol for the probe.
    protocol: Protocol,

    /// The updated ARN of the source subnet.
    source_arn: []const u8,

    /// The state of the updated probe.
    state: ?ProbeState = null,

    /// Update tags for a probe.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The updated ID of the source VPC subnet ID.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .address_family = "addressFamily",
        .created_at = "createdAt",
        .destination = "destination",
        .destination_port = "destinationPort",
        .modified_at = "modifiedAt",
        .packet_size = "packetSize",
        .probe_arn = "probeArn",
        .probe_id = "probeId",
        .protocol = "protocol",
        .source_arn = "sourceArn",
        .state = "state",
        .tags = "tags",
        .vpc_id = "vpcId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProbeInput, options: Options) !UpdateProbeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "networkmonitor");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateProbeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmonitor", "NetworkMonitor", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/monitors/");
    try path_buf.appendSlice(alloc, input.monitor_name);
    try path_buf.appendSlice(alloc, "/probes/");
    try path_buf.appendSlice(alloc, input.probe_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.destination) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"destination\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.destination_port) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"destinationPort\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.packet_size) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"packetSize\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.protocol) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"protocol\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"state\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateProbeOutput {
    var result: UpdateProbeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateProbeOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
