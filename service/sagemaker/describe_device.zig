const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdgeModel = @import("edge_model.zig").EdgeModel;

pub const DescribeDeviceInput = struct {
    /// The name of the fleet the devices belong to.
    device_fleet_name: []const u8,

    /// The unique ID of the device.
    device_name: []const u8,

    /// Next token of device description.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_fleet_name = "DeviceFleetName",
        .device_name = "DeviceName",
        .next_token = "NextToken",
    };
};

pub const DescribeDeviceOutput = struct {
    /// Edge Manager agent version.
    agent_version: ?[]const u8 = null,

    /// A description of the device.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the device.
    device_arn: ?[]const u8 = null,

    /// The name of the fleet the device belongs to.
    device_fleet_name: []const u8,

    /// The unique identifier of the device.
    device_name: []const u8,

    /// The Amazon Web Services Internet of Things (IoT) object thing name
    /// associated with the device.
    iot_thing_name: ?[]const u8 = null,

    /// The last heartbeat received from the device.
    latest_heartbeat: ?i64 = null,

    /// The maximum number of models.
    max_models: ?i32 = null,

    /// Models on the device.
    models: ?[]const EdgeModel = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    /// The timestamp of the last registration or de-reregistration.
    registration_time: i64,

    pub const json_field_names = .{
        .agent_version = "AgentVersion",
        .description = "Description",
        .device_arn = "DeviceArn",
        .device_fleet_name = "DeviceFleetName",
        .device_name = "DeviceName",
        .iot_thing_name = "IotThingName",
        .latest_heartbeat = "LatestHeartbeat",
        .max_models = "MaxModels",
        .models = "Models",
        .next_token = "NextToken",
        .registration_time = "RegistrationTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeviceInput, options: CallOptions) !DescribeDeviceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDeviceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeDevice");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDeviceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeDeviceOutput, body, allocator);
}
