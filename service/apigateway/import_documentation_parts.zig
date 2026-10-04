const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PutMode = @import("put_mode.zig").PutMode;

pub const ImportDocumentationPartsInput = struct {
    /// Raw byte array representing the to-be-imported documentation parts. To
    /// import from an OpenAPI file, this is a JSON object.
    body: []const u8,

    /// A query parameter to specify whether to rollback the documentation
    /// importation (`true`) or not (`false`) when a warning is encountered. The
    /// default value is `false`.
    fail_on_warnings: ?bool = null,

    /// A query parameter to indicate whether to overwrite (`overwrite`) any
    /// existing DocumentationParts definition or to merge (`merge`) the new
    /// definition into the existing one. The default value is `merge`.
    mode: ?PutMode = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .body = "body",
        .fail_on_warnings = "failOnWarnings",
        .mode = "mode",
        .rest_api_id = "restApiId",
    };
};

pub const ImportDocumentationPartsOutput = struct {
    /// A list of the returned documentation part identifiers.
    ids: ?[]const []const u8 = null,

    /// A list of warning messages reported during import of documentation parts.
    warnings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ids = "ids",
        .warnings = "warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportDocumentationPartsInput, options: CallOptions) !ImportDocumentationPartsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportDocumentationPartsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/documentation/parts");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.fail_on_warnings) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "failonwarnings=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.mode) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "mode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.body;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportDocumentationPartsOutput {
    const result: ImportDocumentationPartsOutput = try aws.json.parseJsonObject(
        ImportDocumentationPartsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
