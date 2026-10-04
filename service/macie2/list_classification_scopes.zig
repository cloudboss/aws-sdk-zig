const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClassificationScopeSummary = @import("classification_scope_summary.zig").ClassificationScopeSummary;

pub const ListClassificationScopesInput = struct {
    /// The name of the classification scope to retrieve the unique identifier for.
    name: ?[]const u8 = null,

    /// The nextToken string that specifies which page of results to return in a
    /// paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .next_token = "nextToken",
    };
};

pub const ListClassificationScopesOutput = struct {
    /// An array that specifies the unique identifier and name of the classification
    /// scope for the account.
    classification_scopes: ?[]const ClassificationScopeSummary = null,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .classification_scopes = "classificationScopes",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClassificationScopesInput, options: CallOptions) !ListClassificationScopesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClassificationScopesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/classification-scopes";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClassificationScopesOutput {
    const result: ListClassificationScopesOutput = try aws.json.parseJsonObject(
        ListClassificationScopesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
