const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCode = @import("language_code.zig").LanguageCode;
const EntityLabel = @import("entity_label.zig").EntityLabel;

pub const ContainsPiiEntitiesInput = struct {
    /// The language of the input documents.
    language_code: LanguageCode,

    /// A UTF-8 text string. The maximum string size is 100 KB.
    text: []const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .text = "Text",
    };
};

pub const ContainsPiiEntitiesOutput = struct {
    /// The labels used in the document being analyzed. Individual labels represent
    /// personally
    /// identifiable information (PII) entity types.
    labels: ?[]const EntityLabel = null,

    pub const json_field_names = .{
        .labels = "Labels",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ContainsPiiEntitiesInput, options: CallOptions) !ContainsPiiEntitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ContainsPiiEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.ContainsPiiEntities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ContainsPiiEntitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ContainsPiiEntitiesOutput, body, allocator);
}
