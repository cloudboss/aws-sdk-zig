const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleGroupsNamespaceSummary = @import("rule_groups_namespace_summary.zig").RuleGroupsNamespaceSummary;

pub const ListRuleGroupsNamespacesInput = struct {
    /// The maximum number of results to return. The default is 100.
    max_results: ?i32 = null,

    /// Use this parameter to filter the rule groups namespaces that are returned.
    /// Only the namespaces with names that begin with the value that you specify
    /// are returned.
    name: ?[]const u8 = null,

    /// The token for the next set of items to return. You receive this token from a
    /// previous call, and use it to get the next page of results. The other
    /// parameters must be the same as the initial call.
    ///
    /// For example, if your initial request has `maxResults` of 10, and there are
    /// 12 rule groups namespaces to return, then your initial request will return
    /// 10 and a `nextToken`. Using the next token in a subsequent call will return
    /// the remaining 2 namespaces.
    next_token: ?[]const u8 = null,

    /// The ID of the workspace containing the rule groups namespaces.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .workspace_id = "workspaceId",
    };
};

pub const ListRuleGroupsNamespacesOutput = struct {
    /// A token indicating that there are more results to retrieve. You can use this
    /// token as part of your next `ListRuleGroupsNamespaces` request to retrieve
    /// those results.
    next_token: ?[]const u8 = null,

    /// The returned list of rule groups namespaces.
    rule_groups_namespaces: ?[]const RuleGroupsNamespaceSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .rule_groups_namespaces = "ruleGroupsNamespaces",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRuleGroupsNamespacesInput, options: CallOptions) !ListRuleGroupsNamespacesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRuleGroupsNamespacesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/rulegroupsnamespaces");
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
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRuleGroupsNamespacesOutput {
    var result: ListRuleGroupsNamespacesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRuleGroupsNamespacesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
