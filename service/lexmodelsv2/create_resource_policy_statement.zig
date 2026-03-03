const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Effect = @import("effect.zig").Effect;
const Principal = @import("principal.zig").Principal;

pub const CreateResourcePolicyStatementInput = struct {
    /// The Amazon Lex action that this policy either allows or denies. The
    /// action must apply to the resource type of the specified ARN. For more
    /// information, see [
    /// Actions, resources, and condition keys for Amazon Lex
    /// V2](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonlexv2.html).
    action: []const []const u8,

    /// Specifies a condition when the policy is in effect. If the principal
    /// of the policy is a service principal, you must provide two condition
    /// blocks, one with a SourceAccount global condition key and one with a
    /// SourceArn global condition key.
    ///
    /// For more information, see [IAM JSON policy elements: Condition
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition.html).
    condition: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// Determines whether the statement allows or denies access to the
    /// resource.
    effect: Effect,

    /// The identifier of the revision of the policy to edit. If this
    /// revision ID doesn't match the current revision ID, Amazon Lex throws an
    /// exception.
    ///
    /// If you don't specify a revision, Amazon Lex overwrites the contents of
    /// the policy with the new values.
    expected_revision_id: ?[]const u8 = null,

    /// An IAM principal, such as an IAM user, IAM role,
    /// or Amazon Web Services services
    /// that is allowed or denied access to a resource. For more information,
    /// see [Amazon Web Services JSON policy elements:
    /// Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html).
    principal: []const Principal,

    /// The Amazon Resource Name (ARN) of the bot or bot alias that the
    /// resource policy is attached to.
    resource_arn: []const u8,

    /// The name of the statement. The ID is the same as the
    /// `Sid` IAM property. The statement name must be unique
    /// within the policy. For more information, see [IAM
    /// JSON policy elements:
    /// Sid](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_sid.html).
    statement_id: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .condition = "condition",
        .effect = "effect",
        .expected_revision_id = "expectedRevisionId",
        .principal = "principal",
        .resource_arn = "resourceArn",
        .statement_id = "statementId",
    };
};

pub const CreateResourcePolicyStatementOutput = struct {
    /// The Amazon Resource Name (ARN) of the bot or bot alias that the
    /// resource policy is attached to.
    resource_arn: ?[]const u8 = null,

    /// The current revision of the resource policy. Use the revision ID to
    /// make sure that you are updating the most current version of a resource
    /// policy when you add a policy statement to a resource, delete a
    /// resource, or update a resource.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .revision_id = "revisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourcePolicyStatementInput, options: CallOptions) !CreateResourcePolicyStatementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelsv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourcePolicyStatementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/policy/");
    try path_buf.appendSlice(allocator, input.resource_arn);
    try path_buf.appendSlice(allocator, "/statements");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.expected_revision_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "expectedRevisionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"condition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"effect\":");
    try aws.json.writeValue(@TypeOf(input.effect), input.effect, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"statementId\":");
    try aws.json.writeValue(@TypeOf(input.statement_id), input.statement_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourcePolicyStatementOutput {
    var result: CreateResourcePolicyStatementOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateResourcePolicyStatementOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
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
