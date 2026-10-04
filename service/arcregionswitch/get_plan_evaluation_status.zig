const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluationStatus = @import("evaluation_status.zig").EvaluationStatus;
const ResourceWarning = @import("resource_warning.zig").ResourceWarning;

pub const GetPlanEvaluationStatusInput = struct {
    /// The number of objects that you want to return with this call.
    max_results: ?i32 = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `nextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `nextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Region switch plan to retrieve
    /// evaluation status for.
    plan_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .plan_arn = "planArn",
    };
};

pub const GetPlanEvaluationStatusOutput = struct {
    /// The evaluation state for the plan.
    evaluation_state: ?EvaluationStatus = null,

    /// The version of the last evaluation of the plan.
    last_evaluated_version: ?[]const u8 = null,

    /// The time of the last time that Region switch ran an evaluation of the plan.
    last_evaluation_time: ?i64 = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `nextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `nextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the plan.
    plan_arn: []const u8,

    /// The Amazon Web Services Region for the plan.
    region: ?[]const u8 = null,

    /// The current evaluation warnings for the plan.
    warnings: ?[]const ResourceWarning = null,

    pub const json_field_names = .{
        .evaluation_state = "evaluationState",
        .last_evaluated_version = "lastEvaluatedVersion",
        .last_evaluation_time = "lastEvaluationTime",
        .next_token = "nextToken",
        .plan_arn = "planArn",
        .region = "region",
        .warnings = "warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlanEvaluationStatusInput, options: CallOptions) !GetPlanEvaluationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "arc-region-switch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPlanEvaluationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-region-switch", "ARC Region switch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ArcRegionSwitch.GetPlanEvaluationStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPlanEvaluationStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPlanEvaluationStatusOutput, body, allocator);
}
