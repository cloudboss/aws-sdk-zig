const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditMitigationActionsTaskTarget = @import("audit_mitigation_actions_task_target.zig").AuditMitigationActionsTaskTarget;

pub const StartAuditMitigationActionsTaskInput = struct {
    /// For an audit check, specifies which mitigation actions to apply. Those
    /// actions must be defined in your Amazon Web Services accounts.
    audit_check_to_actions_mapping: []const aws.map.MapEntry([]const []const u8),

    /// Each audit mitigation task must have a unique client request token. If you
    /// try to start a new task with the same token as a task that already exists,
    /// an exception occurs. If you omit this value, a unique client request token
    /// is generated automatically.
    client_request_token: []const u8,

    /// Specifies the audit findings to which the mitigation actions are applied.
    /// You can apply
    /// them to a type of audit check, to all findings from an audit, or to a
    /// specific set of
    /// findings.
    target: AuditMitigationActionsTaskTarget,

    /// A unique identifier for the task. You can use this identifier to check the
    /// status of the task or to cancel it.
    task_id: []const u8,

    pub const json_field_names = .{
        .audit_check_to_actions_mapping = "auditCheckToActionsMapping",
        .client_request_token = "clientRequestToken",
        .target = "target",
        .task_id = "taskId",
    };
};

pub const StartAuditMitigationActionsTaskOutput = struct {
    /// The unique identifier for the audit mitigation task. This matches the
    /// `taskId` that you specified in the request.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAuditMitigationActionsTaskInput, options: CallOptions) !StartAuditMitigationActionsTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAuditMitigationActionsTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/audit/mitigationactions/tasks/");
    try path_buf.appendSlice(allocator, input.task_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"auditCheckToActionsMapping\":");
    try aws.json.writeValue(@TypeOf(input.audit_check_to_actions_mapping), input.audit_check_to_actions_mapping, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAuditMitigationActionsTaskOutput {
    var result: StartAuditMitigationActionsTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartAuditMitigationActionsTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
