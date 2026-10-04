const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ListSessionsResponseSession = @import("list_sessions_response_session.zig").ListSessionsResponseSession;

pub const ListSessionsInput = struct {
    /// Amazon Resource Name (ARN) for the approval team.
    approval_team_arn: []const u8,

    /// An array of `Filter` objects. Contains the filter to apply when listing
    /// sessions.
    filters: ?[]const Filter = null,

    /// The maximum number of items to return in the response. If more results exist
    /// than the specified `MaxResults` value, a token is included in the response
    /// so that you can retrieve the remaining results.
    max_results: ?i32 = null,

    /// If present, indicates that more output is available than is included in the
    /// current response. Use this value in the `NextToken` request parameter in a
    /// next call to the operation to get more output. You can repeat this until the
    /// `NextToken` response element returns `null`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_team_arn = "ApprovalTeamArn",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListSessionsOutput = struct {
    /// If present, indicates that more output is available than is included in the
    /// current response. Use this value in the `NextToken` request parameter in a
    /// next call to the operation to get more output. You can repeat this until the
    /// `NextToken` response element returns `null`.
    next_token: ?[]const u8 = null,

    /// An array of `ListSessionsResponseSession` objects. Contains details for the
    /// sessions.
    sessions: ?[]const ListSessionsResponseSession = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sessions = "Sessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSessionsInput, options: CallOptions) !ListSessionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mpa", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSessionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mpa", "MPA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/approval-teams/");
    try path_buf.appendSlice(allocator, input.approval_team_arn);
    try path_buf.appendSlice(allocator, "/sessions/");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "List");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSessionsOutput {
    var result: ListSessionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSessionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
