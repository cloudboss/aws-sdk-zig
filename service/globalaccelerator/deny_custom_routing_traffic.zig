const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DenyCustomRoutingTrafficInput = struct {
    /// Indicates whether all destination IP addresses and ports for a specified VPC
    /// subnet endpoint *cannot*
    /// receive traffic from a custom routing accelerator. The value is TRUE or
    /// FALSE.
    ///
    /// When set to TRUE, *no* destinations in the custom routing VPC subnet can
    /// receive traffic. Note
    /// that you cannot specify destination IP addresses and ports when the value is
    /// set to TRUE.
    ///
    /// When set to FALSE (or not specified), you *must* specify a list of
    /// destination IP addresses that cannot receive
    /// traffic. A list of ports is optional. If you don't specify a list of ports,
    /// the ports that can accept traffic is
    /// the same as the ports configured for the endpoint group.
    ///
    /// The default value is FALSE.
    deny_all_traffic_to_endpoint: ?bool = null,

    /// A list of specific Amazon EC2 instance IP addresses (destination addresses)
    /// in a subnet that you want to prevent from receiving
    /// traffic. The IP addresses must be a subset of the IP addresses allowed for
    /// the VPC subnet associated with the
    /// endpoint group.
    destination_addresses: ?[]const []const u8 = null,

    /// A list of specific Amazon EC2 instance ports (destination ports) in a subnet
    /// endpoint that you want to prevent from
    /// receiving traffic.
    destination_ports: ?[]const i32 = null,

    /// The Amazon Resource Name (ARN) of the endpoint group.
    endpoint_group_arn: []const u8,

    /// An ID for the endpoint. For custom routing accelerators, this is the virtual
    /// private cloud (VPC) subnet ID.
    endpoint_id: []const u8,

    pub const json_field_names = .{
        .deny_all_traffic_to_endpoint = "DenyAllTrafficToEndpoint",
        .destination_addresses = "DestinationAddresses",
        .destination_ports = "DestinationPorts",
        .endpoint_group_arn = "EndpointGroupArn",
        .endpoint_id = "EndpointId",
    };
};

pub const DenyCustomRoutingTrafficOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DenyCustomRoutingTrafficInput, options: CallOptions) !DenyCustomRoutingTrafficOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DenyCustomRoutingTrafficInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.DenyCustomRoutingTraffic");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DenyCustomRoutingTrafficOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
