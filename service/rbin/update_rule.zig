const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const ResourceType = @import("resource_type.zig").ResourceType;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const LockState = @import("lock_state.zig").LockState;
const RuleStatus = @import("rule_status.zig").RuleStatus;

pub const UpdateRuleInput = struct {
    /// The retention rule description.
    description: ?[]const u8 = null,

    /// [Region-level retention rules only] Specifies the exclusion tags to use to
    /// identify resources that are to be excluded,
    /// or ignored, by a Region-level retention rule. Resources that have any of
    /// these tags are not retained by the retention rule
    /// upon deletion.
    ///
    /// You can't specify exclusion tags for tag-level retention rules.
    exclude_resource_tags: ?[]const ResourceTag = null,

    /// The unique ID of the retention rule.
    identifier: []const u8,

    /// [Tag-level retention rules only] Specifies the resource tags to use to
    /// identify resources that are to be retained by a
    /// tag-level retention rule. For tag-level retention rules, only deleted
    /// resources, of the specified resource type, that
    /// have one or more of the specified tag key and value pairs are retained. If a
    /// resource is deleted, but it does not have
    /// any of the specified tag key and value pairs, it is immediately deleted
    /// without being retained by the retention rule.
    ///
    /// You can add the same tag key and value pair to a maximum or five retention
    /// rules.
    ///
    /// To create a Region-level retention rule, omit this parameter. A Region-level
    /// retention rule
    /// does not have any resource tags specified. It retains all deleted resources
    /// of the specified
    /// resource type in the Region in which the rule is created, even if the
    /// resources are not tagged.
    resource_tags: ?[]const ResourceTag = null,

    /// This parameter is currently not supported. You can't update a retention
    /// rule's resource type
    /// after creation.
    resource_type: ?ResourceType = null,

    /// Information about the retention period for which the retention rule is to
    /// retain resources.
    retention_period: ?RetentionPeriod = null,

    pub const json_field_names = .{
        .description = "Description",
        .exclude_resource_tags = "ExcludeResourceTags",
        .identifier = "Identifier",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .retention_period = "RetentionPeriod",
    };
};

pub const UpdateRuleOutput = struct {
    /// The retention rule description.
    description: ?[]const u8 = null,

    /// [Region-level retention rules only] Information about the exclusion tags
    /// used to identify resources that are to be
    /// excluded, or ignored, by the retention rule.
    exclude_resource_tags: ?[]const ResourceTag = null,

    /// The unique ID of the retention rule.
    identifier: ?[]const u8 = null,

    /// The date and time at which the unlock delay is set to expire. Only returned
    /// for retention rules that have been unlocked and that are still within the
    /// unlock
    /// delay period.
    lock_end_time: ?i64 = null,

    /// [Region-level retention rules only] The lock state for the retention rule.
    ///
    /// * `locked` - The retention rule is locked and can't be modified or deleted.
    ///
    /// * `pending_unlock` - The retention rule has been unlocked but it is still
    ///   within
    /// the unlock delay period. The retention rule can be modified or deleted only
    /// after the unlock
    /// delay period has expired.
    ///
    /// * `unlocked` - The retention rule is unlocked and it can be modified or
    ///   deleted by
    /// any user with the required permissions.
    ///
    /// * `null` - The retention rule has never been locked. Once a retention rule
    ///   has
    /// been locked, it can transition between the `locked` and `unlocked` states
    /// only; it can never transition back to `null`.
    lock_state: ?LockState = null,

    /// [Tag-level retention rules only] Information about the resource tags used to
    /// identify resources that are retained by the retention
    /// rule.
    resource_tags: ?[]const ResourceTag = null,

    /// The resource type retained by the retention rule.
    resource_type: ?ResourceType = null,

    retention_period: ?RetentionPeriod = null,

    /// The Amazon Resource Name (ARN) of the retention rule.
    rule_arn: ?[]const u8 = null,

    /// The state of the retention rule. Only retention rules that are in the
    /// `available`
    /// state retain resources.
    status: ?RuleStatus = null,

    pub const json_field_names = .{
        .description = "Description",
        .exclude_resource_tags = "ExcludeResourceTags",
        .identifier = "Identifier",
        .lock_end_time = "LockEndTime",
        .lock_state = "LockState",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .retention_period = "RetentionPeriod",
        .rule_arn = "RuleArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRuleInput, options: CallOptions) !UpdateRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "rbin");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rbin", "rbin", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.exclude_resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExcludeResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retention_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RetentionPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRuleOutput {
    var result: UpdateRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateRuleOutput, body, allocator);
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
