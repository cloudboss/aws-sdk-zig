const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;
const ResponseTransferMode = @import("response_transfer_mode.zig").ResponseTransferMode;
const TlsConfig = @import("tls_config.zig").TlsConfig;
const IntegrationType = @import("integration_type.zig").IntegrationType;
const IntegrationResponse = @import("integration_response.zig").IntegrationResponse;

pub const PutIntegrationInput = struct {
    /// A list of request parameters whose values API Gateway caches. To be valid
    /// values for `cacheKeyParameters`, these parameters must also be specified for
    /// Method `requestParameters`.
    cache_key_parameters: ?[]const []const u8 = null,

    /// Specifies a group of related cached parameters. By default, API Gateway uses
    /// the resource ID as the `cacheNamespace`. You can specify the same
    /// `cacheNamespace` across resources to return the same cached data for
    /// requests to different resources.
    cache_namespace: ?[]const u8 = null,

    /// The ID of the VpcLink used for the integration. Specify this value only if
    /// you specify `VPC_LINK` as the connection type.
    connection_id: ?[]const u8 = null,

    /// The type of the network connection to the integration endpoint. The valid
    /// value is `INTERNET` for connections through the public routable internet or
    /// `VPC_LINK` for private connections between API Gateway and a network load
    /// balancer in a VPC. The default value is `INTERNET`.
    connection_type: ?ConnectionType = null,

    /// Specifies how to handle request payload content type conversions. Supported
    /// values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`, with the following
    /// behaviors:
    ///
    /// If this property is not defined, the request payload will be passed through
    /// from the method request to integration request without modification,
    /// provided that the `passthroughBehavior` is configured to support payload
    /// pass-through.
    content_handling: ?ContentHandlingStrategy = null,

    /// Specifies whether credentials are required for a put integration.
    credentials: ?[]const u8 = null,

    /// Specifies the HTTP method for the integration.
    http_method: []const u8,

    /// The HTTP method for the integration.
    integration_http_method: ?[]const u8 = null,

    /// The ALB or NLB listener to send the request to.
    integration_target: ?[]const u8 = null,

    /// Specifies the pass-through behavior for incoming requests based on the
    /// Content-Type header in the request, and the available mapping templates
    /// specified as the `requestTemplates` property on the Integration resource.
    /// There are three valid values: `WHEN_NO_MATCH`, `WHEN_NO_TEMPLATES`, and
    /// `NEVER`.
    passthrough_behavior: ?[]const u8 = null,

    /// A key-value map specifying request parameters that are passed from the
    /// method request to the back end. The key is an integration request parameter
    /// name and the associated value is a method request parameter value or static
    /// value that must be enclosed within single quotes and pre-encoded as required
    /// by the back end. The method request parameter value must match the pattern
    /// of `method.request.{location}.{name}`, where `location` is `querystring`,
    /// `path`, or `header` and `name` must be a valid and unique method request
    /// parameter name.
    request_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Represents a map of Velocity templates that are applied on the request
    /// payload based on the value of the Content-Type header sent by the client.
    /// The content type value is the key in this map, and the template (as a
    /// String) is the value.
    request_templates: ?[]const aws.map.StringMapEntry = null,

    /// Specifies a put integration request's resource ID.
    resource_id: []const u8,

    /// The response transfer mode of the integration.
    response_transfer_mode: ?ResponseTransferMode = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// Custom timeout between 50 and 29,000 milliseconds. The default value is
    /// 29,000 milliseconds or 29 seconds. You can increase the default value to
    /// longer than 29 seconds for Regional or private APIs only.
    timeout_in_millis: ?i32 = null,

    tls_config: ?TlsConfig = null,

    /// Specifies a put integration input's type.
    @"type": IntegrationType,

    /// Specifies Uniform Resource Identifier (URI) of the integration endpoint. For
    /// HTTP or
    /// `HTTP_PROXY` integrations, the URI must be a fully formed, encoded HTTP(S)
    /// URL according to the
    /// RFC-3986 specification, for either standard integration, where
    /// `connectionType` is not `VPC_LINK`,
    /// or private integration, where `connectionType` is `VPC_LINK`. For a private
    /// HTTP integration, the
    /// URI is not used for routing. For `AWS` or `AWS_PROXY` integrations, the URI
    /// is of the form
    /// `arn:aws:apigateway:{region}:{subdomain.service|service}:path|action/{service_api`}. Here,
    /// {Region} is the API Gateway region (e.g., us-east-1); {service} is the name
    /// of the integrated
    /// Amazon Web Services service (e.g., s3); and {subdomain} is a designated
    /// subdomain supported by certain Amazon Web Services
    /// service for fast host-name lookup. action can be used for an Amazon Web
    /// Services service action-based API,
    /// using an Action={name}&{p1}={v1}&p2={v2}... query string. The ensuing
    /// {service_api} refers to
    /// a supported action {name} plus any required input parameters. Alternatively,
    /// path can be used
    /// for an Amazon Web Services service path-based API. The ensuing service_api
    /// refers to the path to an Amazon Web Services
    /// service resource, including the region of the integrated Amazon Web Services
    /// service, if applicable. For
    /// example, for integration with the S3 API of `GetObject`, the `uri` can be
    /// either
    /// `arn:aws:apigateway:us-west-2:s3:action/GetObject&Bucket={bucket}&Key={key}`
    /// or
    /// `arn:aws:apigateway:us-west-2:s3:path/{bucket}/{key}`.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_key_parameters = "cacheKeyParameters",
        .cache_namespace = "cacheNamespace",
        .connection_id = "connectionId",
        .connection_type = "connectionType",
        .content_handling = "contentHandling",
        .credentials = "credentials",
        .http_method = "httpMethod",
        .integration_http_method = "integrationHttpMethod",
        .integration_target = "integrationTarget",
        .passthrough_behavior = "passthroughBehavior",
        .request_parameters = "requestParameters",
        .request_templates = "requestTemplates",
        .resource_id = "resourceId",
        .response_transfer_mode = "responseTransferMode",
        .rest_api_id = "restApiId",
        .timeout_in_millis = "timeoutInMillis",
        .tls_config = "tlsConfig",
        .@"type" = "type",
        .uri = "uri",
    };
};

pub const PutIntegrationOutput = @import("integration.zig").Integration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIntegrationInput, options: CallOptions) !PutIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/resources/");
    try path_buf.appendSlice(allocator, input.resource_id);
    try path_buf.appendSlice(allocator, "/methods/");
    try path_buf.appendSlice(allocator, input.http_method);
    try path_buf.appendSlice(allocator, "/integration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cache_key_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cacheKeyParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cache_namespace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cacheNamespace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connection_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connection_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectionType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.content_handling) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contentHandling\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.credentials) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"credentials\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.integration_http_method) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"integrationHttpMethod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.integration_target) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"integrationTarget\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.passthrough_behavior) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"passthroughBehavior\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"requestParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_templates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"requestTemplates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_transfer_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseTransferMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout_in_millis) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeoutInMillis\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tls_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tlsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;
    if (input.uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"uri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutIntegrationOutput {
    var result: PutIntegrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutIntegrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
