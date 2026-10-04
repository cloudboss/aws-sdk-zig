const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetResource = @import("target_resource.zig").TargetResource;
const ScopeStatus = @import("scope_status.zig").ScopeStatus;

pub const CreateScopeInput = struct {
    /// A unique, case-sensitive string of up to 64 ASCII characters that you
    /// specify to make an idempotent API request. Don't reuse the same client token
    /// for other API requests.
    client_token: ?[]const u8 = null,

    /// The tags for a scope. You can add a maximum of 200 tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The targets to define the scope to be monitored. A target is an array of
    /// targetResources, which are currently Region-account pairs, defined by
    /// targetResource constructs.
    targets: []const TargetResource,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .tags = "tags",
        .targets = "targets",
    };
};

pub const CreateScopeOutput = struct {
    /// The Amazon Resource Name (ARN) of the scope.
    scope_arn: []const u8,

    /// The identifier for the scope that includes the resources you want to get
    /// metrics for. A scope ID is an internally-generated identifier that includes
    /// all the resources for a specific root account.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScopeInput, options: CallOptions) !CreateScopeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/scopes";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targets\":");
    try aws.json.writeValue(@TypeOf(input.targets), input.targets, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScopeOutput {
    var result: CreateScopeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateScopeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
