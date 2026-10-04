const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentCandidate = @import("component_candidate.zig").ComponentCandidate;
const ComponentPlatform = @import("component_platform.zig").ComponentPlatform;
const ResolvedComponentVersion = @import("resolved_component_version.zig").ResolvedComponentVersion;

pub const ResolveComponentCandidatesInput = struct {
    /// The list of components to resolve.
    component_candidates: ?[]const ComponentCandidate = null,

    /// The platform to use to resolve compatible components.
    platform: ?ComponentPlatform = null,

    pub const json_field_names = .{
        .component_candidates = "componentCandidates",
        .platform = "platform",
    };
};

pub const ResolveComponentCandidatesOutput = struct {
    /// A list of components that meet the requirements that you specify in the
    /// request. This list
    /// includes each component's recipe that you can use to install the component.
    resolved_component_versions: ?[]const ResolvedComponentVersion = null,

    pub const json_field_names = .{
        .resolved_component_versions = "resolvedComponentVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResolveComponentCandidatesInput, options: CallOptions) !ResolveComponentCandidatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ResolveComponentCandidatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "GreengrassV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/greengrass/v2/resolveComponentCandidates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.component_candidates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"componentCandidates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.platform) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"platform\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResolveComponentCandidatesOutput {
    var result: ResolveComponentCandidatesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ResolveComponentCandidatesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
