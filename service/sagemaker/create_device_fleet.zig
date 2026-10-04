const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdgeOutputConfig = @import("edge_output_config.zig").EdgeOutputConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateDeviceFleetInput = struct {
    /// A description of the fleet.
    description: ?[]const u8 = null,

    /// The name of the fleet that the device belongs to.
    device_fleet_name: []const u8,

    /// Whether to create an Amazon Web Services IoT Role Alias during device fleet
    /// creation. The name of the role alias generated will match this pattern:
    /// "SageMakerEdge-{DeviceFleetName}".
    ///
    /// For example, if your device fleet is called "demo-fleet", the name of the
    /// role alias will be "SageMakerEdge-demo-fleet".
    enable_iot_role_alias: ?bool = null,

    /// The output configuration for storing sample data collected by the fleet.
    output_config: EdgeOutputConfig,

    /// The Amazon Resource Name (ARN) that has access to Amazon Web Services
    /// Internet of Things (IoT).
    role_arn: ?[]const u8 = null,

    /// Creates tags for the specified fleet.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .device_fleet_name = "DeviceFleetName",
        .enable_iot_role_alias = "EnableIotRoleAlias",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateDeviceFleetOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeviceFleetInput, options: CallOptions) !CreateDeviceFleetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeviceFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateDeviceFleet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeviceFleetOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
