const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputePlatform = @import("compute_platform.zig").ComputePlatform;
const MinimumHealthyHosts = @import("minimum_healthy_hosts.zig").MinimumHealthyHosts;
const TrafficRoutingConfig = @import("traffic_routing_config.zig").TrafficRoutingConfig;
const ZonalConfig = @import("zonal_config.zig").ZonalConfig;

pub const CreateDeploymentConfigInput = struct {
    /// The destination platform type for the deployment (`Lambda`,
    /// `Server`, or `ECS`).
    compute_platform: ?ComputePlatform = null,

    /// The name of the deployment configuration to create.
    deployment_config_name: []const u8,

    /// The minimum number of healthy instances that should be available at any time
    /// during
    /// the deployment. There are two parameters expected in the input: type and
    /// value.
    ///
    /// The type parameter takes either of the following values:
    ///
    /// * HOST_COUNT: The value parameter represents the minimum number of healthy
    /// instances as an absolute value.
    ///
    /// * FLEET_PERCENT: The value parameter represents the minimum number of
    ///   healthy
    /// instances as a percentage of the total number of instances in the
    /// deployment. If
    /// you specify FLEET_PERCENT, at the start of the deployment, CodeDeploy
    /// converts the percentage to the equivalent number of instances and rounds up
    /// fractional instances.
    ///
    /// The value parameter takes an integer.
    ///
    /// For example, to set a minimum of 95% healthy instance, specify a type of
    /// FLEET_PERCENT
    /// and a value of 95.
    minimum_healthy_hosts: ?MinimumHealthyHosts = null,

    /// The configuration that specifies how the deployment traffic is routed.
    traffic_routing_config: ?TrafficRoutingConfig = null,

    /// Configure the `ZonalConfig` object if you want CodeDeploy to
    /// deploy your application to one [Availability
    /// Zone](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-availability-zones) at a time, within an Amazon Web Services Region.
    ///
    /// For more information about the zonal configuration feature, see [zonal
    /// configuration](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations-create.html#zonal-config) in the *CodeDeploy User
    /// Guide*.
    zonal_config: ?ZonalConfig = null,

    pub const json_field_names = .{
        .compute_platform = "computePlatform",
        .deployment_config_name = "deploymentConfigName",
        .minimum_healthy_hosts = "minimumHealthyHosts",
        .traffic_routing_config = "trafficRoutingConfig",
        .zonal_config = "zonalConfig",
    };
};

pub const CreateDeploymentConfigOutput = struct {
    /// A unique deployment configuration ID.
    deployment_config_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_config_id = "deploymentConfigId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentConfigInput, options: CallOptions) !CreateDeploymentConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.CreateDeploymentConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDeploymentConfigOutput, body, allocator);
}
