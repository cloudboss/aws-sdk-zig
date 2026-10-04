const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCode = @import("language_code.zig").LanguageCode;

pub const GetVocabularyFilterInput = struct {
    /// The name of the custom vocabulary filter you want information about. Custom
    /// vocabulary
    /// filter names are case sensitive.
    vocabulary_filter_name: []const u8,

    pub const json_field_names = .{
        .vocabulary_filter_name = "VocabularyFilterName",
    };
};

pub const GetVocabularyFilterOutput = struct {
    /// The Amazon S3 location where the custom vocabulary filter is stored; use
    /// this
    /// URI to view or download the custom vocabulary filter.
    download_uri: ?[]const u8 = null,

    /// The language code you selected for your custom vocabulary filter.
    language_code: ?LanguageCode = null,

    /// The date and time the specified custom vocabulary filter was last modified.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents 12:32 PM UTC-7 on May
    /// 4, 2022.
    last_modified_time: ?i64 = null,

    /// The name of the custom vocabulary filter you requested information about.
    vocabulary_filter_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .download_uri = "DownloadUri",
        .language_code = "LanguageCode",
        .last_modified_time = "LastModifiedTime",
        .vocabulary_filter_name = "VocabularyFilterName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVocabularyFilterInput, options: CallOptions) !GetVocabularyFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transcribe", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVocabularyFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.GetVocabularyFilter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVocabularyFilterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetVocabularyFilterOutput, body, allocator);
}
