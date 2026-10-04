const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiKeysFormat = @import("api_keys_format.zig").ApiKeysFormat;

pub const ImportApiKeysInput = struct {
    /// The payload of the POST request to import API keys. For the payload format,
    /// see API Key File Format.
    body: []const u8,

    /// A query parameter to indicate whether to rollback ApiKey importation
    /// (`true`) or not (`false`) when error is encountered.
    fail_on_warnings: ?bool = null,

    /// A query parameter to specify the input format to imported API keys.
    /// Currently, only the `csv` format is supported.
    format: ApiKeysFormat,

    pub const json_field_names = .{
        .body = "body",
        .fail_on_warnings = "failOnWarnings",
        .format = "format",
    };
};

pub const ImportApiKeysOutput = struct {
    /// A list of all the ApiKey identifiers.
    ids: ?[]const []const u8 = null,

    /// A list of warning messages.
    warnings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ids = "ids",
        .warnings = "warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportApiKeysInput, options: CallOptions) !ImportApiKeysOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportApiKeysInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apikeys";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "mode=import");
    query_has_prev = true;
    if (input.fail_on_warnings) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "failonwarnings=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "format=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.format.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.body;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportApiKeysOutput {
    var result: ImportApiKeysOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ImportApiKeysOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
