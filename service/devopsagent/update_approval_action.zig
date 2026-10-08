const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalActionType = @import("approval_action_type.zig").ApprovalActionType;
const ApprovalPattern = @import("approval_pattern.zig").ApprovalPattern;
const ApprovalStatus = @import("approval_status.zig").ApprovalStatus;

pub const UpdateApprovalActionInput = struct {
    /// The action to take on the approval request — APPROVED or REJECTED.
    action: ApprovalActionType,

    /// The agent space identifier — multi-tenant workspace scope. Bound from the
    /// request URI.
    agent_space_id: []const u8,

    /// Identifier of the approval request being resolved. A UUID. Bound from the
    /// request URI.
    approval_id: []const u8,

    /// The finalized pattern (tool + argumentPins) that scopes the approval.
    /// Required when `action` is APPROVED; must be absent when `action` is
    /// REJECTED. The pattern narrows, and must not widen, the invocation originally
    /// requested by the agent. This cross-field invariant is enforced by
    /// service-side validation.
    final_pattern: ?ApprovalPattern = null,

    /// Optional free-text rationale for the decision. Permitted when `action` is
    /// REJECTED; ignored when `action` is APPROVED.
    reason: ?[]const u8 = null,

    /// Whether the approved action backs a single executed tool call (true) or is
    /// reusable within ttlSeconds (false). Required when `action` is APPROVED; must
    /// be absent when `action` is REJECTED. When true, ttlSeconds must be absent
    /// (the redemption window collapses to the single use). When false, ttlSeconds
    /// is required and bounds the reuse window. Cross-field invariants are enforced
    /// by service-side validation.
    single_use: ?bool = null,

    /// Approval lifetime in seconds, starting from when the decision is submitted.
    /// Required when `action` is APPROVED AND `singleUse` is false; must be absent
    /// when `action` is REJECTED or when `singleUse` is true (a single-use approval
    /// backs one executed action and the redemption window collapses). Cross-field
    /// invariants are enforced by service-side validation; the @range bound here is
    /// the operation-boundary check that always applies (a maximum of 4 hours).
    ttl_seconds: ?i32 = null,

    pub const json_field_names = .{
        .action = "action",
        .agent_space_id = "agentSpaceId",
        .approval_id = "approvalId",
        .final_pattern = "finalPattern",
        .reason = "reason",
        .single_use = "singleUse",
        .ttl_seconds = "ttlSeconds",
    };
};

pub const UpdateApprovalActionOutput = struct {
    /// Identifier of the approval request that was resolved. Echoed back so the
    /// client can correlate the response with the request.
    approval_id: []const u8,

    /// Absolute timestamp at which the approval expires. Set when status is
    /// APPROVED (computed as the submission time plus ttlSeconds); absent when
    /// status is REJECTED.
    expires_at: ?i64 = null,

    /// Lifecycle status of the approval request immediately after submission.
    /// Expected post-submission states are APPROVED (when the action is APPROVED)
    /// or REJECTED (when the action is REJECTED); PENDING is not returned from this
    /// operation, and REVOKED and REDEEMED are reachable only via subsequent reads.
    status: ApprovalStatus,

    pub const json_field_names = .{
        .approval_id = "approvalId",
        .expires_at = "expiresAt",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApprovalActionInput, options: CallOptions) !UpdateApprovalActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApprovalActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/agent-space/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/approvals/");
    try path_buf.appendSlice(allocator, input.approval_id);
    try path_buf.appendSlice(allocator, "/update-action");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.final_pattern) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"finalPattern\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reason\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.single_use) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"singleUse\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ttl_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ttlSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApprovalActionOutput {
    const result: UpdateApprovalActionOutput = try aws.json.parseJsonObject(
        UpdateApprovalActionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
