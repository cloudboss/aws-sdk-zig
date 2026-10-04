const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionTypeId = @import("action_type_id.zig").ActionTypeId;
const ThirdPartyJob = @import("third_party_job.zig").ThirdPartyJob;

pub const PollForThirdPartyJobsInput = struct {
    /// Represents information about an action type.
    action_type_id: ActionTypeId,

    /// The maximum number of jobs to return in a poll for jobs call.
    max_batch_size: ?i32 = null,

    pub const json_field_names = .{
        .action_type_id = "actionTypeId",
        .max_batch_size = "maxBatchSize",
    };
};

pub const PollForThirdPartyJobsOutput = struct {
    /// Information about the jobs to take action on.
    jobs: ?[]const ThirdPartyJob = null,

    pub const json_field_names = .{
        .jobs = "jobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PollForThirdPartyJobsInput, options: CallOptions) !PollForThirdPartyJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PollForThirdPartyJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.PollForThirdPartyJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PollForThirdPartyJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PollForThirdPartyJobsOutput, body, allocator);
}
