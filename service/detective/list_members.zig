const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberDetail = @import("member_detail.zig").MemberDetail;

pub const ListMembersInput = struct {
    /// The ARN of the behavior graph for which to retrieve the list of member
    /// accounts.
    graph_arn: []const u8,

    /// The maximum number of member accounts to include in the response. The total
    /// must be less
    /// than the overall limit on the number of results to return, which is
    /// currently 200.
    max_results: ?i32 = null,

    /// For requests to retrieve the next page of member account results, the
    /// pagination token
    /// that was returned with the previous page of results. The initial request
    /// does not include a
    /// pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .graph_arn = "GraphArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListMembersOutput = struct {
    /// The list of member accounts in the behavior graph.
    ///
    /// For invited accounts, the results include member accounts that did not pass
    /// verification
    /// and member accounts that have not yet accepted the invitation to the
    /// behavior graph. The
    /// results do not include member accounts that were removed from the behavior
    /// graph.
    ///
    /// For the organization behavior graph, the results do not include organization
    /// accounts
    /// that the Detective administrator account has not enabled as member
    /// accounts.
    member_details: ?[]const MemberDetail = null,

    /// If there are more member accounts remaining in the results, then use this
    /// pagination
    /// token to request the next page of member accounts.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .member_details = "MemberDetails",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMembersInput, options: CallOptions) !ListMembersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "detective", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMembersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.detective", "Detective", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/graph/members/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GraphArn\":");
    try aws.json.writeValue(@TypeOf(input.graph_arn), input.graph_arn, allocator, &body_buf);
    has_prev = true;
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMembersOutput {
    var result: ListMembersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListMembersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
