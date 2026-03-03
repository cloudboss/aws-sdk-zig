const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdditionalAuthenticationProvider = @import("additional_authentication_provider.zig").AdditionalAuthenticationProvider;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const EnhancedMetricsConfig = @import("enhanced_metrics_config.zig").EnhancedMetricsConfig;
const GraphQLApiIntrospectionConfig = @import("graph_ql_api_introspection_config.zig").GraphQLApiIntrospectionConfig;
const LambdaAuthorizerConfig = @import("lambda_authorizer_config.zig").LambdaAuthorizerConfig;
const LogConfig = @import("log_config.zig").LogConfig;
const OpenIDConnectConfig = @import("open_id_connect_config.zig").OpenIDConnectConfig;
const UserPoolConfig = @import("user_pool_config.zig").UserPoolConfig;
const GraphqlApi = @import("graphql_api.zig").GraphqlApi;

pub const UpdateGraphqlApiInput = struct {
    /// A list of additional authentication providers for the `GraphqlApi`
    /// API.
    additional_authentication_providers: ?[]const AdditionalAuthenticationProvider = null,

    /// The API ID.
    api_id: []const u8,

    /// The new authentication type for the `GraphqlApi` object.
    authentication_type: AuthenticationType,

    /// The `enhancedMetricsConfig` object.
    enhanced_metrics_config: ?EnhancedMetricsConfig = null,

    /// Sets the value of the GraphQL API to enable (`ENABLED`) or disable
    /// (`DISABLED`) introspection. If no value is provided, the introspection
    /// configuration will be set to `ENABLED` by default. This field will produce
    /// an
    /// error if the operation attempts to use the introspection feature while this
    /// field is
    /// disabled.
    ///
    /// For more information about introspection, see [GraphQL
    /// introspection](https://graphql.org/learn/introspection/).
    introspection_config: ?GraphQLApiIntrospectionConfig = null,

    /// Configuration for Lambda function authorization.
    lambda_authorizer_config: ?LambdaAuthorizerConfig = null,

    /// The Amazon CloudWatch Logs configuration for the `GraphqlApi` object.
    log_config: ?LogConfig = null,

    /// The Identity and Access Management service role ARN for a merged API. The
    /// AppSync
    /// service assumes this role on behalf of the Merged API to validate access to
    /// source APIs at
    /// runtime and to prompt the `AUTO_MERGE` to update the merged API endpoint
    /// with
    /// the source API changes automatically.
    merged_api_execution_role_arn: ?[]const u8 = null,

    /// The new name for the `GraphqlApi` object.
    name: []const u8,

    /// The OpenID Connect configuration for the `GraphqlApi` object.
    open_id_connect_config: ?OpenIDConnectConfig = null,

    /// The owner contact information for an API resource.
    ///
    /// This field accepts any string input with a length of 0 - 256 characters.
    owner_contact: ?[]const u8 = null,

    /// The maximum depth a query can have in a single request. Depth refers to the
    /// amount of
    /// nested levels allowed in the body of query. The default value is `0` (or
    /// unspecified), which indicates there's no depth limit. If you set a limit, it
    /// can be between
    /// `1` and `75` nested levels. This field will produce a limit error
    /// if the operation falls out of bounds.
    ///
    /// Note that fields can still be set to nullable or non-nullable. If a
    /// non-nullable field
    /// produces an error, the error will be thrown upwards to the first nullable
    /// field
    /// available.
    query_depth_limit: ?i32 = null,

    /// The maximum number of resolvers that can be invoked in a single request. The
    /// default
    /// value is `0` (or unspecified), which will set the limit to `10000`.
    /// When specified, the limit value can be between `1` and `10000`. This
    /// field will produce a limit error if the operation falls out of bounds.
    resolver_count_limit: ?i32 = null,

    /// The new Amazon Cognito user pool configuration for the `~GraphqlApi`
    /// object.
    user_pool_config: ?UserPoolConfig = null,

    /// A flag indicating whether to use X-Ray tracing for the
    /// `GraphqlApi`.
    xray_enabled: ?bool = null,

    pub const json_field_names = .{
        .additional_authentication_providers = "additionalAuthenticationProviders",
        .api_id = "apiId",
        .authentication_type = "authenticationType",
        .enhanced_metrics_config = "enhancedMetricsConfig",
        .introspection_config = "introspectionConfig",
        .lambda_authorizer_config = "lambdaAuthorizerConfig",
        .log_config = "logConfig",
        .merged_api_execution_role_arn = "mergedApiExecutionRoleArn",
        .name = "name",
        .open_id_connect_config = "openIDConnectConfig",
        .owner_contact = "ownerContact",
        .query_depth_limit = "queryDepthLimit",
        .resolver_count_limit = "resolverCountLimit",
        .user_pool_config = "userPoolConfig",
        .xray_enabled = "xrayEnabled",
    };
};

pub const UpdateGraphqlApiOutput = struct {
    /// The updated `GraphqlApi` object.
    graphql_api: ?GraphqlApi = null,

    pub const json_field_names = .{
        .graphql_api = "graphqlApi",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGraphqlApiInput, options: Options) !UpdateGraphqlApiOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appsync");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGraphqlApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v1/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_authentication_providers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalAuthenticationProviders\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authenticationType\":");
    try aws.json.writeValue(@TypeOf(input.authentication_type), input.authentication_type, allocator, &body_buf);
    has_prev = true;
    if (input.enhanced_metrics_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enhancedMetricsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.introspection_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"introspectionConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lambda_authorizer_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"lambdaAuthorizerConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.merged_api_execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mergedApiExecutionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.open_id_connect_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"openIDConnectConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.owner_contact) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ownerContact\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_depth_limit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryDepthLimit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resolver_count_limit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resolverCountLimit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_pool_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userPoolConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.xray_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"xrayEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGraphqlApiOutput {
    var result: UpdateGraphqlApiOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateGraphqlApiOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ApiKeyLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .api_key_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApiKeyValidityOutOfBoundsException")) {
        return .{ .arena = arena, .kind = .{ .api_key_validity_out_of_bounds_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApiLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .api_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
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
    if (std.mem.eql(u8, error_code, "GraphQLSchemaException")) {
        return .{ .arena = arena, .kind = .{ .graph_ql_schema_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
