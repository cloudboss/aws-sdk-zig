const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;
const IntegrationResponse = @import("integration_response.zig").IntegrationResponse;
const ResponseTransferMode = @import("response_transfer_mode.zig").ResponseTransferMode;
const TlsConfig = @import("tls_config.zig").TlsConfig;
const IntegrationType = @import("integration_type.zig").IntegrationType;

pub const GetIntegrationInput = struct {
    /// Specifies a get integration request's HTTP method.
    http_method: []const u8,

    /// Specifies a get integration request's resource identifier
    resource_id: []const u8,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .http_method = "httpMethod",
        .resource_id = "resourceId",
        .rest_api_id = "restApiId",
    };
};

pub const GetIntegrationOutput = struct {
    /// A list of request parameters whose values API Gateway caches. To be valid
    /// values for `cacheKeyParameters`, these parameters must also be specified for
    /// Method `requestParameters`.
    cache_key_parameters: ?[]const []const u8 = null,

    /// Specifies a group of related cached parameters. By default, API Gateway uses
    /// the resource ID as the `cacheNamespace`. You can specify the same
    /// `cacheNamespace` across resources to return the same cached data for
    /// requests to different resources.
    cache_namespace: ?[]const u8 = null,

    /// The ID of the VpcLink used for the integration when
    /// `connectionType=VPC_LINK` and undefined, otherwise.
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

    /// Specifies the credentials required for the integration, if any. For AWS
    /// integrations, three options are available. To specify an IAM Role for API
    /// Gateway to assume, use the role's Amazon Resource Name (ARN). To require
    /// that the caller's identity be passed through from the request, specify the
    /// string `arn:aws:iam::\*:user/\*`. To use resource-based permissions on
    /// supported Amazon Web Services services, specify null.
    credentials: ?[]const u8 = null,

    /// Specifies the integration's HTTP method type. For the Type property, if you
    /// specify `MOCK`, this property is optional. For Lambda integrations, you must
    /// set the integration method to `POST`. For all other types, you must specify
    /// this property.
    http_method: ?[]const u8 = null,

    /// Specifies the integration's responses.
    integration_responses: ?[]const aws.map.MapEntry(IntegrationResponse) = null,

    /// The ALB or NLB listener to send the request to.
    integration_target: ?[]const u8 = null,

    /// Specifies how the method request body of an unmapped content type will be
    /// passed through
    /// the integration request to the back end without transformation. A content
    /// type is unmapped if
    /// no mapping template is defined in the integration or the content type does
    /// not match any of
    /// the mapped content types, as specified in `requestTemplates`. The valid
    /// value is one of the
    /// following: `WHEN_NO_MATCH`: passes the method request body through the
    /// integration request to
    /// the back end without transformation when the method request content type
    /// does not match any
    /// content type associated with the mapping templates defined in the
    /// integration request.
    /// `WHEN_NO_TEMPLATES`: passes the method request body through the integration
    /// request to the back
    /// end without transformation when no mapping template is defined in the
    /// integration request. If
    /// a template is defined when this option is selected, the method request of an
    /// unmapped
    /// content-type will be rejected with an HTTP 415 Unsupported Media Type
    /// response. `NEVER`: rejects
    /// the method request with an HTTP 415 Unsupported Media Type response when
    /// either the method
    /// request content type does not match any content type associated with the
    /// mapping templates
    /// defined in the integration request or no mapping template is defined in the
    /// integration
    /// request.
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

    /// The response transfer mode of the integration.
    response_transfer_mode: ?ResponseTransferMode = null,

    /// Custom timeout between 50 and 29,000 milliseconds. The default value is
    /// 29,000 milliseconds or 29 seconds. You can increase the default value to
    /// longer than 29 seconds for Regional or private APIs only.
    timeout_in_millis: i32 = 0,

    /// Specifies the TLS configuration for an integration.
    tls_config: ?TlsConfig = null,

    /// Specifies an API method integration type. The valid value is one of the
    /// following:
    ///
    /// For the HTTP and HTTP proxy integrations, each integration can specify a
    /// protocol (`http/https`), port and path. Standard 80 and 443 ports are
    /// supported as well as custom ports above 1024. An HTTP or HTTP proxy
    /// integration with a `connectionType` of `VPC_LINK` is referred to as a
    /// private integration and uses a VpcLink to connect API Gateway to a network
    /// load balancer of a VPC.
    type: ?IntegrationType = null,

    /// Specifies Uniform Resource Identifier (URI) of the integration endpoint.
    ///
    /// For `HTTP` or `HTTP_PROXY` integrations, the URI must be a fully formed,
    /// encoded HTTP(S) URL
    /// according to the RFC-3986 specification for standard integrations. If
    /// `connectionType` is `VPC_LINK` specify the Network Load Balancer DNS name.
    /// For `AWS` or `AWS_PROXY` integrations, the URI is of
    /// the form
    /// `arn:aws:apigateway:{region}:{subdomain.service|service}:path|action/{service_api}`.
    /// Here, {Region} is the API Gateway region (e.g., us-east-1); {service} is the
    /// name of the
    /// integrated Amazon Web Services service (e.g., s3); and {subdomain} is a
    /// designated subdomain supported by
    /// certain Amazon Web Services service for fast host-name lookup. action can be
    /// used for an Amazon Web Services service
    /// action-based API, using an Action={name}&{p1}={v1}&p2={v2}... query string.
    /// The ensuing
    /// {service_api} refers to a supported action {name} plus any required input
    /// parameters.
    /// Alternatively, path can be used for an Amazon Web Services service
    /// path-based API. The ensuing service_api
    /// refers to the path to an Amazon Web Services service resource, including the
    /// region of the integrated Amazon Web Services
    /// service, if applicable. For example, for integration with the S3 API of
    /// GetObject, the uri can
    /// be either
    /// `arn:aws:apigateway:us-west-2:s3:action/GetObject&Bucket={bucket}&Key={key}`
    /// or
    /// `arn:aws:apigateway:us-west-2:s3:path/{bucket}/{key}`
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_key_parameters = "cacheKeyParameters",
        .cache_namespace = "cacheNamespace",
        .connection_id = "connectionId",
        .connection_type = "connectionType",
        .content_handling = "contentHandling",
        .credentials = "credentials",
        .http_method = "httpMethod",
        .integration_responses = "integrationResponses",
        .integration_target = "integrationTarget",
        .passthrough_behavior = "passthroughBehavior",
        .request_parameters = "requestParameters",
        .request_templates = "requestTemplates",
        .response_transfer_mode = "responseTransferMode",
        .timeout_in_millis = "timeoutInMillis",
        .tls_config = "tlsConfig",
        .type = "type",
        .uri = "uri",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIntegrationInput, options: Options) !GetIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/restapis/");
    try path_buf.appendSlice(alloc, input.rest_api_id);
    try path_buf.appendSlice(alloc, "/resources/");
    try path_buf.appendSlice(alloc, input.resource_id);
    try path_buf.appendSlice(alloc, "/methods/");
    try path_buf.appendSlice(alloc, input.http_method);
    try path_buf.appendSlice(alloc, "/integration");
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetIntegrationOutput {
    var result: GetIntegrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetIntegrationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
