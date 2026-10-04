const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetResource = @import("target_resource.zig").TargetResource;
const ScopeStatus = @import("scope_status.zig").ScopeStatus;

pub const UpdateScopeInput = struct {
    /// A list of resources to add to a scope.
    resources_to_add: ?[]const TargetResource = null,

    /// A list of resources to delete from a scope.
    resources_to_delete: ?[]const TargetResource = null,

    /// The identifier for the scope that includes the resources you want to get
    /// data results for. A scope ID is an internally-generated identifier that
    /// includes all the resources for a specific root account.
    scope_id: []const u8,

    pub const json_field_names = .{
        .resources_to_add = "resourcesToAdd",
        .resources_to_delete = "resourcesToDelete",
        .scope_id = "scopeId",
    };
};

pub const UpdateScopeOutput = struct {
    /// The Amazon Resource Name (ARN) of the scope.
    scope_arn: []const u8,

    /// The identifier for the scope that includes the resources you want to get
    /// data results for. A scope ID is an internally-generated identifier that
    /// includes all the resources for a specific root account.
    scope_id: []const u8,

    /// The status for a scope. The status can be one of the following: `SUCCEEDED`,
    /// `IN_PROGRESS`, `FAILED`, `DEACTIVATING`, or `DEACTIVATED`.
    ///
    /// A status of `DEACTIVATING` means that you've requested a scope to be
    /// deactivated and Network Flow Monitor is in the process of deactivating the
    /// scope. A status of `DEACTIVATED` means that the deactivating process is
    /// complete.
    status: ScopeStatus,

    /// The tags for a scope.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .scope_arn = "scopeArn",
        .scope_id = "scopeId",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScopeInput, options: CallOptions) !UpdateScopeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkflowmonitor", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/scopes/");
    try path_buf.appendSlice(allocator, input.scope_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.resources_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourcesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resources_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourcesToDelete\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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
    var result: UpdateScopeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateScopeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
