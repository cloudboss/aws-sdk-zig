const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MitigationAction = @import("mitigation_action.zig").MitigationAction;
const AuditMitigationActionsTaskTarget = @import("audit_mitigation_actions_task_target.zig").AuditMitigationActionsTaskTarget;
const TaskStatisticsForAuditCheck = @import("task_statistics_for_audit_check.zig").TaskStatisticsForAuditCheck;
const AuditMitigationActionsTaskStatus = @import("audit_mitigation_actions_task_status.zig").AuditMitigationActionsTaskStatus;

pub const DescribeAuditMitigationActionsTaskInput = struct {
    /// The unique identifier for the audit mitigation task.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub const DescribeAuditMitigationActionsTaskOutput = struct {
    /// Specifies the mitigation actions and their parameters that are applied as
    /// part of this task.
    actions_definition: ?[]const MitigationAction = null,

    /// Specifies the mitigation actions that should be applied to specific audit
    /// checks.
    audit_check_to_actions_mapping: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The date and time when the task was completed or canceled.
    end_time: ?i64 = null,

    /// The date and time when the task was started.
    start_time: ?i64 = null,

    /// Identifies the findings to which the mitigation actions are applied. This
    /// can be by audit checks, by audit task, or a set of findings.
    target: ?AuditMitigationActionsTaskTarget = null,

    /// Aggregate counts of the results when the mitigation tasks were applied to
    /// the findings for this audit mitigation actions task.
    task_statistics: ?[]const aws.map.MapEntry(TaskStatisticsForAuditCheck) = null,

    /// The current status of the task.
    task_status: ?AuditMitigationActionsTaskStatus = null,

    pub const json_field_names = .{
        .actions_definition = "actionsDefinition",
        .audit_check_to_actions_mapping = "auditCheckToActionsMapping",
        .end_time = "endTime",
        .start_time = "startTime",
        .target = "target",
        .task_statistics = "taskStatistics",
        .task_status = "taskStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAuditMitigationActionsTaskInput, options: CallOptions) !DescribeAuditMitigationActionsTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAuditMitigationActionsTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/audit/mitigationactions/tasks/");
    try path_buf.appendSlice(allocator, input.task_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAuditMitigationActionsTaskOutput {
    const result: DescribeAuditMitigationActionsTaskOutput = try aws.json.parseJsonObject(
        DescribeAuditMitigationActionsTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
