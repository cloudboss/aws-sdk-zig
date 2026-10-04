const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExportApiInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The version of the API Gateway export algorithm. API Gateway uses the latest
    /// version by default. Currently, the only supported version is 1.0.
    export_version: ?[]const u8 = null,

    /// Specifies whether to include [API Gateway
    /// extensions](https://docs.aws.amazon.com//apigateway/latest/developerguide/api-gateway-swagger-extensions.html) in the exported API definition. API Gateway extensions are included by default.
    include_extensions: ?bool = null,

    /// The output type of the exported definition file. Valid values are JSON and
    /// YAML.
    output_type: []const u8,

    /// The version of the API specification to use. OAS30, for OpenAPI 3.0, is the
    /// only supported value.
    specification: []const u8,

    /// The name of the API stage to export. If you don't specify this property, a
    /// representation of the latest API configuration is exported.
    stage_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .export_version = "ExportVersion",
        .include_extensions = "IncludeExtensions",
        .output_type = "OutputType",
        .specification = "Specification",
        .stage_name = "StageName",
    };
};

pub const ExportApiOutput = struct {
    body: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "body",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportApiInput, options: CallOptions) !ExportApiOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/exports/");
    try path_buf.appendSlice(allocator, input.specification);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.export_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "exportVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.include_extensions) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeExtensions=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "outputType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.output_type);
    query_has_prev = true;
    if (input.stage_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "stageName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportApiOutput {
    var result: ExportApiOutput = .{};
    errdefer {
        if (result.body) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.body = try allocator.dupe(u8, body);
    }
    _ = status;
    _ = headers;

    return result;
}
