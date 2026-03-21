const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AssociatedAlarm = @import("associated_alarm.zig").AssociatedAlarm;
const ReportConfiguration = @import("report_configuration.zig").ReportConfiguration;
const Trigger = @import("trigger.zig").Trigger;
const Workflow = @import("workflow.zig").Workflow;
const Plan = @import("plan.zig").Plan;

pub const UpdatePlanInput = struct {
    /// The Amazon Resource Name (ARN) of the plan.
    arn: []const u8,

    /// The updated CloudWatch alarms associated with the plan.
    associated_alarms: ?[]const aws.map.MapEntry(AssociatedAlarm) = null,

    /// The updated description for the Region switch plan.
    description: ?[]const u8 = null,

    /// The updated IAM role ARN that grants Region switch the permissions needed to
    /// execute the plan steps.
    execution_role: []const u8,

    /// The updated target recovery time objective (RTO) in minutes for the plan.
    recovery_time_objective_minutes: ?i32 = null,

    /// The updated report configuration for the plan.
    report_configuration: ?ReportConfiguration = null,

    /// The updated conditions that can automatically trigger the execution of the
    /// plan.
    triggers: ?[]const Trigger = null,

    /// The updated workflows for the Region switch plan.
    workflows: []const Workflow,

    pub const json_field_names = .{
        .arn = "arn",
        .associated_alarms = "associatedAlarms",
        .description = "description",
        .execution_role = "executionRole",
        .recovery_time_objective_minutes = "recoveryTimeObjectiveMinutes",
        .report_configuration = "reportConfiguration",
        .triggers = "triggers",
        .workflows = "workflows",
    };
};

pub const UpdatePlanOutput = struct {
    /// The details of the updated Region switch plan.
    plan: ?Plan = null,

    pub const json_field_names = .{
        .plan = "plan",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePlanInput, options: CallOptions) !UpdatePlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePlanInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ArcRegionSwitch.UpdatePlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePlanOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePlanOutput, body, allocator);
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
