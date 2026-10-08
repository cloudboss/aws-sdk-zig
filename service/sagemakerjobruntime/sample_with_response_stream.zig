const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SampleWithResponseStreamInput = struct {
    /// The raw inference request body in OpenAI-compatible JSON format.
    body: []const u8,

    /// The job ARN that identifies which model session
    /// to route the inference request to.
    job_arn: []const u8,

    /// The trajectory ID for grouping turns into a single rollout. Each turn
    /// is captured for later use.
    trajectory_id: []const u8,

    pub const json_field_names = .{
        .body = "Body",
        .job_arn = "JobArn",
        .trajectory_id = "TrajectoryId",
    };
};

pub const SampleWithResponseStreamOutput = struct {
    /// The streaming response body, delivered as a series of PayloadPart events.
    body: aws.http.StreamingBody = undefined,

    /// MIME type of the streaming inference result.
    content_type: ?[]const u8 = null,

    pub fn deinit(self: *SampleWithResponseStreamOutput) void {
        self.body.deinit();
    }

    pub const json_field_names = .{
        .body = "Body",
        .content_type = "ContentType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SampleWithResponseStreamInput, options: CallOptions) !SampleWithResponseStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: SampleWithResponseStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("job-runtime.sagemaker", "SagemakerJobRuntime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sample-with-response-stream";

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

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !SampleWithResponseStreamOutput {
    var result: SampleWithResponseStreamOutput = .{};
    errdefer {
        if (result.content_type) |value| allocator.free(value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    result.body = stream_resp.body;
    stream_resp.deinitHeaders();

    return result;
}
