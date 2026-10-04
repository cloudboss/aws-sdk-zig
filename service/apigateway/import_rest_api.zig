const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiKeySourceType = @import("api_key_source_type.zig").ApiKeySourceType;
const ApiStatus = @import("api_status.zig").ApiStatus;
const EndpointAccessMode = @import("endpoint_access_mode.zig").EndpointAccessMode;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;

pub const ImportRestApiInput = struct {
    /// The POST request body containing external API definitions. Currently, only
    /// OpenAPI definition JSON/YAML files are supported. The maximum size of the
    /// API definition file is 6MB.
    body: []const u8,

    /// A query parameter to indicate whether to rollback the API creation (`true`)
    /// or not (`false`)
    /// when a warning is encountered. The default value is `false`.
    fail_on_warnings: ?bool = null,

    /// A key-value map of context-specific query string parameters specifying the
    /// behavior of different API importing operations. The following shows
    /// operation-specific parameters and their supported values.
    ///
    /// To exclude DocumentationParts from the import, set `parameters` as
    /// `ignore=documentation`.
    ///
    /// To configure the endpoint type, set `parameters` as
    /// `endpointConfigurationTypes=EDGE`, `endpointConfigurationTypes=REGIONAL`, or
    /// `endpointConfigurationTypes=PRIVATE`. The default endpoint type is `EDGE`.
    ///
    /// To handle imported `basepath`, set `parameters` as `basepath=ignore`,
    /// `basepath=prepend` or `basepath=split`.
    parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .body = "body",
        .fail_on_warnings = "failOnWarnings",
        .parameters = "parameters",
    };
};

pub const ImportRestApiOutput = @import("rest_api.zig").RestApi;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportRestApiInput, options: CallOptions) !ImportRestApiOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportRestApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/restapis";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportRestApiOutput {
    const result: ImportRestApiOutput = try aws.json.parseJsonObject(
        ImportRestApiOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
