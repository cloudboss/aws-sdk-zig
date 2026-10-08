const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DictionaryLanguage = @import("dictionary_language.zig").DictionaryLanguage;
const DictionaryStatus = @import("dictionary_status.zig").DictionaryStatus;

pub const GetDictionaryInput = struct {
    /// The ID of the dictionary to retrieve.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetDictionaryOutput = struct {
    /// The ARN of the dictionary.
    arn: []const u8,

    /// The ID of the dictionary.
    id: []const u8,

    /// The language of the dictionary.
    language: DictionaryLanguage,

    /// The name of the dictionary.
    name: []const u8,

    /// A list of feed IDs that reference this dictionary.
    references: ?[]const []const u8 = null,

    /// The current status of the dictionary.
    status: DictionaryStatus,

    /// The tags associated with the dictionary.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDictionaryInput, options: CallOptions) !GetDictionaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDictionaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/dictionary/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDictionaryOutput {
    const result: GetDictionaryOutput = try aws.json.parseJsonObject(
        GetDictionaryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
