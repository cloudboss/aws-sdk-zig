const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionGroup = @import("action_group.zig").ActionGroup;

pub const PutPermissionInput = struct {
    /// Specifies an action group that contains permissions to add to
    /// a profiling group resource. One action group is supported,
    /// `agentPermissions`, which
    /// grants permission to perform actions required by the profiling agent,
    /// `ConfigureAgent`
    /// and `PostAgentProfile` permissions.
    action_group: ActionGroup,

    /// A list ARNs for the roles and users you want to grant access to the
    /// profiling group.
    /// Wildcards are not are supported in the ARNs.
    principals: []const []const u8,

    /// The name of the profiling group to grant access to.
    profiling_group_name: []const u8,

    /// A universally unique identifier (UUID) for the revision of the policy you
    /// are adding to the profiling group. Do not specify
    /// this when you add permissions to a profiling group for the first time. If a
    /// policy already exists on the
    /// profiling group, you must specify the `revisionId`.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_group = "actionGroup",
        .principals = "principals",
        .profiling_group_name = "profilingGroupName",
        .revision_id = "revisionId",
    };
};

pub const PutPermissionOutput = struct {
    /// The JSON-formatted resource-based policy on the profiling group that
    /// includes the
    /// added permissions.
    policy: []const u8,

    /// A universally unique identifier (UUID) for the revision of the
    /// resource-based policy
    /// that includes the added permissions. The JSON-formatted policy is in the
    /// `policy` element of the response.
    revision_id: []const u8,

    pub const json_field_names = .{
        .policy = "policy",
        .revision_id = "revisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPermissionInput, options: CallOptions) !PutPermissionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/policy/");
    try path_buf.appendSlice(allocator, input.action_group);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"principals\":");
    try aws.json.writeValue(@TypeOf(input.principals), input.principals, allocator, &body_buf);
    has_prev = true;
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"revisionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutPermissionOutput {
    var result: PutPermissionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutPermissionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
