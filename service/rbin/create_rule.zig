const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const LockConfiguration = @import("lock_configuration.zig").LockConfiguration;
const ResourceType = @import("resource_type.zig").ResourceType;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const Tag = @import("tag.zig").Tag;
const LockState = @import("lock_state.zig").LockState;
const RuleStatus = @import("rule_status.zig").RuleStatus;

pub const CreateRuleInput = struct {
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

    /// Information about the retention rule lock configuration.
    lock_configuration: ?LockConfiguration = null,

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

    /// The resource type to be retained by the retention rule. Currently, only EBS
    /// volumes, EBS snapshots, and EBS-backed AMIs
    /// are supported.
    ///
    /// * To retain EBS volumes, specify `EBS_VOLUME`.
    ///
    /// * To retain EBS snapshots, specify `EBS_SNAPSHOT`
    ///
    /// * To retain EBS-backed AMIs, specify `EC2_IMAGE`.
    resource_type: ResourceType,

    /// Information about the retention period for which the retention rule is to
    /// retain resources.
    retention_period: RetentionPeriod,

    /// Information about the tags to assign to the retention rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .exclude_resource_tags = "ExcludeResourceTags",
        .lock_configuration = "LockConfiguration",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .retention_period = "RetentionPeriod",
        .tags = "Tags",
    };
};

pub const CreateRuleOutput = struct {
    /// The retention rule description.
    description: ?[]const u8 = null,

    /// [Region-level retention rules only] Information about the exclusion tags
    /// used to identify resources that are to be
    /// excluded, or ignored, by the retention rule.
    exclude_resource_tags: ?[]const ResourceTag = null,

    /// The unique ID of the retention rule.
    identifier: ?[]const u8 = null,

    /// Information about the retention rule lock configuration.
    lock_configuration: ?LockConfiguration = null,

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

    /// Information about the tags assigned to the retention rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .exclude_resource_tags = "ExcludeResourceTags",
        .identifier = "Identifier",
        .lock_configuration = "LockConfiguration",
        .lock_state = "LockState",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .retention_period = "RetentionPeriod",
        .rule_arn = "RuleArn",
        .status = "Status",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleInput, options: Options) !CreateRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "rbin");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rbin", "rbin", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/rules";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.exclude_resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ExcludeResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.lock_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LockConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ResourceType\":");
    try aws.json.writeValue(@TypeOf(input.resource_type), input.resource_type, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RetentionPeriod\":");
    try aws.json.writeValue(@TypeOf(input.retention_period), input.retention_period, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateRuleOutput {
    var result: CreateRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRuleOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
