const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Evaluation = @import("evaluation.zig").Evaluation;

pub const PutEvaluationsInput = struct {
    /// The assessments that the Lambda function performs. Each
    /// evaluation identifies an Amazon Web Services resource and indicates whether
    /// it
    /// complies with the Config rule that invokes the Lambda
    /// function.
    evaluations: ?[]const Evaluation = null,

    /// An encrypted token that associates an evaluation with an Config rule.
    /// Identifies the rule and the event that triggered the
    /// evaluation.
    result_token: []const u8,

    /// Use this parameter to specify a test run for
    /// `PutEvaluations`. You can verify whether your Lambda function will deliver
    /// evaluation results to Config. No
    /// updates occur to your existing evaluations, and evaluation results
    /// are not sent to Config.
    ///
    /// When `TestMode` is `true`,
    /// `PutEvaluations` doesn't require a valid value
    /// for the `ResultToken` parameter, but the value cannot
    /// be null.
    test_mode: ?bool = null,

    pub const json_field_names = .{
        .evaluations = "Evaluations",
        .result_token = "ResultToken",
        .test_mode = "TestMode",
    };
};

pub const PutEvaluationsOutput = struct {
    /// Requests that failed because of a client or server
    /// error.
    failed_evaluations: ?[]const Evaluation = null,

    pub const json_field_names = .{
        .failed_evaluations = "FailedEvaluations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEvaluationsInput, options: CallOptions) !PutEvaluationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutEvaluationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutEvaluations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutEvaluationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutEvaluationsOutput, body, allocator);
}
