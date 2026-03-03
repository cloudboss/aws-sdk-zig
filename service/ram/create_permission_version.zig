const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceSharePermissionDetail = @import("resource_share_permission_detail.zig").ResourceSharePermissionDetail;

pub const CreatePermissionVersionInput = struct {
    /// Specifies a unique, case-sensitive identifier that you provide to
    /// ensure the idempotency of the request. This lets you safely retry the
    /// request without
    /// accidentally performing the same operation a second time. Passing the same
    /// value to a
    /// later call to an operation requires that you also pass the same value for
    /// all other
    /// parameters. We recommend that you use a [UUID type of
    /// value.](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for
    /// you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with
    /// different parameters, the retry fails with an `IdempotentParameterMismatch`
    /// error.
    client_token: ?[]const u8 = null,

    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the customer managed permission you're creating a new version for.
    permission_arn: []const u8,

    /// A string in JSON format string that contains the following elements of a
    /// resource-based policy:
    ///
    /// * **Effect**: must be set to
    /// `ALLOW`.
    ///
    /// * **Action**: specifies the actions that are
    /// allowed by this customer managed permission. The list must contain only
    /// actions that are supported by
    /// the specified resource type. For a list of all actions supported by each
    /// resource type, see [Actions, resources, and condition keys for Amazon Web
    /// Services
    /// services](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html) in the
    /// *Identity and Access Management User Guide*.
    ///
    /// * **Condition**: (optional) specifies conditional
    /// parameters that must evaluate to true when a user attempts an action for
    /// that
    /// action to be allowed. For more information about the Condition element, see
    /// [IAM
    /// policies: Condition
    /// element](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition.html) in the *Identity and Access Management User
    /// Guide*.
    ///
    /// This template can't include either the `Resource` or
    /// `Principal` elements. Those are both filled in by RAM when it instantiates
    /// the resource-based policy on each resource shared using this managed
    /// permission. The
    /// `Resource` comes from the ARN of the specific resource that you are sharing.
    /// The `Principal` comes from the list of identities added to the resource
    /// share.
    policy_template: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .permission_arn = "permissionArn",
        .policy_template = "policyTemplate",
    };
};

pub const CreatePermissionVersionOutput = struct {
    /// The idempotency identifier associated with this request. If you
    /// want to repeat the same operation in an idempotent manner then you must
    /// include this
    /// value in the `clientToken` request parameter of that later call. All other
    /// parameters must also have the same values that you used in the first call.
    client_token: ?[]const u8 = null,

    permission: ?ResourceSharePermissionDetail = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .permission = "permission",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePermissionVersionInput, options: Options) !CreatePermissionVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ram");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePermissionVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/createpermissionversion";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"permissionArn\":");
    try aws.json.writeValue(@TypeOf(input.permission_arn), input.permission_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyTemplate\":");
    try aws.json.writeValue(@TypeOf(input.policy_template), input.policy_template, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePermissionVersionOutput {
    var result: CreatePermissionVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePermissionVersionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClientTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxResultsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_max_results_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_transition_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedArnException")) {
        return .{ .arena = arena, .kind = .{ .malformed_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyTemplateException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_template_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .permission_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .permission_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionVersionsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .permission_versions_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceArnNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_arn_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareInvitationAlreadyAcceptedException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_invitation_already_accepted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareInvitationAlreadyRejectedException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_invitation_already_rejected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareInvitationArnNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_invitation_arn_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareInvitationExpiredException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_invitation_expired_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerInternalException")) {
        return .{ .arena = arena, .kind = .{ .server_internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyViolationException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_violation_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnknownResourceException")) {
        return .{ .arena = arena, .kind = .{ .unknown_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnmatchedPolicyPermissionException")) {
        return .{ .arena = arena, .kind = .{ .unmatched_policy_permission_exception = .{
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
