const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutResourcePolicyInput = struct {
    /// A flag to indicate whether to bypass the resource policy lockout safety
    /// check.
    ///
    /// Setting this value to true increases the risk that the policy becomes
    /// unmanageable. Do not set this value to true indiscriminately.
    ///
    /// Use this parameter only when you include a policy in the request and you
    /// intend to prevent the principal that is making the request from making a
    /// subsequent `PutResourcePolicy` request.
    ///
    /// The default value is false.
    bypass_policy_lockout_check: ?bool = null,

    /// The resource policy document, which can be up to 5kb in size.
    policy_document: []const u8,

    /// The name of the resource policy. Must be unique within a specific Amazon Web
    /// Services account.
    policy_name: []const u8,

    /// Specifies a specific policy revision, to ensure an atomic create operation.
    /// By default the resource policy is created if it does not exist, or updated
    /// with an incremented revision id.
    /// The revision id is unique to each policy in the account.
    ///
    /// If the policy revision id does not match the latest revision id, the
    /// operation will fail with an `InvalidPolicyRevisionIdException` exception.
    /// You can also provide a
    /// `PolicyRevisionId` of 0. In this case, the operation will fail with an
    /// `InvalidPolicyRevisionIdException` exception if a resource policy with the
    /// same name already exists.
    policy_revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bypass_policy_lockout_check = "BypassPolicyLockoutCheck",
        .policy_document = "PolicyDocument",
        .policy_name = "PolicyName",
        .policy_revision_id = "PolicyRevisionId",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// The resource policy document, as provided in the `PutResourcePolicyRequest`.
    resource_policy: ?ResourcePolicy = null,

    pub const json_field_names = .{
        .resource_policy = "ResourcePolicy",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: Options) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "xray");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/PutResourcePolicy";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bypass_policy_lockout_check) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BypassPolicyLockoutCheck\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PolicyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PolicyName\":");
    try aws.json.writeValue(@TypeOf(input.policy_name), input.policy_name, allocator, &body_buf);
    has_prev = true;
    if (input.policy_revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PolicyRevisionId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    var result: PutResourcePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InvalidPolicyRevisionIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_revision_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LockoutPreventionException")) {
        return .{ .arena = arena, .kind = .{ .lockout_prevention_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyCountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_count_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicySizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_size_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "RuleLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .rule_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
