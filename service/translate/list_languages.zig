const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisplayLanguageCode = @import("display_language_code.zig").DisplayLanguageCode;
const Language = @import("language.zig").Language;

pub const ListLanguagesInput = struct {
    /// The language code for the language to use to display the language names in
    /// the response.
    /// The language code is `en` by default.
    display_language_code: ?DisplayLanguageCode = null,

    /// The maximum number of results to return in each response.
    max_results: ?i32 = null,

    /// Include the NextToken value to fetch the next group of supported languages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_language_code = "DisplayLanguageCode",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListLanguagesOutput = struct {
    /// The language code passed in with the request.
    display_language_code: ?DisplayLanguageCode = null,

    /// The list of supported languages.
    languages: ?[]const Language = null,

    /// If the response does not include all remaining results, use the NextToken
    /// in the next request to fetch the next group of supported languages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_language_code = "DisplayLanguageCode",
        .languages = "Languages",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLanguagesInput, options: CallOptions) !ListLanguagesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLanguagesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSShineFrontendService_20170701.ListLanguages");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLanguagesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLanguagesOutput, body, allocator);
}
