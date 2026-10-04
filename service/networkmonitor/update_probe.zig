const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProbeInput, options: CallOptions) !UpdateProbeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmonitor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProbeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmonitor", "NetworkMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    try path_buf.appendSlice(allocator, "/probes/");
    try path_buf.appendSlice(allocator, input.probe_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"destination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination_port) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"destinationPort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.packet_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"packetSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.protocol) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"protocol\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"state\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProbeOutput {
    var result: UpdateProbeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateProbeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
