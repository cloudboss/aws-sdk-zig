const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionTypeId = @import("action_type_id.zig").ActionTypeId;
const Job = @import("job.zig").Job;

pub const PollForJobsInput = struct {
    /// Represents information about an action type.
    action_type_id: ActionTypeId,

    /// The maximum number of jobs to return in a poll for jobs call.
    max_batch_size: ?i32 = null,

    /// A map of property names and values. For an action type with no queryable
    /// properties, this value must be null or an empty map. For an action type with
    /// a queryable
    /// property, you must supply that property as a key in the map. Only jobs whose
    /// action
    /// configuration matches the mapped value are returned.
    query_param: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action_type_id = "actionTypeId",
        .max_batch_size = "maxBatchSize",
        .query_param = "queryParam",
    };
};

pub const PollForJobsOutput = struct {
    /// Information about the jobs to take action on.
    jobs: ?[]const Job = null,

    pub const json_field_names = .{
        .jobs = "jobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PollForJobsInput, options: CallOptions) !PollForJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PollForJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.PollForJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PollForJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PollForJobsOutput, body, allocator);
}
