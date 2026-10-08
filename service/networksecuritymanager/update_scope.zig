const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScopeConfiguration = @import("scope_configuration.zig").ScopeConfiguration;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const UpdateScopeInput = struct {
    /// A unique, case-sensitive token that you provide to ensure that the operation
    /// completes no more than one time. If you retry a request with the same client
    /// token and the same parameters, the service returns the result of the
    /// original successful request.
    client_token: ?[]const u8 = null,

    /// Specifies whether to publish the resource. When `true`, the resource is
    /// saved in published (`ACTIVE`) state. When `false`, it is saved as a draft
    /// (`DRAFT`).
    is_published: bool,

    /// The configuration that defines which accounts and resources are in scope. If
    /// you don't include this member, the scope keeps its existing configuration.
    ///
    /// A new configuration can change which accounts and resources are selected,
    /// but it can't add or remove the account filter itself: a scope created for
    /// multi-account use stays multi-account, and a scope created for
    /// single-account use stays single-account.
    scope_configuration: ?ScopeConfiguration = null,

    /// A description of the scope.
    scope_description: ?[]const u8 = null,

    /// The identifier of the scope. This is the scope's Amazon Resource Name (ARN).
    scope_identifier: []const u8,

    /// A token used for optimistic concurrency control. Each read and write returns
    /// an `updateToken`. Provide the most recent value on your next update to
    /// detect and prevent conflicting concurrent modifications.
    update_token: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .is_published = "isPublished",
        .scope_configuration = "scopeConfiguration",
        .scope_description = "scopeDescription",
        .scope_identifier = "scopeIdentifier",
        .update_token = "updateToken",
    };
};

pub const UpdateScopeOutput = struct {
    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// Specifies whether the resource is a snapshot of a published version.
    is_snapshot: ?bool = null,

    /// The Amazon Resource Name (ARN) of the scope.
    scope_arn: []const u8,

    /// The configuration that defines which accounts and resources are in scope.
    scope_configuration: ?ScopeConfiguration = null,

    /// A description of the scope.
    scope_description: ?[]const u8 = null,

    /// The service-generated id of the scope.
    scope_id: []const u8,

    /// The name of the scope.
    scope_name: []const u8,

    /// The current status of the resource: `DRAFT` (unpublished, editable) or
    /// `ACTIVE` (published, in use).
    status: EntityStatus,

    /// The time when the resource was last updated.
    updated_at: ?i64 = null,

    /// A token used for optimistic concurrency control. Each read and write returns
    /// an `updateToken`. Provide the most recent value on your next update to
    /// detect and prevent conflicting concurrent modifications.
    update_token: ?[]const u8 = null,

    /// The version of the resource.
    version: []const u8,

    pub const json_field_names = .{
        .has_published_version = "hasPublishedVersion",
        .is_snapshot = "isSnapshot",
        .scope_arn = "scopeArn",
        .scope_configuration = "scopeConfiguration",
        .scope_description = "scopeDescription",
        .scope_id = "scopeId",
        .scope_name = "scopeName",
        .status = "status",
        .updated_at = "updatedAt",
        .update_token = "updateToken",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScopeInput, options: CallOptions) !UpdateScopeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-security-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/scopes/");
    try path_buf.appendSlice(allocator, input.scope_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"isPublished\":");
    try aws.json.writeValue(@TypeOf(input.is_published), input.is_published, allocator, &body_buf);
    has_prev = true;
    if (input.scope_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scopeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scope_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scopeDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"updateToken\":");
    try aws.json.writeValue(@TypeOf(input.update_token), input.update_token, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScopeOutput {
    const result: UpdateScopeOutput = try aws.json.parseJsonObject(
        UpdateScopeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
