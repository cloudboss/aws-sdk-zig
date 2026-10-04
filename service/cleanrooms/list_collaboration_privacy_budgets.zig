const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivacyBudgetType = @import("privacy_budget_type.zig").PrivacyBudgetType;
const CollaborationPrivacyBudgetSummary = @import("collaboration_privacy_budget_summary.zig").CollaborationPrivacyBudgetSummary;

pub const ListCollaborationPrivacyBudgetsInput = struct {
    /// The Amazon Resource Name (ARN) of the Configured Table Association
    /// (ConfiguredTableAssociation) used to filter privacy budgets.
    access_budget_resource_arn: ?[]const u8 = null,

    /// A unique identifier for one of your collaborations.
    collaboration_identifier: []const u8,

    /// The maximum number of results that are returned for an API request call. The
    /// service chooses a default number if you don't set one. The service might
    /// return a `nextToken` even if the `maxResults` value has not been met.
    max_results: ?i32 = null,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    /// Specifies the type of the privacy budget.
    privacy_budget_type: PrivacyBudgetType,

    pub const json_field_names = .{
        .access_budget_resource_arn = "accessBudgetResourceArn",
        .collaboration_identifier = "collaborationIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .privacy_budget_type = "privacyBudgetType",
    };
};

pub const ListCollaborationPrivacyBudgetsOutput = struct {
    /// Summaries of the collaboration privacy budgets.
    collaboration_privacy_budget_summaries: ?[]const CollaborationPrivacyBudgetSummary = null,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .collaboration_privacy_budget_summaries = "collaborationPrivacyBudgetSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCollaborationPrivacyBudgetsInput, options: CallOptions) !ListCollaborationPrivacyBudgetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCollaborationPrivacyBudgetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/privacybudgets");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.access_budget_resource_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "accessBudgetResourceArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "privacyBudgetType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.privacy_budget_type.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCollaborationPrivacyBudgetsOutput {
    var result: ListCollaborationPrivacyBudgetsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListCollaborationPrivacyBudgetsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
