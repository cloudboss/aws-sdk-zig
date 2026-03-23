const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ApprovalStrategy = @import("approval_strategy.zig").ApprovalStrategy;
const ApprovalTeamRequestApprover = @import("approval_team_request_approver.zig").ApprovalTeamRequestApprover;
const PolicyReference = @import("policy_reference.zig").PolicyReference;

pub const CreateApprovalTeamInput = struct {
    /// An `ApprovalStrategy` object. Contains details for how the team grants
    /// approval.
    approval_strategy: ApprovalStrategy,

    /// An array of `ApprovalTeamRequesterApprovers` objects. Contains details for
    /// the approvers in the team.
    approvers: []const ApprovalTeamRequestApprover,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If not provided, the Amazon Web Services populates this
    /// field.
    ///
    /// **What is idempotency?**
    ///
    /// When you make a mutating API request, the request typically returns a result
    /// before the operation's asynchronous workflows have completed. Operations
    /// might also time out or encounter other server issues before they complete,
    /// even though the request has already returned a result. This could make it
    /// difficult to determine whether the request succeeded or not, and could lead
    /// to multiple retries to ensure that the operation completes successfully.
    /// However, if the original request and the subsequent retries are successful,
    /// the operation is completed multiple times. This means that you might create
    /// more resources than you intended.
    ///
    /// *Idempotency* ensures that an API request completes no more than one time.
    /// With an idempotent request, if the original request completes successfully,
    /// any subsequent retries complete successfully without performing any further
    /// actions.
    client_token: ?[]const u8 = null,

    /// Description for the team.
    description: []const u8,

    /// Name of the team.
    name: []const u8,

    /// An array of `PolicyReference` objects. Contains a list of policies that
    /// define the permissions for team resources.
    policies: []const PolicyReference,

    /// Tags you want to attach to the team.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .approval_strategy = "ApprovalStrategy",
        .approvers = "Approvers",
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .policies = "Policies",
        .tags = "Tags",
    };
};

pub const CreateApprovalTeamOutput = struct {
    /// Amazon Resource Name (ARN) for the team that was created.
    arn: ?[]const u8 = null,

    /// Timestamp when the team was created.
    creation_time: ?i64 = null,

    /// Name of the team that was created.
    name: ?[]const u8 = null,

    /// Version ID for the team that was created. When a team is updated, the
    /// version ID changes.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .name = "Name",
        .version_id = "VersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApprovalTeamInput, options: CallOptions) !CreateApprovalTeamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mpa");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApprovalTeamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mpa", "MPA", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/approval-teams";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApprovalStrategy\":");
    try aws.json.writeValue(@TypeOf(input.approval_strategy), input.approval_strategy, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Approvers\":");
    try aws.json.writeValue(@TypeOf(input.approvers), input.approvers, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Policies\":");
    try aws.json.writeValue(@TypeOf(input.policies), input.policies, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApprovalTeamOutput {
    var result: CreateApprovalTeamOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApprovalTeamOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
