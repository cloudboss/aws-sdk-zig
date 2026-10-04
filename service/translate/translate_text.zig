const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "translate", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TranslateTextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("translate", "Translate", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
