const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SampleInput = struct {
    /// The raw inference request body in OpenAI-compatible JSON format.
    body: []const u8,

    /// The job ARN that identifies which model session
    /// to route the inference request to.
    job_arn: []const u8,

    /// The trajectory ID for grouping turns into a single rollout. Each turn
    /// (prompt and response) is captured for later use.
    trajectory_id: []const u8,

    pub const json_field_names = .{
        .body = "Body",
        .job_arn = "JobArn",
        .trajectory_id = "TrajectoryId",
    };
};

pub const SampleOutput = struct {
    /// The raw inference response body from the model.
    body: []const u8,

    /// MIME type of the inference result.
    content_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .content_type = "ContentType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SampleInput, options: CallOptions) !SampleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SampleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("job-runtime.sagemaker", "SagemakerJobRuntime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sample";

    const body = input.body;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "X-Amzn-SageMaker-Job-Arn", input.job_arn);
    try request.headers.put(allocator, "X-Amzn-SageMaker-Trajectory-Id", input.trajectory_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SampleOutput {
    var result: SampleOutput = .{
        .body = "",
    };
    errdefer {
        if (result.content_type) |value| allocator.free(value);
        allocator.free(result.body);
    }
    result.body = try allocator.dupe(u8, body);
    _ = status;
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }

    return result;
}
