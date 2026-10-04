const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceDeploymentSummary = @import("device_deployment_summary.zig").DeviceDeploymentSummary;

pub const ListStageDevicesInput = struct {
    /// The name of the edge deployment plan.
    edge_deployment_plan_name: []const u8,

    /// Toggle for excluding devices deployed in other stages.
    exclude_devices_deployed_in_other_stage: ?bool = null,

    /// The maximum number of requests to select.
    max_results: ?i32 = null,

    /// The response from the last list when returning a list large enough to neeed
    /// tokening.
    next_token: ?[]const u8 = null,

    /// The name of the stage in the deployment.
    stage_name: []const u8,

    pub const json_field_names = .{
        .edge_deployment_plan_name = "EdgeDeploymentPlanName",
        .exclude_devices_deployed_in_other_stage = "ExcludeDevicesDeployedInOtherStage",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .stage_name = "StageName",
    };
};

pub const ListStageDevicesOutput = struct {
    /// List of summaries of devices allocated to the stage.
    device_deployment_summaries: ?[]const DeviceDeploymentSummary = null,

    /// The token to use when calling the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_deployment_summaries = "DeviceDeploymentSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStageDevicesInput, options: CallOptions) !ListStageDevicesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStageDevicesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListStageDevices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStageDevicesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListStageDevicesOutput, body, allocator);
}
