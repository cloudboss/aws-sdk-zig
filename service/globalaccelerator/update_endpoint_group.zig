const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const HealthCheckProtocol = @import("health_check_protocol.zig").HealthCheckProtocol;
const PortOverride = @import("port_override.zig").PortOverride;
const EndpointGroup = @import("endpoint_group.zig").EndpointGroup;

pub const UpdateEndpointGroupInput = struct {
    /// The list of endpoint objects. A resource must be valid and active when you
    /// add it as an endpoint.
    endpoint_configurations: ?[]const EndpointConfiguration = null,

    /// The Amazon Resource Name (ARN) of the endpoint group.
    endpoint_group_arn: []const u8,

    /// The time—10 seconds or 30 seconds—between each health check for an endpoint.
    /// The default value is 30.
    health_check_interval_seconds: ?i32 = null,

    /// If the protocol is HTTP/S, then this specifies the path that is the
    /// destination for health check targets. The
    /// default value is slash (/).
    health_check_path: ?[]const u8 = null,

    /// The port that Global Accelerator uses to check the health of endpoints that
    /// are part of this endpoint group. The default port
    /// is the listener port that this endpoint group is associated with. If the
    /// listener port is a list of ports, Global Accelerator uses
    /// the first port in the list.
    health_check_port: ?i32 = null,

    /// The protocol that Global Accelerator uses to check the health of endpoints
    /// that are part of this endpoint group. The default
    /// value is TCP.
    health_check_protocol: ?HealthCheckProtocol = null,

    /// Override specific listener ports used to route traffic to endpoints that are
    /// part of this endpoint group.
    /// For example, you can create a port override in which the listener
    /// receives user traffic on ports 80 and 443, but your accelerator routes that
    /// traffic to ports 1080
    /// and 1443, respectively, on the endpoints.
    ///
    /// For more information, see [
    /// Overriding listener
    /// ports](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-endpoint-groups-port-override.html) in the *Global Accelerator Developer Guide*.
    port_overrides: ?[]const PortOverride = null,

    /// The number of consecutive health checks required to set the state of a
    /// healthy endpoint to unhealthy, or to set an
    /// unhealthy endpoint to healthy. The default value is 3.
    threshold_count: ?i32 = null,

    /// The percentage of traffic to send to an Amazon Web Services Region.
    /// Additional traffic is distributed to other endpoint groups for
    /// this listener.
    ///
    /// Use this action to increase (dial up) or decrease (dial down) traffic to a
    /// specific Region. The percentage is
    /// applied to the traffic that would otherwise have been routed to the Region
    /// based on optimal routing.
    ///
    /// The default value is 100.
    traffic_dial_percentage: ?f32 = null,

    pub const json_field_names = .{
        .endpoint_configurations = "EndpointConfigurations",
        .endpoint_group_arn = "EndpointGroupArn",
        .health_check_interval_seconds = "HealthCheckIntervalSeconds",
        .health_check_path = "HealthCheckPath",
        .health_check_port = "HealthCheckPort",
        .health_check_protocol = "HealthCheckProtocol",
        .port_overrides = "PortOverrides",
        .threshold_count = "ThresholdCount",
        .traffic_dial_percentage = "TrafficDialPercentage",
    };
};

pub const UpdateEndpointGroupOutput = struct {
    /// The information about the endpoint group that was updated.
    endpoint_group: ?EndpointGroup = null,

    pub const json_field_names = .{
        .endpoint_group = "EndpointGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEndpointGroupInput, options: CallOptions) !UpdateEndpointGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEndpointGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.UpdateEndpointGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEndpointGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEndpointGroupOutput, body, allocator);
}
