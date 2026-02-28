const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SubscriptionGrantCreationMode = @import("subscription_grant_creation_mode.zig").SubscriptionGrantCreationMode;
const SubscriptionTargetForm = @import("subscription_target_form.zig").SubscriptionTargetForm;

pub const UpdateSubscriptionTargetInput = struct {
    /// The applicable asset types to be updated as part of the
    /// `UpdateSubscriptionTarget` action.
    applicable_asset_types: ?[]const []const u8 = null,

    /// The authorized principals to be updated as part of the
    /// `UpdateSubscriptionTarget` action.
    authorized_principals: ?[]const []const u8 = null,

    /// The identifier of the Amazon DataZone domain in which a subscription target
    /// is to be updated.
    domain_identifier: []const u8,

    /// The identifier of the environment in which a subscription target is to be
    /// updated.
    environment_identifier: []const u8,

    /// Identifier of the subscription target that is to be updated.
    identifier: []const u8,

    /// The manage access role to be updated as part of the
    /// `UpdateSubscriptionTarget` action.
    manage_access_role: ?[]const u8 = null,

    /// The name to be updated as part of the `UpdateSubscriptionTarget` action.
    name: ?[]const u8 = null,

    /// The provider to be updated as part of the `UpdateSubscriptionTarget` action.
    provider: ?[]const u8 = null,

    /// Determines the subscription grant creation mode for this target, defining if
    /// grants are auto-created upon subscription approval or managed manually.
    subscription_grant_creation_mode: ?SubscriptionGrantCreationMode = null,

    /// The configuration to be updated as part of the `UpdateSubscriptionTarget`
    /// action.
    subscription_target_config: ?[]const SubscriptionTargetForm = null,

    pub const json_field_names = .{
        .applicable_asset_types = "applicableAssetTypes",
        .authorized_principals = "authorizedPrincipals",
        .domain_identifier = "domainIdentifier",
        .environment_identifier = "environmentIdentifier",
        .identifier = "identifier",
        .manage_access_role = "manageAccessRole",
        .name = "name",
        .provider = "provider",
        .subscription_grant_creation_mode = "subscriptionGrantCreationMode",
        .subscription_target_config = "subscriptionTargetConfig",
    };
};

pub const UpdateSubscriptionTargetOutput = struct {
    /// The applicable asset types to be updated as part of the
    /// `UpdateSubscriptionTarget` action.
    applicable_asset_types: ?[]const []const u8 = null,

    /// The authorized principals to be updated as part of the
    /// `UpdateSubscriptionTarget` action. Updates are supported in batches of 5 at
    /// a time.
    authorized_principals: ?[]const []const u8 = null,

    /// The timestamp of when a subscription target was created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription target.
    created_by: []const u8,

    /// The identifier of the Amazon DataZone domain in which a subscription target
    /// is to be updated.
    domain_id: []const u8,

    /// The identifier of the environment in which a subscription target is to be
    /// updated.
    environment_id: []const u8,

    /// Identifier of the subscription target that is to be updated.
    id: []const u8,

    /// The manage access role to be updated as part of the
    /// `UpdateSubscriptionTarget` action.
    manage_access_role: ?[]const u8 = null,

    /// The name to be updated as part of the `UpdateSubscriptionTarget` action.
    name: []const u8,

    /// The identifier of the project in which a subscription target is to be
    /// updated.
    project_id: []const u8,

    /// The provider to be updated as part of the `UpdateSubscriptionTarget` action.
    provider: []const u8,

    /// Determines the subscription grant creation mode for this target, defining if
    /// grants are auto-created upon subscription approval or managed manually.
    subscription_grant_creation_mode: ?SubscriptionGrantCreationMode = null,

    /// The configuration to be updated as part of the `UpdateSubscriptionTarget`
    /// action.
    subscription_target_config: ?[]const SubscriptionTargetForm = null,

    /// The type to be updated as part of the `UpdateSubscriptionTarget` action.
    @"type": []const u8,

    /// The timestamp of when the subscription target was updated.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user who updated the subscription target.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .applicable_asset_types = "applicableAssetTypes",
        .authorized_principals = "authorizedPrincipals",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .environment_id = "environmentId",
        .id = "id",
        .manage_access_role = "manageAccessRole",
        .name = "name",
        .project_id = "projectId",
        .provider = "provider",
        .subscription_grant_creation_mode = "subscriptionGrantCreationMode",
        .subscription_target_config = "subscriptionTargetConfig",
        .@"type" = "type",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSubscriptionTargetInput, options: Options) !UpdateSubscriptionTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datazone");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateSubscriptionTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/domains/");
    try path_buf.appendSlice(alloc, input.domain_identifier);
    try path_buf.appendSlice(alloc, "/environments/");
    try path_buf.appendSlice(alloc, input.environment_identifier);
    try path_buf.appendSlice(alloc, "/subscription-targets/");
    try path_buf.appendSlice(alloc, input.identifier);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.applicable_asset_types) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"applicableAssetTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.authorized_principals) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"authorizedPrincipals\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.manage_access_role) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"manageAccessRole\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.provider) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"provider\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.subscription_grant_creation_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"subscriptionGrantCreationMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.subscription_target_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"subscriptionTargetConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateSubscriptionTargetOutput {
    var result: UpdateSubscriptionTargetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSubscriptionTargetOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
