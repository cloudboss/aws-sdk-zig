const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddressFamily = @import("address_family.zig").AddressFamily;
const Protocol = @import("protocol.zig").Protocol;
const ProbeState = @import("probe_state.zig").ProbeState;

pub const GetProbeInput = struct {
    /// The name of the monitor associated with the probe. Run `ListMonitors` to get
    /// a list of monitor names.
    monitor_name: []const u8,

    /// The ID of the probe to get information about. Run `GetMonitor` action to get
    /// a list of probes and probe IDs for the monitor.
    probe_id: []const u8,

    pub const json_field_names = .{
        .monitor_name = "monitorName",
        .probe_id = "probeId",
    };
};

pub const GetProbeOutput = struct {
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

    /// The time and date that the probe was last modified.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProbeInput, options: CallOptions) !GetProbeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProbeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmonitor", "NetworkMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    try path_buf.appendSlice(allocator, "/probes/");
    try path_buf.appendSlice(allocator, input.probe_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProbeOutput {
    const result: GetProbeOutput = try aws.json.parseJsonObject(
        GetProbeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
