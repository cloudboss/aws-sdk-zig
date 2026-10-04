const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchedulerConfig = @import("scheduler_config.zig").SchedulerConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateClusterSchedulerConfigInput = struct {
    /// ARN of the cluster.
    cluster_arn: []const u8,

    /// Description of the cluster policy.
    description: ?[]const u8 = null,

    /// Name for the cluster policy.
    name: []const u8,

    /// Configuration about the monitoring schedule.
    scheduler_config: SchedulerConfig,

    /// Tags of the cluster policy.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .description = "Description",
        .name = "Name",
        .scheduler_config = "SchedulerConfig",
        .tags = "Tags",
    };
};

pub const CreateClusterSchedulerConfigOutput = struct {
    /// ARN of the cluster policy.
    cluster_scheduler_config_arn: []const u8,

    /// ID of the cluster policy.
    cluster_scheduler_config_id: []const u8,

    pub const json_field_names = .{
        .cluster_scheduler_config_arn = "ClusterSchedulerConfigArn",
        .cluster_scheduler_config_id = "ClusterSchedulerConfigId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterSchedulerConfigInput, options: CallOptions) !CreateClusterSchedulerConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterSchedulerConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateClusterSchedulerConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterSchedulerConfigOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateClusterSchedulerConfigOutput, body, allocator);
}
