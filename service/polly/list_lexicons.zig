const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LexiconDescription = @import("lexicon_description.zig").LexiconDescription;

pub const ListLexiconsInput = struct {
    /// An opaque pagination token returned from previous
    /// `ListLexicons` operation. If present, indicates where to
    /// continue the list of lexicons.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
    };
};

pub const ListLexiconsOutput = struct {
    /// A list of lexicon names and attributes.
    lexicons: ?[]const LexiconDescription = null,

    /// The pagination token to use in the next request to continue the
    /// listing of lexicons. `NextToken` is returned only if the
    /// response is truncated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .lexicons = "Lexicons",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLexiconsInput, options: CallOptions) !ListLexiconsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "polly", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLexiconsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("polly", "Polly", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/lexicons";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLexiconsOutput {
    var result: ListLexiconsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListLexiconsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
