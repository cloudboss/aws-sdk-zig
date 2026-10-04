const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskSetField = @import("task_set_field.zig").TaskSetField;
const Failure = @import("failure.zig").Failure;
const TaskSet = @import("task_set.zig").TaskSet;

pub const DescribeTaskSetsInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the service that the task sets exist in.
    cluster: []const u8,

    /// Specifies whether to see the resource tags for the task set. If `TAGS` is
    /// specified, the tags are included in the response. If this field is omitted,
    /// tags aren't included in the response.
    include: ?[]const TaskSetField = null,

    /// The short name or full Amazon Resource Name (ARN) of the service that the
    /// task sets exist in.
    service: []const u8,

    /// The ID or full Amazon Resource Name (ARN) of task sets to describe.
    task_sets: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .include = "include",
        .service = "service",
        .task_sets = "taskSets",
    };
};

pub const DescribeTaskSetsOutput = struct {
    /// Any failures associated with the call.
    failures: ?[]const Failure = null,

    /// The list of task sets described.
    task_sets: ?[]const TaskSet = null,

    pub const json_field_names = .{
        .failures = "failures",
        .task_sets = "taskSets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTaskSetsInput, options: CallOptions) !DescribeTaskSetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTaskSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DescribeTaskSets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTaskSetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTaskSetsOutput, body, allocator);
}
