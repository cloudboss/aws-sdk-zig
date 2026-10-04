const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePlanInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ArcRegionSwitch.UpdatePlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePlanOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePlanOutput, body, allocator);
}
