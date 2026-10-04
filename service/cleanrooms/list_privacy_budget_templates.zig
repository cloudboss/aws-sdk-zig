const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivacyBudgetTemplateSummary = @import("privacy_budget_template_summary.zig").PrivacyBudgetTemplateSummary;

pub const ListPrivacyBudgetTemplatesInput = struct {
    /// The maximum number of results that are returned for an API request call. The
    /// service chooses a default number if you don't set one. The service might
    /// return a `nextToken` even if the `maxResults` value has not been met.
    max_results: ?i32 = null,

    /// A unique identifier for one of your memberships for a collaboration. The
    /// privacy budget templates are retrieved from the collaboration that this
    /// membership belongs to. Accepts a membership ID.
    membership_identifier: []const u8,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .membership_identifier = "membershipIdentifier",
        .next_token = "nextToken",
    };
};

pub const ListPrivacyBudgetTemplatesOutput = struct {
    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    /// An array that summarizes the privacy budget templates. The summary includes
    /// collaboration information, creation information, and privacy budget type.
    privacy_budget_template_summaries: ?[]const PrivacyBudgetTemplateSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .privacy_budget_template_summaries = "privacyBudgetTemplateSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPrivacyBudgetTemplatesInput, options: CallOptions) !ListPrivacyBudgetTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPrivacyBudgetTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/privacybudgettemplates");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPrivacyBudgetTemplatesOutput {
    var result: ListPrivacyBudgetTemplatesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPrivacyBudgetTemplatesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
