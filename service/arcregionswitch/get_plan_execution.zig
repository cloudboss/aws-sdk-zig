const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ExecutionAction = @import("execution_action.zig").ExecutionAction;
const ExecutionState = @import("execution_state.zig").ExecutionState;
const GeneratedReport = @import("generated_report.zig").GeneratedReport;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const Plan = @import("plan.zig").Plan;
const StepState = @import("step_state.zig").StepState;

pub const GetPlanExecutionInput = struct {
    /// The execution identifier of a plan execution.
    execution_id: []const u8,

    /// The number of objects that you want to return with this call.
    max_results: ?i32 = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `nextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `nextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the plan with the execution to retrieve.
    plan_arn: []const u8,

    pub const json_field_names = .{
        .execution_id = "executionId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .plan_arn = "planArn",
    };
};

pub const GetPlanExecutionOutput = struct {
    /// The actual recovery time that Region switch calculates for a plan execution.
    /// Actual recovery time includes the time for the plan to run added to the time
    /// elapsed until the application health alarms that you've specified are
    /// healthy again.
    actual_recovery_time: ?[]const u8 = null,

    /// A comment included on the plan execution.
    comment: ?[]const u8 = null,

    /// The time (UTC) when the plan execution ended.
    end_time: ?i64 = null,

    /// The plan execution action. Valid values are `activate`, to activate an
    /// Amazon Web Services Region, or `deactivate`, to deactivate a Region.
    execution_action: ExecutionAction,

    /// The execution identifier of a plan execution.
    execution_id: []const u8,

    /// The Amazon Web Services Region for a plan execution.
    execution_region: []const u8,

    /// The plan execution state. Provides the state of a plan execution, for
    /// example, In Progress or Paused by Operator.
    execution_state: ExecutionState,

    /// Information about the location of a generated report, or the cause of its
    /// failure.
    generated_report_details: ?[]const GeneratedReport = null,

    /// The plan execution mode. Valid values are `graceful`, for graceful
    /// executions, or `ungraceful`, for ungraceful executions.
    mode: ExecutionMode,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `nextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `nextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The details of the Region switch plan.
    plan: ?Plan = null,

    /// The Amazon Resource Name (ARN) of the plan.
    plan_arn: []const u8,

    /// The time (UTC) when the plan execution started.
    start_time: i64,

    /// The states of the steps in the plan execution.
    step_states: ?[]const StepState = null,

    /// The timestamp when the plan execution was last updated.
    updated_at: ?i64 = null,

    /// The version for the plan.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .actual_recovery_time = "actualRecoveryTime",
        .comment = "comment",
        .end_time = "endTime",
        .execution_action = "executionAction",
        .execution_id = "executionId",
        .execution_region = "executionRegion",
        .execution_state = "executionState",
        .generated_report_details = "generatedReportDetails",
        .mode = "mode",
        .next_token = "nextToken",
        .plan = "plan",
        .plan_arn = "planArn",
        .start_time = "startTime",
        .step_states = "stepStates",
        .updated_at = "updatedAt",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlanExecutionInput, options: CallOptions) !GetPlanExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "arc-region-switch");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetPlanExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-region-switch", "ARC Region switch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ArcRegionSwitch.GetPlanExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPlanExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPlanExecutionOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalArgumentException")) {
        return .{ .arena = arena, .kind = .{ .illegal_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalStateException")) {
        return .{ .arena = arena, .kind = .{ .illegal_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
