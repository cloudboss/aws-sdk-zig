const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Evaluation = @import("evaluation.zig").Evaluation;
const PolicyInfo = @import("policy_info.zig").PolicyInfo;

pub const GetRequestAuthorizationDetailsInput = struct {
    /// The authorization ID received in the access denied error message. This ID
    /// identifies the specific request to retrieve details for.
    authorization_id: []const u8,

    /// The pagination token from a previous call, used to retrieve the next page of
    /// evaluations. Omit this value on the first call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_id = "authorizationId",
        .next_token = "nextToken",
    };
};

pub const GetRequestAuthorizationDetailsOutput = struct {
    /// The list of evaluations for this request. Each evaluation shows how a single
    /// action and resource pair was evaluated. This includes the context, the
    /// effect, and any policies that matched.
    evaluations: ?[]const Evaluation = null,

    /// The pagination token for retrieving the next page of evaluations. This value
    /// is absent when there are no more results.
    next_token: ?[]const u8 = null,

    /// The list of policies that were evaluated.
    policies: ?[]const PolicyInfo = null,

    /// The request context is the set of context keys and values that apply to the
    /// entire request and are shared by all evaluations.
    request_context: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .evaluations = "evaluations",
        .next_token = "nextToken",
        .policies = "policies",
        .request_context = "requestContext",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRequestAuthorizationDetailsInput, options: CallOptions) !GetRequestAuthorizationDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRequestAuthorizationDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam-toolbox", "IAM Toolbox", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/authorization-details/");
    try path_buf.appendSlice(allocator, input.authorization_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRequestAuthorizationDetailsOutput {
    const result: GetRequestAuthorizationDetailsOutput = try aws.json.parseJsonObject(
        GetRequestAuthorizationDetailsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
