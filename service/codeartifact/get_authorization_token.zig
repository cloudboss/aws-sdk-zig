const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetAuthorizationTokenInput = struct {
    /// The name of the domain that is in scope for the generated authorization
    /// token.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The time, in seconds, that the generated authorization token is valid. Valid
    /// values are
    /// `0` and any number between `900` (15 minutes) and `43200` (12 hours).
    /// A value of `0` will set the expiration of the authorization token to the
    /// same expiration of
    /// the user's role's temporary credentials.
    duration_seconds: ?i64 = null,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .duration_seconds = "durationSeconds",
    };
};

pub const GetAuthorizationTokenOutput = struct {
    /// The returned authentication token.
    authorization_token: ?[]const u8 = null,

    /// A timestamp that specifies the date and time the authorization token
    /// expires.
    expiration: ?i64 = null,

    pub const json_field_names = .{
        .authorization_token = "authorizationToken",
        .expiration = "expiration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAuthorizationTokenInput, options: CallOptions) !GetAuthorizationTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeartifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAuthorizationTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/authorization-token";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "domain=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.domain);
    query_has_prev = true;
    if (input.domain_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domain-owner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.duration_seconds) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "duration=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAuthorizationTokenOutput {
    var result: GetAuthorizationTokenOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAuthorizationTokenOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
