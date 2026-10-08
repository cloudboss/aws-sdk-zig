const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdatePlanExecutionStepAction = @import("update_plan_execution_step_action.zig").UpdatePlanExecutionStepAction;

pub const UpdatePlanExecutionStepInput = struct {
    /// The updated action to take for the step. This can be used to skip or retry a
    /// step.
    action_to_take: UpdatePlanExecutionStepAction,

    /// An optional comment about the plan execution.
    comment: []const u8,

    /// The unique identifier of the plan execution containing the step to update.
    execution_id: []const u8,

    /// The Amazon Resource Name (ARN) of the plan containing the execution step to
    /// update.
    plan_arn: []const u8,

    /// The name of the execution step to update.
    step_name: []const u8,

    pub const json_field_names = .{
        .action_to_take = "actionToTake",
        .comment = "comment",
        .execution_id = "executionId",
        .plan_arn = "planArn",
        .step_name = "stepName",
    };
};

pub const UpdatePlanExecutionStepOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePlanExecutionStepInput, options: CallOptions) !UpdatePlanExecutionStepOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePlanExecutionStepInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ArcRegionSwitch.UpdatePlanExecutionStep");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePlanExecutionStepOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
