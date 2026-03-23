const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "polly");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVoicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("polly", "Polly", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/voices";

    var query_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "EngineNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .engine_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLexiconException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lexicon_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KeyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_key_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSampleRateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sample_rate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnsTopicArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_topic_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSsmlException")) {
        return .{ .arena = arena, .kind = .{ .invalid_ssml_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTaskIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_task_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LanguageNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .language_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LexiconNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .lexicon_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LexiconSizeExceededException")) {
        return .{ .arena = arena, .kind = .{ .lexicon_size_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MarksNotSupportedForFormatException")) {
        return .{ .arena = arena, .kind = .{ .marks_not_supported_for_format_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxLexemeLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_lexeme_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxLexiconsNumberExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_lexicons_number_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SsmlMarksNotSupportedForTextTypeException")) {
        return .{ .arena = arena, .kind = .{ .ssml_marks_not_supported_for_text_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SynthesisTaskNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .synthesis_task_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TextLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .text_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlsAlphabetException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pls_alphabet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlsLanguageException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pls_language_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
