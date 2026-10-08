const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GoalType = @import("goal_type.zig").GoalType;
const GoalStatus = @import("goal_status.zig").GoalStatus;
const Goal = @import("goal.zig").Goal;

pub const ListGoalsInput = struct {
    /// The unique identifier for the agent space
    agent_space_id: []const u8,

    /// Filter goals by goal type
    goal_type: ?GoalType = null,

    /// Maximum number of goals to return
    limit: ?i32 = null,

    /// Pagination token for the next set of results
    next_token: ?[]const u8 = null,

    /// Filter goals by goal status
    status: ?GoalStatus = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .goal_type = "goalType",
        .limit = "limit",
        .next_token = "nextToken",
        .status = "status",
    };
};

pub const ListGoalsOutput = struct {
    /// List of goals matching the criteria
    goals: ?[]const Goal = null,

    /// Pagination token for the next set of results
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .goals = "goals",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGoalsInput, options: CallOptions) !ListGoalsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGoalsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backlog/agent-space/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/goals/list");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.goal_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"goalType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.limit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"limit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGoalsOutput {
    const result: ListGoalsOutput = try aws.json.parseJsonObject(
        ListGoalsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
