const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomRoutingDestinationConfiguration = @import("custom_routing_destination_configuration.zig").CustomRoutingDestinationConfiguration;
const CustomRoutingEndpointGroup = @import("custom_routing_endpoint_group.zig").CustomRoutingEndpointGroup;

pub const CreateCustomRoutingEndpointGroupInput = struct {
    /// Sets the port range and protocol for all endpoints (virtual private cloud
    /// subnets) in a custom routing endpoint group to accept
    /// client traffic on.
    destination_configurations: []const CustomRoutingDestinationConfiguration,

    /// The Amazon Web Services Region where the endpoint group is located. A
    /// listener can have only one endpoint group in a
    /// specific Region.
    endpoint_group_region: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency—that is, the
    /// uniqueness—of the request.
    idempotency_token: []const u8,

    /// The Amazon Resource Name (ARN) of the listener for a custom routing
    /// endpoint.
    listener_arn: []const u8,

    pub const json_field_names = .{
        .destination_configurations = "DestinationConfigurations",
        .endpoint_group_region = "EndpointGroupRegion",
        .idempotency_token = "IdempotencyToken",
        .listener_arn = "ListenerArn",
    };
};

pub const CreateCustomRoutingEndpointGroupOutput = struct {
    /// The information about the endpoint group created for a custom routing
    /// accelerator.
    endpoint_group: ?CustomRoutingEndpointGroup = null,

    pub const json_field_names = .{
        .endpoint_group = "EndpointGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomRoutingEndpointGroupInput, options: CallOptions) !CreateCustomRoutingEndpointGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomRoutingEndpointGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.CreateCustomRoutingEndpointGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomRoutingEndpointGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCustomRoutingEndpointGroupOutput, body, allocator);
}
