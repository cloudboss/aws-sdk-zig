const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionGrantCreationMode = @import("subscription_grant_creation_mode.zig").SubscriptionGrantCreationMode;
const SubscriptionTargetForm = @import("subscription_target_form.zig").SubscriptionTargetForm;

pub const CreateSubscriptionTargetInput = struct {
    /// The asset types that can be included in the subscription target.
    applicable_asset_types: []const []const u8,

    /// The authorized principals of the subscription target.
    authorized_principals: []const []const u8,

    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which subscription target is
    /// created.
    domain_identifier: []const u8,

    /// The ID of the environment in which subscription target is created.
    environment_identifier: []const u8,

    /// The manage access role that is used to create the subscription target.
    manage_access_role: []const u8,

    /// The name of the subscription target.
    name: []const u8,

    /// The provider of the subscription target.
    provider: ?[]const u8 = null,

    /// Determines the subscription grant creation mode for this target, defining if
    /// grants are auto-created upon subscription approval or managed manually.
    subscription_grant_creation_mode: ?SubscriptionGrantCreationMode = null,

    /// The configuration of the subscription target.
    subscription_target_config: []const SubscriptionTargetForm,

    /// The type of the subscription target.
    @"type": []const u8,

    pub const json_field_names = .{
        .applicable_asset_types = "applicableAssetTypes",
        .authorized_principals = "authorizedPrincipals",
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .environment_identifier = "environmentIdentifier",
        .manage_access_role = "manageAccessRole",
        .name = "name",
        .provider = "provider",
        .subscription_grant_creation_mode = "subscriptionGrantCreationMode",
        .subscription_target_config = "subscriptionTargetConfig",
        .@"type" = "type",
    };
};

pub const CreateSubscriptionTargetOutput = struct {
    /// The asset types that can be included in the subscription target.
    applicable_asset_types: ?[]const []const u8 = null,

    /// The authorised principals of the subscription target.
    authorized_principals: ?[]const []const u8 = null,

    /// The timestamp of when the subscription target was created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription target.
    created_by: []const u8,

    /// The ID of the Amazon DataZone domain in which the subscription target was
    /// created.
    domain_id: []const u8,

    /// The ID of the environment in which the subscription target was created.
    environment_id: []const u8,

    /// The ID of the subscription target.
    id: []const u8,

    /// The manage access role with which the subscription target was created.
    manage_access_role: ?[]const u8 = null,

    /// The name of the subscription target.
    name: []const u8,

    /// ???
    project_id: []const u8,

    /// The provider of the subscription target.
    provider: []const u8,

    /// Determines the subscription grant creation mode for this target, defining if
    /// grants are auto-created upon subscription approval or managed manually.
    subscription_grant_creation_mode: ?SubscriptionGrantCreationMode = null,

    /// The configuration of the subscription target.
    subscription_target_config: ?[]const SubscriptionTargetForm = null,

    /// The type of the subscription target.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubscriptionTargetInput, options: CallOptions) !CreateSubscriptionTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubscriptionTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/subscription-targets");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"applicableAssetTypes\":");
    try aws.json.writeValue(@TypeOf(input.applicable_asset_types), input.applicable_asset_types, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authorizedPrincipals\":");
    try aws.json.writeValue(@TypeOf(input.authorized_principals), input.authorized_principals, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"manageAccessRole\":");
    try aws.json.writeValue(@TypeOf(input.manage_access_role), input.manage_access_role, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.provider) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"provider\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subscription_grant_creation_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subscriptionGrantCreationMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subscriptionTargetConfig\":");
    try aws.json.writeValue(@TypeOf(input.subscription_target_config), input.subscription_target_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubscriptionTargetOutput {
    var result: CreateSubscriptionTargetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSubscriptionTargetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
