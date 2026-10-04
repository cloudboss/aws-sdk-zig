const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentVersion = @import("agent_version.zig").AgentVersion;
const DeviceStats = @import("device_stats.zig").DeviceStats;
const EdgeModelStat = @import("edge_model_stat.zig").EdgeModelStat;
const EdgeOutputConfig = @import("edge_output_config.zig").EdgeOutputConfig;

pub const GetDeviceFleetReportInput = struct {
    /// The name of the fleet.
    device_fleet_name: []const u8,

    pub const json_field_names = .{
        .device_fleet_name = "DeviceFleetName",
    };
};

pub const GetDeviceFleetReportOutput = struct {
    /// The versions of Edge Manager agent deployed on the fleet.
    agent_versions: ?[]const AgentVersion = null,

    /// Description of the fleet.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the device.
    device_fleet_arn: []const u8,

    /// The name of the fleet.
    device_fleet_name: []const u8,

    /// Status of devices.
    device_stats: ?DeviceStats = null,

    /// Status of model on device.
    model_stats: ?[]const EdgeModelStat = null,

    /// The output configuration for storing sample data collected by the fleet.
    output_config: ?EdgeOutputConfig = null,

    /// Timestamp of when the report was generated.
    report_generated: ?i64 = null,

    pub const json_field_names = .{
        .agent_versions = "AgentVersions",
        .description = "Description",
        .device_fleet_arn = "DeviceFleetArn",
        .device_fleet_name = "DeviceFleetName",
        .device_stats = "DeviceStats",
        .model_stats = "ModelStats",
        .output_config = "OutputConfig",
        .report_generated = "ReportGenerated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeviceFleetReportInput, options: CallOptions) !GetDeviceFleetReportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeviceFleetReportInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.GetDeviceFleetReport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeviceFleetReportOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDeviceFleetReportOutput, body, allocator);
}
