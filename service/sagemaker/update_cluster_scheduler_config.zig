const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchedulerConfig = @import("scheduler_config.zig").SchedulerConfig;

pub const UpdateClusterSchedulerConfigInput = struct {
    /// ID of the cluster policy.
    cluster_scheduler_config_id: []const u8,

    /// Description of the cluster policy.
    description: ?[]const u8 = null,

    /// Cluster policy configuration.
    scheduler_config: ?SchedulerConfig = null,

    /// Target version.
    target_version: i32,

    pub const json_field_names = .{
        .cluster_scheduler_config_id = "ClusterSchedulerConfigId",
        .description = "Description",
        .scheduler_config = "SchedulerConfig",
        .target_version = "TargetVersion",
    };
};

pub const UpdateClusterSchedulerConfigOutput = struct {
    /// ARN of the cluster policy.
    cluster_scheduler_config_arn: []const u8,

    /// Version of the cluster policy.
    cluster_scheduler_config_version: i32,

    pub const json_field_names = .{
        .cluster_scheduler_config_arn = "ClusterSchedulerConfigArn",
        .cluster_scheduler_config_version = "ClusterSchedulerConfigVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterSchedulerConfigInput, options: CallOptions) !UpdateClusterSchedulerConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterSchedulerConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateClusterSchedulerConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterSchedulerConfigOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateClusterSchedulerConfigOutput, body, allocator);
}
