const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Lexicon = @import("lexicon.zig").Lexicon;
const LexiconAttributes = @import("lexicon_attributes.zig").LexiconAttributes;

pub const GetLexiconInput = struct {
    /// Name of the lexicon.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetLexiconOutput = struct {
    /// Lexicon object that provides name and the string content of the
    /// lexicon.
    lexicon: ?Lexicon = null,

    /// Metadata of the lexicon, including phonetic alphabetic used,
    /// language code, lexicon ARN, number of lexemes defined in the lexicon, and
    /// size of lexicon in bytes.
    lexicon_attributes: ?LexiconAttributes = null,

    pub const json_field_names = .{
        .lexicon = "Lexicon",
        .lexicon_attributes = "LexiconAttributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLexiconInput, options: CallOptions) !GetLexiconOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLexiconInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("polly", "Polly", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/lexicons/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLexiconOutput {
    const result: GetLexiconOutput = try aws.json.parseJsonObject(
        GetLexiconOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
