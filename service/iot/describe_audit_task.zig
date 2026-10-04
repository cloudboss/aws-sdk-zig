const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditCheckDetails = @import("audit_check_details.zig").AuditCheckDetails;
const TaskStatistics = @import("task_statistics.zig").TaskStatistics;
const AuditTaskStatus = @import("audit_task_status.zig").AuditTaskStatus;
const AuditTaskType = @import("audit_task_type.zig").AuditTaskType;

pub const DescribeAuditTaskInput = struct {
    /// The ID of the audit whose information you want to get.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub const DescribeAuditTaskOutput = struct {
    /// Detailed information about each check performed during this audit.
    audit_details: ?[]const aws.map.MapEntry(AuditCheckDetails) = null,

    /// The name of the scheduled audit (only if the audit was a scheduled audit).
    scheduled_audit_name: ?[]const u8 = null,

    /// The time the audit started.
    task_start_time: ?i64 = null,

    /// Statistical information about the audit.
    task_statistics: ?TaskStatistics = null,

    /// The status of the audit: one of "IN_PROGRESS", "COMPLETED",
    /// "FAILED", or "CANCELED".
    task_status: ?AuditTaskStatus = null,

    /// The type of audit: "ON_DEMAND_AUDIT_TASK" or "SCHEDULED_AUDIT_TASK".
    task_type: ?AuditTaskType = null,

    pub const json_field_names = .{
        .audit_details = "auditDetails",
        .scheduled_audit_name = "scheduledAuditName",
        .task_start_time = "taskStartTime",
        .task_statistics = "taskStatistics",
        .task_status = "taskStatus",
        .task_type = "taskType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAuditTaskInput, options: CallOptions) !DescribeAuditTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAuditTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/audit/tasks/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAuditTaskOutput {
    const result: DescribeAuditTaskOutput = try aws.json.parseJsonObject(
        DescribeAuditTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
