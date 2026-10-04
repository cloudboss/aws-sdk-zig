const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const TestCustomDataIdentifierInput = struct {
    /// An array that lists specific character sequences (*ignore words*) to exclude
    /// from the results. If the text matched by the regular expression contains any
    /// string in this array, Amazon Macie ignores it. The array can contain as many
    /// as 10 ignore words. Each ignore word can contain 4-90 UTF-8 characters.
    /// Ignore words are case sensitive.
    ignore_words: ?[]const []const u8 = null,

    /// An array that lists specific character sequences (*keywords*), one of which
    /// must precede and be within proximity (maximumMatchDistance) of the regular
    /// expression to match. The array can contain as many as 50 keywords. Each
    /// keyword can contain 3-90 UTF-8 characters. Keywords aren't case sensitive.
    keywords: ?[]const []const u8 = null,

    /// The maximum number of characters that can exist between the end of at least
    /// one complete character sequence specified by the keywords array and the end
    /// of the text that matches the regex pattern. If a complete keyword precedes
    /// all the text that matches the pattern and the keyword is within the
    /// specified distance, Amazon Macie includes the result. The distance can be
    /// 1-300 characters. The default value is 50.
    maximum_match_distance: ?i32 = null,

    /// The regular expression (*regex*) that defines the pattern to match. The
    /// expression can contain as many as 512 characters.
    regex: []const u8,

    /// The sample text to inspect by using the custom data identifier. The text can
    /// contain as many as 1,000 characters.
    sample_text: []const u8,

    pub const json_field_names = .{
        .ignore_words = "ignoreWords",
        .keywords = "keywords",
        .maximum_match_distance = "maximumMatchDistance",
        .regex = "regex",
        .sample_text = "sampleText",
    };
};

pub const TestCustomDataIdentifierOutput = struct {
    /// The number of occurrences of sample text that matched the criteria specified
    /// by the custom data identifier.
    match_count: ?i32 = null,

    pub const json_field_names = .{
        .match_count = "matchCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestCustomDataIdentifierInput, options: CallOptions) !TestCustomDataIdentifierOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestCustomDataIdentifierInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/custom-data-identifiers/test";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ignore_words) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ignoreWords\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.keywords) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"keywords\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_match_distance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maximumMatchDistance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"regex\":");
    try aws.json.writeValue(@TypeOf(input.regex), input.regex, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sampleText\":");
    try aws.json.writeValue(@TypeOf(input.sample_text), input.sample_text, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestCustomDataIdentifierOutput {
    var result: TestCustomDataIdentifierOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(TestCustomDataIdentifierOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
