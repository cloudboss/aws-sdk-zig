const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PutMode = @import("put_mode.zig").PutMode;
const ApiKeySourceType = @import("api_key_source_type.zig").ApiKeySourceType;
const ApiStatus = @import("api_status.zig").ApiStatus;
const EndpointAccessMode = @import("endpoint_access_mode.zig").EndpointAccessMode;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;

pub const PutRestApiInput = struct {
    /// The PUT request body containing external API definitions. Currently, only
    /// OpenAPI definition JSON/YAML files are supported. The maximum size of the
    /// API definition file is 6MB.
    body: []const u8,

    /// A query parameter to indicate whether to rollback the API update (`true`) or
    /// not (`false`)
    /// when a warning is encountered. The default value is `false`.
    fail_on_warnings: ?bool = null,

    /// The `mode` query parameter to specify the update mode. Valid values are
    /// "merge" and "overwrite". By default,
    /// the update mode is "merge".
    mode: ?PutMode = null,

    /// Custom header parameters as part of the request. For example, to exclude
    /// DocumentationParts from an imported API, set `ignore=documentation` as a
    /// `parameters` value, as in the AWS CLI command of `aws apigateway
    /// import-rest-api --parameters ignore=documentation --body
    /// 'file:///path/to/imported-api-body.json'`.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .body = "body",
        .fail_on_warnings = "failOnWarnings",
        .mode = "mode",
        .parameters = "parameters",
        .rest_api_id = "restApiId",
    };
};

pub const PutRestApiOutput = @import("rest_api.zig").RestApi;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRestApiInput, options: CallOptions) !PutRestApiOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRestApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRestApiOutput {
    var result: PutRestApiOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutRestApiOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
