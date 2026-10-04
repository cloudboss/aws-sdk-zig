const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Engine = @import("engine.zig").Engine;
const LanguageCode = @import("language_code.zig").LanguageCode;
const Voice = @import("voice.zig").Voice;

pub const DescribeVoicesInput = struct {
    /// Specifies the engine (`standard`, `neural`,
    /// `long-form` or `generative`) used by Amazon Polly when
    /// processing input text for speech synthesis.
    engine: ?Engine = null,

    /// Boolean value indicating whether to return any bilingual voices that
    /// use the specified language as an additional language. For instance, if you
    /// request all languages that use US English (es-US), and there is an Italian
    /// voice that speaks both Italian (it-IT) and US English, that voice will be
    /// included if you specify `yes` but not if you specify
    /// `no`.
    include_additional_language_codes: ?bool = null,

    /// The language identification tag (ISO 639 code for the language
    /// name-ISO 3166 country code) for filtering the list of voices returned. If
    /// you don't specify this optional parameter, all available voices are
    /// returned.
    language_code: ?LanguageCode = null,

    /// An opaque pagination token returned from the previous
    /// `DescribeVoices` operation. If present, this indicates where
    /// to continue the listing.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .engine = "Engine",
        .include_additional_language_codes = "IncludeAdditionalLanguageCodes",
        .language_code = "LanguageCode",
        .next_token = "NextToken",
    };
};

pub const DescribeVoicesOutput = struct {
    /// The pagination token to use in the next request to continue the
    /// listing of voices. `NextToken` is returned only if the response
    /// is truncated.
    next_token: ?[]const u8 = null,

    /// A list of voices with their properties.
    voices: ?[]const Voice = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .voices = "Voices",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVoicesInput, options: CallOptions) !DescribeVoicesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVoicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("polly", "Polly", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/voices";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.engine) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Engine=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.include_additional_language_codes) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "IncludeAdditionalLanguageCodes=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.language_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "LanguageCode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeVoicesOutput {
    var result: DescribeVoicesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeVoicesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
