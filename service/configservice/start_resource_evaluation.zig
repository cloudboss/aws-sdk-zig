const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluationContext = @import("evaluation_context.zig").EvaluationContext;
const EvaluationMode = @import("evaluation_mode.zig").EvaluationMode;
const ResourceDetails = @import("resource_details.zig").ResourceDetails;

pub const StartResourceEvaluationInput = struct {
    /// A client token is a unique, case-sensitive string of up to 64 ASCII
    /// characters.
    /// To make an idempotent API request using one of these actions, specify a
    /// client token in the request.
    ///
    /// Avoid reusing the same client token for other API requests. If you retry
    /// a request that completed successfully using the same client token and the
    /// same
    /// parameters, the retry succeeds without performing any further actions. If
    /// you retry
    /// a successful request using the same client token, but one or more of the
    /// parameters
    /// are different, other than the Region or Availability Zone, the retry fails
    /// with an
    /// IdempotentParameterMismatch error.
    client_token: ?[]const u8 = null,

    /// Returns an `EvaluationContext` object.
    evaluation_context: ?EvaluationContext = null,

    /// The mode of an evaluation.
    ///
    /// The only valid value for this API is `PROACTIVE`.
    evaluation_mode: EvaluationMode,

    /// The timeout for an evaluation. The default is 900 seconds. You cannot
    /// specify a number greater than 3600. If you specify 0, Config uses the
    /// default.
    evaluation_timeout: ?i32 = null,

    /// Returns a `ResourceDetails` object.
    resource_details: ResourceDetails,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .evaluation_context = "EvaluationContext",
        .evaluation_mode = "EvaluationMode",
        .evaluation_timeout = "EvaluationTimeout",
        .resource_details = "ResourceDetails",
    };
};

pub const StartResourceEvaluationOutput = struct {
    /// A
    /// unique ResourceEvaluationId that is associated with a single execution.
    resource_evaluation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_evaluation_id = "ResourceEvaluationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartResourceEvaluationInput, options: CallOptions) !StartResourceEvaluationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartResourceEvaluationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.StartResourceEvaluation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartResourceEvaluationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartResourceEvaluationOutput, body, allocator);
}
