const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ActionCompletionStrategy = @import("action_completion_strategy.zig").ActionCompletionStrategy;
const AdditionalSecurityRequirement = @import("additional_security_requirement.zig").AdditionalSecurityRequirement;
const ApprovalStrategyResponse = @import("approval_strategy_response.zig").ApprovalStrategyResponse;
const GetSessionResponseApproverResponse = @import("get_session_response_approver_response.zig").GetSessionResponseApproverResponse;
const SessionExecutionStatus = @import("session_execution_status.zig").SessionExecutionStatus;
const SessionStatus = @import("session_status.zig").SessionStatus;
const SessionStatusCode = @import("session_status_code.zig").SessionStatusCode;

pub const GetSessionInput = struct {
    /// Amazon Resource Name (ARN) for the session.
    session_arn: []const u8,

    pub const json_field_names = .{
        .session_arn = "SessionArn",
    };
};

pub const GetSessionOutput = struct {
    /// Strategy for executing the protected operation.
    /// `AUTO_COMPLETION_UPON_APPROVAL` means the operation is automatically
    /// executed using the requester's permissions, if approved.
    action_completion_strategy: ?ActionCompletionStrategy = null,

    /// Name of the protected operation.
    action_name: ?[]const u8 = null,

    /// A list of `AdditionalSecurityRequirement` applied to the session.
    additional_security_requirements: ?[]const AdditionalSecurityRequirement = null,

    /// An `ApprovalStrategyResponse` object. Contains details for how the team
    /// grants approval
    approval_strategy: ?ApprovalStrategyResponse = null,

    /// Amazon Resource Name (ARN) for the approval team.
    approval_team_arn: ?[]const u8 = null,

    /// Name of the approval team.
    approval_team_name: ?[]const u8 = null,

    /// An array of `GetSessionResponseApproverResponse` objects. Contains details
    /// for approver responses in the session.
    approver_responses: ?[]const GetSessionResponseApproverResponse = null,

    /// Timestamp when the session completed.
    completion_time: ?i64 = null,

    /// Description for the session.
    description: ?[]const u8 = null,

    /// Status for the protected operation. For example, if the operation is
    /// `PENDING`.
    execution_status: ?SessionExecutionStatus = null,

    /// Timestamp when the session will expire.
    expiration_time: ?i64 = null,

    /// Timestamp when the session was initiated.
    initiation_time: ?i64 = null,

    /// Metadata for the session.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// Total number of approvers in the session.
    number_of_approvers: ?i32 = null,

    /// Amazon Resource Name (ARN) for the protected operation.
    protected_resource_arn: ?[]const u8 = null,

    /// ID for the account that made the operation request.
    requester_account_id: ?[]const u8 = null,

    /// Message from the account that made the operation request
    requester_comment: ?[]const u8 = null,

    /// [IAM
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-request) that made the operation request.
    requester_principal_arn: ?[]const u8 = null,

    /// Amazon Web Services Region where the operation request originated.
    requester_region: ?[]const u8 = null,

    /// [Service
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#principal-services) for the service associated with the protected operation.
    requester_service_principal: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) for the session.
    session_arn: ?[]const u8 = null,

    /// Status for the session. For example, if the team has approved the requested
    /// operation.
    status: ?SessionStatus = null,

    /// Status code of the session.
    status_code: ?SessionStatusCode = null,

    /// Message describing the status for session.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_completion_strategy = "ActionCompletionStrategy",
        .action_name = "ActionName",
        .additional_security_requirements = "AdditionalSecurityRequirements",
        .approval_strategy = "ApprovalStrategy",
        .approval_team_arn = "ApprovalTeamArn",
        .approval_team_name = "ApprovalTeamName",
        .approver_responses = "ApproverResponses",
        .completion_time = "CompletionTime",
        .description = "Description",
        .execution_status = "ExecutionStatus",
        .expiration_time = "ExpirationTime",
        .initiation_time = "InitiationTime",
        .metadata = "Metadata",
        .number_of_approvers = "NumberOfApprovers",
        .protected_resource_arn = "ProtectedResourceArn",
        .requester_account_id = "RequesterAccountId",
        .requester_comment = "RequesterComment",
        .requester_principal_arn = "RequesterPrincipalArn",
        .requester_region = "RequesterRegion",
        .requester_service_principal = "RequesterServicePrincipal",
        .session_arn = "SessionArn",
        .status = "Status",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionInput, options: CallOptions) !GetSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mpa", "MPA", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionOutput {
    var result: GetSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSessionOutput, body, allocator);
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
