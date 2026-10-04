const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientAffinity = @import("client_affinity.zig").ClientAffinity;
const PortRange = @import("port_range.zig").PortRange;
const Protocol = @import("protocol.zig").Protocol;
const Listener = @import("listener.zig").Listener;

pub const UpdateListenerInput = struct {
    /// Client affinity lets you direct all requests from a user to the same
    /// endpoint, if you have stateful applications,
    /// regardless of the port and protocol of the client request. Client affinity
    /// gives you control over whether to always
    /// route each client to the same specific endpoint.
    ///
    /// Global Accelerator uses a consistent-flow hashing algorithm to choose the
    /// optimal endpoint for a connection. If client
    /// affinity is `NONE`, Global Accelerator uses the "five-tuple" (5-tuple)
    /// properties—source IP address, source port,
    /// destination IP address, destination port, and protocol—to select the hash
    /// value, and then chooses the best
    /// endpoint. However, with this setting, if someone uses different ports to
    /// connect to Global Accelerator, their connections might not
    /// be always routed to the same endpoint because the hash value changes.
    ///
    /// If you want a given client to always be routed to the same endpoint, set
    /// client affinity to `SOURCE_IP`
    /// instead. When you use the `SOURCE_IP` setting, Global Accelerator uses the
    /// "two-tuple" (2-tuple) properties—
    /// source (client) IP address and destination IP address—to select the hash
    /// value.
    ///
    /// The default value is `NONE`.
    client_affinity: ?ClientAffinity = null,

    /// The Amazon Resource Name (ARN) of the listener to update.
    listener_arn: []const u8,

    /// The updated list of port ranges for the connections from clients to the
    /// accelerator.
    port_ranges: ?[]const PortRange = null,

    /// The updated protocol for the connections from clients to the accelerator.
    protocol: ?Protocol = null,

    pub const json_field_names = .{
        .client_affinity = "ClientAffinity",
        .listener_arn = "ListenerArn",
        .port_ranges = "PortRanges",
        .protocol = "Protocol",
    };
};

pub const UpdateListenerOutput = struct {
    /// Information for the updated listener.
    listener: ?Listener = null,

    pub const json_field_names = .{
        .listener = "Listener",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateListenerInput, options: CallOptions) !UpdateListenerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "globalaccelerator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateListenerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("globalaccelerator", "Global Accelerator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.UpdateListener");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateListenerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateListenerOutput, body, allocator);
}
