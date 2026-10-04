const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceSummary = @import("device_summary.zig").DeviceSummary;

pub const ListDevicesInput = struct {
    /// Filter for fleets containing this name in their device fleet name.
    device_fleet_name: ?[]const u8 = null,

    /// Select fleets where the job was updated after X
    latest_heartbeat_after: ?i64 = null,

    /// Maximum number of results to select.
    max_results: ?i32 = null,

    /// A filter that searches devices that contains this name in any of their
    /// models.
    model_name: ?[]const u8 = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_fleet_name = "DeviceFleetName",
        .latest_heartbeat_after = "LatestHeartbeatAfter",
        .max_results = "MaxResults",
        .model_name = "ModelName",
        .next_token = "NextToken",
    };
};

pub const ListDevicesOutput = struct {
    /// Summary of devices.
    device_summaries: ?[]const DeviceSummary = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_summaries = "DeviceSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDevicesInput, options: CallOptions) !ListDevicesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDevicesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListDevices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDevicesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListDevicesOutput, body, allocator);
}
