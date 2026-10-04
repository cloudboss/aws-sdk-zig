const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionGroup = @import("action_group.zig").ActionGroup;

pub const RemovePermissionInput = struct {
    /// Specifies an action group that contains the permissions to remove from
    /// a profiling group's resource-based policy. One action group is supported,
    /// `agentPermissions`, which
    /// grants `ConfigureAgent` and `PostAgentProfile` permissions.
    action_group: ActionGroup,

    /// The name of the profiling group.
    profiling_group_name: []const u8,

    /// A universally unique identifier (UUID) for the revision of the
    /// resource-based policy from which
    /// you want to remove permissions.
    revision_id: []const u8,

    pub const json_field_names = .{
        .action_group = "actionGroup",
        .profiling_group_name = "profilingGroupName",
        .revision_id = "revisionId",
    };
};

pub const RemovePermissionOutput = struct {
    /// The JSON-formatted resource-based policy on the profiling group after
    /// the specified permissions were removed.
    policy: []const u8,

    /// A universally unique identifier (UUID) for the revision of the
    /// resource-based policy
    /// after the specified permissions were removed. The updated JSON-formatted
    /// policy is in the
    /// `policy` element of the response.
    revision_id: []const u8,

    pub const json_field_names = .{
        .policy = "policy",
        .revision_id = "revisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemovePermissionInput, options: CallOptions) !RemovePermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-profiler", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RemovePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/policy/");
    try path_buf.appendSlice(allocator, input.action_group);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "revisionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.revision_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemovePermissionOutput {
    const result: RemovePermissionOutput = try aws.json.parseJsonObject(
        RemovePermissionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
