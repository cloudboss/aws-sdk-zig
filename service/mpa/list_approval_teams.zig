const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListApprovalTeamsResponseApprovalTeam = @import("list_approval_teams_response_approval_team.zig").ListApprovalTeamsResponseApprovalTeam;

pub const ListApprovalTeamsInput = struct {
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
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListApprovalTeamsOutput = struct {
    /// An array of `ListApprovalTeamsResponseApprovalTeam` objects. Contains
    /// details for approval teams.
    approval_teams: ?[]const ListApprovalTeamsResponseApprovalTeam = null,

    /// If present, indicates that more output is available than is included in the
    /// current response. Use this value in the `NextToken` request parameter in a
    /// next call to the operation to get more output. You can repeat this until the
    /// `NextToken` response element returns `null`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_teams = "ApprovalTeams",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApprovalTeamsInput, options: CallOptions) !ListApprovalTeamsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApprovalTeamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mpa", "MPA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/approval-teams/";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "List");
    query_has_prev = true;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApprovalTeamsOutput {
    var result: ListApprovalTeamsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListApprovalTeamsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
