const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const TranslationSettings = @import("translation_settings.zig").TranslationSettings;
const AppliedTerminology = @import("applied_terminology.zig").AppliedTerminology;

pub const TranslateTextInput = struct {
    /// Settings to configure your translation output. You can configure the
    /// following options:
    ///
    /// * Brevity: reduces the length of the translated output for most
    ///   translations.
    ///
    /// * Formality: sets the formality level of the output text.
    ///
    /// * Profanity: masks profane words and phrases in your translation output.
    settings: ?TranslationSettings = null,

    /// The language code for the language of the source text. For a list of
    /// language codes, see [Supported
    /// languages](https://docs.aws.amazon.com/translate/latest/dg/what-is-languages.html).
    ///
    /// To have Amazon Translate determine the source language of your text, you can
    /// specify
    /// `auto` in the `SourceLanguageCode` field. If you specify
    /// `auto`, Amazon Translate will call [Amazon
    /// Comprehend](https://docs.aws.amazon.com/comprehend/latest/dg/comprehend-general.html) to determine the source language.
    ///
    /// If you specify `auto`, you must send the `TranslateText` request in a region
    /// that supports
    /// Amazon Comprehend. Otherwise, the request returns an error indicating that
    /// autodetect is not supported.
    source_language_code: []const u8,

    /// The language code requested for the language of the target text.
    /// For a list of language codes, see [Supported
    /// languages](https://docs.aws.amazon.com/translate/latest/dg/what-is-languages.html).
    target_language_code: []const u8,

    /// The name of a terminology list file to add to the translation job. This file
    /// provides source terms and the desired translation for each term.
    /// A terminology list can contain a maximum of 256 terms.
    /// You can use one custom terminology resource in your translation request.
    ///
    /// Use the ListTerminologies operation
    /// to get the available terminology lists.
    ///
    /// For more information about custom terminology lists, see [Custom
    /// terminology](https://docs.aws.amazon.com/translate/latest/dg/how-custom-terminology.html).
    terminology_names: ?[]const []const u8 = null,

    /// The text to translate. The text string can be a maximum of 10,000 bytes
    /// long. Depending on
    /// your character set, this may be fewer than 10,000 characters.
    text: []const u8,

    pub const json_field_names = .{
        .settings = "Settings",
        .source_language_code = "SourceLanguageCode",
        .target_language_code = "TargetLanguageCode",
        .terminology_names = "TerminologyNames",
        .text = "Text",
    };
};

pub const TranslateTextOutput = struct {
    /// Optional settings that modify the translation output.
    applied_settings: ?TranslationSettings = null,

    /// The names of the custom terminologies applied to the input text by Amazon
    /// Translate for the
    /// translated text response.
    applied_terminologies: ?[]const AppliedTerminology = null,

    /// The language code for the language of the source text.
    source_language_code: []const u8,

    /// The language code for the language of the target text.
    target_language_code: []const u8,

    /// The translated text.
    translated_text: []const u8,

    pub const json_field_names = .{
        .applied_settings = "AppliedSettings",
        .applied_terminologies = "AppliedTerminologies",
        .source_language_code = "SourceLanguageCode",
        .target_language_code = "TargetLanguageCode",
        .translated_text = "TranslatedText",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TranslateTextInput, options: CallOptions) !TranslateTextOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "translate");

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

fn serializeRequest(allocator: std.mem.Allocator, input: TranslateTextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("translate", "Translate", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShineFrontendService_20170701.TranslateText");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TranslateTextOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(TranslateTextOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DetectedLanguageLowConfidenceException")) {
        return .{ .arena = arena, .kind = .{ .detected_language_low_confidence_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_filter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TextSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .text_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedDisplayLanguageCodeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_display_language_code_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedLanguagePairException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_language_pair_exception = .{
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
