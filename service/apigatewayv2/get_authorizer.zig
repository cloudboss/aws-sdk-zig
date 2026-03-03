const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;
const JWTConfiguration = @import("jwt_configuration.zig").JWTConfiguration;

pub const GetAuthorizerInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The authorizer identifier.
    authorizer_id: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .authorizer_id = "AuthorizerId",
    };
};

pub const GetAuthorizerOutput = struct {
    /// Specifies the required credentials as an IAM role for API Gateway to invoke
    /// the authorizer. To specify an IAM role for API Gateway to assume, use the
    /// role's Amazon Resource Name (ARN). To use resource-based permissions on the
    /// Lambda function, don't specify this parameter. Supported only for REQUEST
    /// authorizers.
    authorizer_credentials_arn: ?[]const u8 = null,

    /// The authorizer identifier.
    authorizer_id: ?[]const u8 = null,

    /// Specifies the format of the payload sent to an HTTP API Lambda authorizer.
    /// Required for HTTP API Lambda authorizers. Supported values are 1.0 and 2.0.
    /// To learn more, see [Working with AWS Lambda authorizers for HTTP
    /// APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-lambda-authorizer.html).
    authorizer_payload_format_version: ?[]const u8 = null,

    /// The time to live (TTL) for cached authorizer results, in seconds. If it
    /// equals 0, authorization caching is disabled. If it is greater than 0, API
    /// Gateway caches authorizer responses. The maximum value is 3600, or 1 hour.
    /// Supported only for HTTP API Lambda authorizers.
    authorizer_result_ttl_in_seconds: ?i32 = null,

    /// The authorizer type. Specify REQUEST for a Lambda function using incoming
    /// request parameters. Specify JWT to use JSON Web Tokens (supported only for
    /// HTTP APIs).
    authorizer_type: ?AuthorizerType = null,

    /// The authorizer's Uniform Resource Identifier (URI). For REQUEST authorizers,
    /// this must be a well-formed Lambda function URI, for example,
    /// arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:{account_id}:function:{lambda_function_name}/invocations. In general, the URI has this form: arn:aws:apigateway:{region}:lambda:path/{service_api}
    /// , where {region} is the same as the region hosting the Lambda function, path
    /// indicates that the remaining substring in the URI should be treated as the
    /// path to the resource, including the initial /. For Lambda functions, this is
    /// usually of the form /2015-03-31/functions/[FunctionARN]/invocations.
    /// Supported only for REQUEST authorizers.
    authorizer_uri: ?[]const u8 = null,

    /// Specifies whether a Lambda authorizer returns a response in a simple format.
    /// If enabled, the Lambda authorizer can return a boolean value instead of an
    /// IAM policy. Supported only for HTTP APIs. To learn more, see [Working with
    /// AWS Lambda authorizers for HTTP
    /// APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-lambda-authorizer.html)
    enable_simple_responses: ?bool = null,

    /// The identity source for which authorization is requested.
    ///
    /// For a REQUEST authorizer, this is optional. The value is a set of one or
    /// more mapping expressions of the specified request parameters. The identity
    /// source can be headers, query string parameters, stage variables, and context
    /// parameters. For example, if an Auth header and a Name query string parameter
    /// are defined as identity sources, this value is route.request.header.Auth,
    /// route.request.querystring.Name for WebSocket APIs. For HTTP APIs, use
    /// selection expressions prefixed with $, for example, $request.header.Auth,
    /// $request.querystring.Name. These parameters are used to perform runtime
    /// validation for Lambda-based authorizers by verifying all of the
    /// identity-related request parameters are present in the request, not null,
    /// and non-empty. Only when this is true does the authorizer invoke the
    /// authorizer Lambda function. Otherwise, it returns a 401 Unauthorized
    /// response without calling the Lambda function. For HTTP APIs, identity
    /// sources are also used as the cache key when caching is enabled. To learn
    /// more, see [Working with AWS Lambda authorizers for HTTP
    /// APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-lambda-authorizer.html).
    ///
    /// For JWT, a single entry that specifies where to extract the JSON Web Token
    /// (JWT) from inbound requests. Currently only header-based and query
    /// parameter-based selections are supported, for example
    /// $request.header.Authorization.
    identity_source: ?[]const []const u8 = null,

    /// The validation expression does not apply to the REQUEST authorizer.
    identity_validation_expression: ?[]const u8 = null,

    /// Represents the configuration of a JWT authorizer. Required for the JWT
    /// authorizer type. Supported only for HTTP APIs.
    jwt_configuration: ?JWTConfiguration = null,

    /// The name of the authorizer.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorizer_credentials_arn = "AuthorizerCredentialsArn",
        .authorizer_id = "AuthorizerId",
        .authorizer_payload_format_version = "AuthorizerPayloadFormatVersion",
        .authorizer_result_ttl_in_seconds = "AuthorizerResultTtlInSeconds",
        .authorizer_type = "AuthorizerType",
        .authorizer_uri = "AuthorizerUri",
        .enable_simple_responses = "EnableSimpleResponses",
        .identity_source = "IdentitySource",
        .identity_validation_expression = "IdentityValidationExpression",
        .jwt_configuration = "JwtConfiguration",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAuthorizerInput, options: CallOptions) !GetAuthorizerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigatewayv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAuthorizerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigatewayv2", "ApiGatewayV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/authorizers/");
    try path_buf.appendSlice(allocator, input.authorizer_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAuthorizerOutput {
    var result: GetAuthorizerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAuthorizerOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
