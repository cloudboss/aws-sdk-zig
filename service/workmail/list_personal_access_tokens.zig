const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PersonalAccessTokenSummary = @import("personal_access_token_summary.zig").PersonalAccessTokenSummary;

pub const ListPersonalAccessTokensInput = struct {
    /// The maximum amount of items that should be returned in a response.
    max_results: ?i32 = null,

    /// The token from the previous response to query the next page.
    next_token: ?[]const u8 = null,

    /// The Organization ID.
    organization_id: []const u8,

    /// The WorkMail User ID.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .organization_id = "OrganizationId",
        .user_id = "UserId",
    };
};

pub const ListPersonalAccessTokensOutput = struct {
    /// The token from the previous response to query the next page.
    next_token: ?[]const u8 = null,

    /// Lists all the personal tokens in an organization or user, if user ID is
    /// provided.
    personal_access_token_summaries: ?[]const PersonalAccessTokenSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .personal_access_token_summaries = "PersonalAccessTokenSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPersonalAccessTokensInput, options: CallOptions) !ListPersonalAccessTokensOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPersonalAccessTokensInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.ListPersonalAccessTokens");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPersonalAccessTokensOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPersonalAccessTokensOutput, body, allocator);
}
