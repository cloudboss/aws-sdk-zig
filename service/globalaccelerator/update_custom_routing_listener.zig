const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PortRange = @import("port_range.zig").PortRange;
const CustomRoutingListener = @import("custom_routing_listener.zig").CustomRoutingListener;

pub const UpdateCustomRoutingListenerInput = struct {
    /// The Amazon Resource Name (ARN) of the listener to update.
    listener_arn: []const u8,

    /// The updated port range to support for connections from clients to your
    /// accelerator. If you remove ports that are
    /// currently being used by a subnet endpoint, the call fails.
    ///
    /// Separately, you set port ranges for endpoints. For more information, see
    /// [About
    /// endpoints for custom routing
    /// accelerators](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-custom-routing-endpoints.html).
    port_ranges: []const PortRange,

    pub const json_field_names = .{
        .listener_arn = "ListenerArn",
        .port_ranges = "PortRanges",
    };
};

pub const UpdateCustomRoutingListenerOutput = struct {
    /// Information for the updated listener for a custom routing accelerator.
    listener: ?CustomRoutingListener = null,

    pub const json_field_names = .{
        .listener = "Listener",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCustomRoutingListenerInput, options: CallOptions) !UpdateCustomRoutingListenerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCustomRoutingListenerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.UpdateCustomRoutingListener");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCustomRoutingListenerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCustomRoutingListenerOutput, body, allocator);
}
