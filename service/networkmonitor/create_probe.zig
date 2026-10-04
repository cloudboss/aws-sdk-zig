const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProbeInput = @import("probe_input.zig").ProbeInput;
const AddressFamily = @import("address_family.zig").AddressFamily;
const Protocol = @import("protocol.zig").Protocol;
const ProbeState = @import("probe_state.zig").ProbeState;

pub const CreateProbeInput = struct {
    /// Unique, case-sensitive identifier to ensure the idempotency of the request.
    /// Only returned if a client token was provided in the request.
    client_token: ?[]const u8 = null,

    /// The name of the monitor to associated with the probe.
    monitor_name: []const u8,

    /// Describes the details of an individual probe for a monitor.
    probe: ProbeInput,

    /// The list of key-value pairs created and assigned to the probe.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .monitor_name = "monitorName",
        .probe = "probe",
        .tags = "tags",
    };
};

pub const CreateProbeOutput = struct {
    /// Indicates whether the IP address is `IPV4` or `IPV6`.
    address_family: ?AddressFamily = null,

    /// The time and date that the probe was created.
    created_at: ?i64 = null,

    /// The destination IP address for the monitor. This must be either an IPv4 or
    /// IPv6 address.
    destination: []const u8,

    /// The port associated with the `destination`. This is required only if the
    /// `protocol` is `TCP` and must be a number between `1` and `65536`.
    destination_port: ?i32 = null,

    /// The time and date when the probe was last modified.
    modified_at: ?i64 = null,

    /// The size of the packets sent between the source and destination. This must
    /// be a number between `56` and `8500`.
    packet_size: ?i32 = null,

    /// The ARN of the probe.
    probe_arn: ?[]const u8 = null,

    /// The ID of the probe for which details are returned.
    probe_id: ?[]const u8 = null,

    /// The protocol used for the network traffic between the `source` and
    /// `destination`. This must be either `TCP` or `ICMP`.
    protocol: Protocol,

    /// The ARN of the probe.
    source_arn: []const u8,

    /// The state of the probe.
    state: ?ProbeState = null,

    /// The list of key-value pairs assigned to the probe.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the source VPC or subnet.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProbeInput, options: CallOptions) !CreateProbeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProbeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmonitor", "NetworkMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    try path_buf.appendSlice(allocator, "/probes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"probe\":");
    try aws.json.writeValue(@TypeOf(input.probe), input.probe, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProbeOutput {
    const result: CreateProbeOutput = try aws.json.parseJsonObject(
        CreateProbeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
