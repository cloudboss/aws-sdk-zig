const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StopAction = @import("stop_action.zig").StopAction;

pub const StopAssessmentRunInput = struct {
    /// The ARN of the assessment run that you want to stop.
    assessment_run_arn: []const u8,

    /// An input option that can be set to either START_EVALUATION or
    /// SKIP_EVALUATION.
    /// START_EVALUATION (the default value), stops the AWS agent from collecting
    /// data and begins
    /// the results evaluation and the findings generation process. SKIP_EVALUATION
    /// cancels the
    /// assessment run immediately, after which no findings are generated.
    stop_action: ?StopAction = null,

    pub const json_field_names = .{
        .assessment_run_arn = "assessmentRunArn",
        .stop_action = "stopAction",
    };
};

pub const StopAssessmentRunOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopAssessmentRunInput, options: CallOptions) !StopAssessmentRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopAssessmentRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector", "Inspector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.StopAssessmentRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopAssessmentRunOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
