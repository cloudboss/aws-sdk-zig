const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;

pub const CreateAuthorizerInput = struct {
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

    /// The identity source for which authorization is requested. For a `TOKEN` or
    /// `COGNITO_USER_POOLS` authorizer, this is required and specifies the request
    /// header mapping expression for the custom header holding the authorization
    /// token submitted by
    /// the client. For example, if the token header name is `Auth`, the header
    /// mapping
    /// expression is `method.request.header.Auth`. For the `REQUEST`
    /// authorizer, this is required when authorization caching is enabled. The
    /// value is a
    /// comma-separated string of one or more mapping expressions of the specified
    /// request parameters.
    /// For example, if an `Auth` header, a `Name` query string parameter are
    /// defined as identity sources, this value is `method.request.header.Auth,
    /// method.request.querystring.Name`. These parameters will be used to derive
    /// the
    /// authorization caching key and to perform runtime validation of the `REQUEST`
    /// authorizer by verifying all of the identity-related request parameters are
    /// present, not null
    /// and non-empty. Only when this is true does the authorizer invoke the
    /// authorizer Lambda
    /// function, otherwise, it returns a 401 Unauthorized response without calling
    /// the Lambda
    /// function. The valid value is a string of comma-separated mapping expressions
    /// of the specified
    /// request parameters. When the authorization caching is not enabled, this
    /// property is
    /// optional.
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
    name: []const u8,

    /// A list of the Amazon Cognito user pool ARNs for the `COGNITO_USER_POOLS`
    /// authorizer. Each element is of this format:
    /// `arn:aws:cognito-idp:{region}:{account_id}:userpool/{user_pool_id}`. For a
    /// `TOKEN` or `REQUEST` authorizer, this is not defined.
    provider_ar_ns: ?[]const []const u8 = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// The authorizer type. Valid values are `TOKEN` for a Lambda function using a
    /// single authorization token submitted in a custom header, `REQUEST` for a
    /// Lambda function using incoming request parameters, and `COGNITO_USER_POOLS`
    /// for using an Amazon Cognito user pool.
    type: AuthorizerType,

    pub const json_field_names = .{
        .authorizer_credentials = "authorizerCredentials",
        .authorizer_result_ttl_in_seconds = "authorizerResultTtlInSeconds",
        .authorizer_uri = "authorizerUri",
        .auth_type = "authType",
        .identity_source = "identitySource",
        .identity_validation_expression = "identityValidationExpression",
        .name = "name",
        .provider_ar_ns = "providerARNs",
        .rest_api_id = "restApiId",
        .type = "type",
    };
};

pub const CreateAuthorizerOutput = @import("authorizer.zig").Authorizer;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAuthorizerInput, options: CallOptions) !CreateAuthorizerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAuthorizerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/authorizers");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authorizer_credentials) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerCredentials\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.authorizer_result_ttl_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerResultTtlInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.authorizer_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"identitySource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_validation_expression) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"identityValidationExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.provider_ar_ns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"providerARNs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.type), input.type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAuthorizerOutput {
    const result: CreateAuthorizerOutput = try aws.json.parseJsonObject(
        CreateAuthorizerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
