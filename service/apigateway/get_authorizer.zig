const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;

pub const GetAuthorizerInput = struct {
    /// The identifier of the Authorizer resource.
    authorizer_id: []const u8,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .authorizer_id = "authorizerId",
        .rest_api_id = "restApiId",
    };
};

pub const GetAuthorizerOutput = struct {
    /// Specifies the required credentials as an IAM role for API Gateway to invoke
    /// the authorizer. To specify an IAM role for API Gateway to assume, use the
    /// role's Amazon Resource Name (ARN). To use resource-based permissions on the
    /// Lambda function, specify null.
    authorizer_credentials: ?[]const u8 = null,

    /// The TTL in seconds of cached authorizer results. If it equals 0,
    /// authorization caching is disabled. If it is greater than 0, API Gateway will
    /// cache authorizer responses. If this field is not set, the default value is
    /// 300. The maximum value is 3600, or 1 hour.
    authorizer_result_ttl_in_seconds: ?i32 = null,

    /// Specifies the authorizer's Uniform Resource Identifier (URI). For `TOKEN` or
    /// `REQUEST` authorizers, this must be a well-formed Lambda function URI, for
    /// example,
    /// `arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:{account_id}:function:{lambda_function_name}/invocations`. In general, the URI has this form `arn:aws:apigateway:{region}:lambda:path/{service_api}`, where `{region}` is the same as the region hosting the Lambda function, `path` indicates that the remaining substring in the URI should be treated as the path to the resource, including the initial `/`. For Lambda functions, this is usually of the form `/2015-03-31/functions/[FunctionARN]/invocations`.
    authorizer_uri: ?[]const u8 = null,

    /// Optional customer-defined field, used in OpenAPI imports and exports without
    /// functional impact.
    auth_type: ?[]const u8 = null,

    /// The identifier for the authorizer resource.
    id: ?[]const u8 = null,

    /// The identity source for which authorization is requested. For a `TOKEN` or
    /// `COGNITO_USER_POOLS` authorizer, this is required and specifies the request
    /// header mapping expression for the custom header holding the authorization
    /// token submitted by
    /// the client. For example, if the token header name is `Auth`, the header
    /// mapping expression is
    /// `method.request.header.Auth`. For the `REQUEST` authorizer, this is required
    /// when authorization
    /// caching is enabled. The value is a comma-separated string of one or more
    /// mapping expressions
    /// of the specified request parameters. For example, if an `Auth` header, a
    /// `Name` query string
    /// parameter are defined as identity sources, this value is
    /// `method.request.header.Auth`,
    /// `method.request.querystring.Name`. These parameters will be used to derive
    /// the authorization
    /// caching key and to perform runtime validation of the `REQUEST` authorizer by
    /// verifying all of
    /// the identity-related request parameters are present, not null and non-empty.
    /// Only when this is
    /// true does the authorizer invoke the authorizer Lambda function, otherwise,
    /// it returns a 401
    /// Unauthorized response without calling the Lambda function. The valid value
    /// is a string of
    /// comma-separated mapping expressions of the specified request parameters.
    /// When the
    /// authorization caching is not enabled, this property is optional.
    identity_source: ?[]const u8 = null,

    /// A validation expression for the incoming identity token. For `TOKEN`
    /// authorizers, this value is a regular expression. For `COGNITO_USER_POOLS`
    /// authorizers, API Gateway will match the `aud` field of the incoming token
    /// from the client against the specified regular expression. It will invoke the
    /// authorizer's Lambda function when there is a match. Otherwise, it will
    /// return a 401 Unauthorized response without calling the Lambda function. The
    /// validation expression does not apply to the `REQUEST` authorizer.
    identity_validation_expression: ?[]const u8 = null,

    /// The name of the authorizer.
    name: ?[]const u8 = null,

    /// A list of the Amazon Cognito user pool ARNs for the `COGNITO_USER_POOLS`
    /// authorizer. Each element is of this format:
    /// `arn:aws:cognito-idp:{region}:{account_id}:userpool/{user_pool_id}`. For a
    /// `TOKEN` or `REQUEST` authorizer, this is not defined.
    provider_ar_ns: ?[]const []const u8 = null,

    /// The authorizer type. Valid values are `TOKEN` for a Lambda function using a
    /// single authorization token submitted in a custom header, `REQUEST` for a
    /// Lambda function using incoming request parameters, and `COGNITO_USER_POOLS`
    /// for using an Amazon Cognito user pool.
    type: ?AuthorizerType = null,

    pub const json_field_names = .{
        .authorizer_credentials = "authorizerCredentials",
        .authorizer_result_ttl_in_seconds = "authorizerResultTtlInSeconds",
        .authorizer_uri = "authorizerUri",
        .auth_type = "authType",
        .id = "id",
        .identity_source = "identitySource",
        .identity_validation_expression = "identityValidationExpression",
        .name = "name",
        .provider_ar_ns = "providerARNs",
        .type = "type",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAuthorizerInput, options: Options) !GetAuthorizerOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetAuthorizerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/restapis/");
    try path_buf.appendSlice(alloc, input.rest_api_id);
    try path_buf.appendSlice(alloc, "/authorizers/");
    try path_buf.appendSlice(alloc, input.authorizer_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetAuthorizerOutput {
    var result: GetAuthorizerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAuthorizerOutput, body, alloc);
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
