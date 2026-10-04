const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceGroupConfig = @import("instance_group_config.zig").InstanceGroupConfig;

pub const AddInstanceGroupsInput = struct {
    /// Instance groups to add.
    instance_groups: []const InstanceGroupConfig,

    /// Job flow in which to add the instance groups.
    job_flow_id: []const u8,

    pub const json_field_names = .{
        .instance_groups = "InstanceGroups",
        .job_flow_id = "JobFlowId",
    };
};

pub const AddInstanceGroupsOutput = struct {
    /// The Amazon Resource Name of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// Instance group IDs of the newly created instance groups.
    instance_group_ids: ?[]const []const u8 = null,

    /// The job flow ID in which the instance groups are added.
    job_flow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .instance_group_ids = "InstanceGroupIds",
        .job_flow_id = "JobFlowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddInstanceGroupsInput, options: CallOptions) !AddInstanceGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddInstanceGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.AddInstanceGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddInstanceGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddInstanceGroupsOutput, body, allocator);
}
