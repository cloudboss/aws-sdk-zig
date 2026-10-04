const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VocabularyLanguageCode = @import("vocabulary_language_code.zig").VocabularyLanguageCode;
const VocabularyState = @import("vocabulary_state.zig").VocabularyState;
const VocabularySummary = @import("vocabulary_summary.zig").VocabularySummary;

pub const SearchVocabulariesInput = struct {
    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The language code of the vocabulary entries. For a list of languages and
    /// their corresponding language codes, see
    /// [What is Amazon
    /// Transcribe?](https://docs.aws.amazon.com/transcribe/latest/dg/transcribe-whatis.html)
    language_code: ?VocabularyLanguageCode = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The starting pattern of the name of the vocabulary.
    name_starts_with: ?[]const u8 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The current state of the custom vocabulary.
    state: ?VocabularyState = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .language_code = "LanguageCode",
        .max_results = "MaxResults",
        .name_starts_with = "NameStartsWith",
        .next_token = "NextToken",
        .state = "State",
    };
};

pub const SearchVocabulariesOutput = struct {
    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// The list of the available custom vocabularies.
    vocabulary_summary_list: ?[]const VocabularySummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .vocabulary_summary_list = "VocabularySummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchVocabulariesInput, options: CallOptions) !SearchVocabulariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchVocabulariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/vocabulary-summary/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.language_code) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LanguageCode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name_starts_with) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NameStartsWith\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"State\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchVocabulariesOutput {
    var result: SearchVocabulariesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchVocabulariesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
