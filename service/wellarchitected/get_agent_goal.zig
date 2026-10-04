const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GoalSummary = @import("goal_summary.zig").GoalSummary;

pub const GetAgentGoalInput = struct {
    /// The unique identifier of the goal to retrieve.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the profile containing the goal.
    profile_arn: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .profile_arn = "profileArn",
    };
};

pub const GetAgentGoalOutput = struct {
    /// The retrieved goal summary.
    goal: ?GoalSummary = null,

    pub const json_field_names = .{
        .goal = "goal",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgentGoalInput, options: CallOptions) !GetAgentGoalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgentGoalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/agent-profiles/");
    try path_buf.appendSlice(allocator, input.profile_arn);
    try path_buf.appendSlice(allocator, "/goals/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgentGoalOutput {
    const result: GetAgentGoalOutput = try aws.json.parseJsonObject(
        GetAgentGoalOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
