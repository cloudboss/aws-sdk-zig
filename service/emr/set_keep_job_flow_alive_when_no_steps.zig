const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetKeepJobFlowAliveWhenNoStepsInput = struct {
    /// A list of strings that uniquely identify the clusters to protect. This
    /// identifier is returned by
    /// [RunJobFlow](https://docs.aws.amazon.com/emr/latest/APIReference/API_RunJobFlow.html) and can also
    /// be obtained from
    /// [DescribeJobFlows](https://docs.aws.amazon.com/emr/latest/APIReference/API_DescribeJobFlows.html).
    job_flow_ids: []const []const u8,

    /// A Boolean that indicates whether to terminate the cluster after all steps
    /// are executed.
    keep_job_flow_alive_when_no_steps: bool,

    pub const json_field_names = .{
        .job_flow_ids = "JobFlowIds",
        .keep_job_flow_alive_when_no_steps = "KeepJobFlowAliveWhenNoSteps",
    };
};

pub const SetKeepJobFlowAliveWhenNoStepsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetKeepJobFlowAliveWhenNoStepsInput, options: CallOptions) !SetKeepJobFlowAliveWhenNoStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetKeepJobFlowAliveWhenNoStepsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.SetKeepJobFlowAliveWhenNoSteps");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetKeepJobFlowAliveWhenNoStepsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
