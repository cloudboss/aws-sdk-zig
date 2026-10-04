const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyEngineSummary = @import("policy_engine_summary.zig").PolicyEngineSummary;

pub const ListPolicyEngineSummariesInput = struct {
    /// The maximum number of policy engine summaries to return in a single
    /// response.
    max_results: ?i32 = null,

    /// A pagination token returned from a previous
    /// [ListPolicyEngineSummaries](https://docs.aws.amazon.com/bedrock-agentcore-control/latest/APIReference/API_ListPolicyEngineSummaries.html) call. Use this token to retrieve the next page of results when the response is paginated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListPolicyEngineSummariesOutput = struct {
    /// A pagination token that can be used in subsequent
    /// [ListPolicyEngineSummaries](https://docs.aws.amazon.com/bedrock-agentcore-control/latest/APIReference/API_ListPolicyEngineSummaries.html) calls to retrieve additional results. This token is only present when there are more results available.
    next_token: ?[]const u8 = null,

    /// An array of policy engine summary objects that exist in the account. Each
    /// summary contains resource identifiers, status, and timestamps without
    /// customer-encrypted content.
    policy_engines: ?[]const PolicyEngineSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .policy_engines = "policyEngines",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPolicyEngineSummariesInput, options: CallOptions) !ListPolicyEngineSummariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPolicyEngineSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/policy-engine-summaries";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPolicyEngineSummariesOutput {
    const result: ListPolicyEngineSummariesOutput = try aws.json.parseJsonObject(
        ListPolicyEngineSummariesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
