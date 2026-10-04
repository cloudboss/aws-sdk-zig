const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCode = @import("language_code.zig").LanguageCode;
const PiiEntity = @import("pii_entity.zig").PiiEntity;

pub const DetectPiiEntitiesInput = struct {
    /// The language of the input text.
    /// Enter the language code for English (en) or Spanish (es).
    language_code: LanguageCode,

    /// A UTF-8 text string. The maximum string size is 100 KB.
    text: []const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .text = "Text",
    };
};

pub const DetectPiiEntitiesOutput = struct {
    /// A collection of PII entities identified in the input text. For each entity,
    /// the response
    /// provides the entity type, where the entity text begins and ends, and the
    /// level of confidence
    /// that Amazon Comprehend has in the detection.
    entities: ?[]const PiiEntity = null,

    pub const json_field_names = .{
        .entities = "Entities",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectPiiEntitiesInput, options: CallOptions) !DetectPiiEntitiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectPiiEntitiesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DetectPiiEntities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectPiiEntitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectPiiEntitiesOutput, body, allocator);
}
