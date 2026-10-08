const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DictionaryLanguage = @import("dictionary_language.zig").DictionaryLanguage;
const DictionaryStatus = @import("dictionary_status.zig").DictionaryStatus;

pub const CreateDictionaryInput = struct {
    /// The dictionary entries payload. Contains the custom words and phrases for
    /// the dictionary. Maximum size is 40,960 characters.
    entries: ?[]const u8 = null,

    /// The language of the dictionary entries. Specify the language using an ISO
    /// 639-2/T three-letter code. Supported values: eng, fra, ita, deu, spa, por.
    language: DictionaryLanguage,

    /// A user-friendly name for this dictionary.
    name: []const u8,

    /// Optional tags to associate with the dictionary.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .entries = "entries",
        .language = "language",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateDictionaryOutput = struct {
    /// The ARN of the dictionary.
    arn: []const u8,

    /// A unique ID that Elemental Inference assigns to the dictionary.
    id: []const u8,

    /// The language of the dictionary.
    language: DictionaryLanguage,

    /// The name that you specified in the request.
    name: []const u8,

    /// A list of feed IDs that reference this dictionary.
    references: ?[]const []const u8 = null,

    /// The current status of the dictionary. After creation succeeds, the status
    /// will be AVAILABLE.
    status: DictionaryStatus,

    /// Any tags that you included when you created the dictionary.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .language = "language",
        .name = "name",
        .references = "references",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDictionaryInput, options: CallOptions) !CreateDictionaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elemental-inference", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDictionaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/dictionary";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.entries) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entries\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"language\":");
    try aws.json.writeValue(@TypeOf(input.language), input.language, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDictionaryOutput {
    const result: CreateDictionaryOutput = try aws.json.parseJsonObject(
        CreateDictionaryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
