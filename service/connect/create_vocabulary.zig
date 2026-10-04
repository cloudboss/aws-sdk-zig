const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VocabularyLanguageCode = @import("vocabulary_language_code.zig").VocabularyLanguageCode;
const VocabularyState = @import("vocabulary_state.zig").VocabularyState;

pub const CreateVocabularyInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/). If a create request is received more than once with same client token, subsequent requests return
    /// the previous response without creating a vocabulary again.
    client_token: ?[]const u8 = null,

    /// The content of the custom vocabulary in plain-text format with a table of
    /// values. Each row in the table
    /// represents a word or a phrase, described with `Phrase`, `IPA`, `SoundsLike`,
    /// and
    /// `DisplayAs` fields. Separate the fields with TAB characters. The size limit
    /// is 50KB. For more
    /// information, see [Create a custom vocabulary using a
    /// table](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary.html#create-vocabulary-table).
    content: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The language code of the vocabulary entries. For a list of languages and
    /// their corresponding language codes, see
    /// [What is Amazon
    /// Transcribe?](https://docs.aws.amazon.com/transcribe/latest/dg/transcribe-whatis.html)
    language_code: VocabularyLanguageCode,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A unique name of the custom vocabulary.
    vocabulary_name: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .content = "Content",
        .instance_id = "InstanceId",
        .language_code = "LanguageCode",
        .tags = "Tags",
        .vocabulary_name = "VocabularyName",
    };
};

pub const CreateVocabularyOutput = struct {
    /// The current state of the custom vocabulary.
    state: VocabularyState,

    /// The Amazon Resource Name (ARN) of the custom vocabulary.
    vocabulary_arn: []const u8,

    /// The identifier of the custom vocabulary.
    vocabulary_id: []const u8,

    pub const json_field_names = .{
        .state = "State",
        .vocabulary_arn = "VocabularyArn",
        .vocabulary_id = "VocabularyId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVocabularyInput, options: CallOptions) !CreateVocabularyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVocabularyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/vocabulary/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LanguageCode\":");
    try aws.json.writeValue(@TypeOf(input.language_code), input.language_code, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VocabularyName\":");
    try aws.json.writeValue(@TypeOf(input.vocabulary_name), input.vocabulary_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVocabularyOutput {
    var result: CreateVocabularyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateVocabularyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
