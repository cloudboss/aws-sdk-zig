const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdgeOutputConfig = @import("edge_output_config.zig").EdgeOutputConfig;

pub const DescribeDeviceFleetInput = struct {
    /// The name of the fleet.
    device_fleet_name: []const u8,

    pub const json_field_names = .{
        .device_fleet_name = "DeviceFleetName",
    };
};

pub const DescribeDeviceFleetOutput = struct {
    /// Timestamp of when the device fleet was created.
    creation_time: i64,

    /// A description of the fleet.
    description: ?[]const u8 = null,

    /// The The Amazon Resource Name (ARN) of the fleet.
    device_fleet_arn: []const u8,

    /// The name of the fleet.
    device_fleet_name: []const u8,

    /// The Amazon Resource Name (ARN) alias created in Amazon Web Services Internet
    /// of Things (IoT).
    iot_role_alias: ?[]const u8 = null,

    /// Timestamp of when the device fleet was last updated.
    last_modified_time: i64,

    /// The output configuration for storing sampled data.
    output_config: ?EdgeOutputConfig = null,

    /// The Amazon Resource Name (ARN) that has access to Amazon Web Services
    /// Internet of Things (IoT).
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .device_fleet_arn = "DeviceFleetArn",
        .device_fleet_name = "DeviceFleetName",
        .iot_role_alias = "IotRoleAlias",
        .last_modified_time = "LastModifiedTime",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeviceFleetInput, options: CallOptions) !DescribeDeviceFleetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDeviceFleetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeDeviceFleet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDeviceFleetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeDeviceFleetOutput, body, allocator);
}
