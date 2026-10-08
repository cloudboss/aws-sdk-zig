const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;
const ExceptionLevel = @import("exception_level.zig").ExceptionLevel;
const GatewayInterceptorConfiguration = @import("gateway_interceptor_configuration.zig").GatewayInterceptorConfiguration;
const GatewayPolicyEngineConfiguration = @import("gateway_policy_engine_configuration.zig").GatewayPolicyEngineConfiguration;
const GatewayProtocolConfiguration = @import("gateway_protocol_configuration.zig").GatewayProtocolConfiguration;
const GatewayProtocolType = @import("gateway_protocol_type.zig").GatewayProtocolType;
const CustomTransformConfiguration = @import("custom_transform_configuration.zig").CustomTransformConfiguration;
const GatewayStatus = @import("gateway_status.zig").GatewayStatus;
const WafConfiguration = @import("waf_configuration.zig").WafConfiguration;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const CreateGatewayInput = struct {
    /// The authorizer configuration for the gateway. Required if `authorizerType`
    /// is `CUSTOM_JWT`.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer to use for the gateway.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    /// * `NONE` - No authorization
    authorizer_type: AuthorizerType,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The description of the gateway.
    description: ?[]const u8 = null,

    /// The level of detail in error messages returned when invoking the gateway.
    ///
    /// * If the value is `DEBUG`, granular exception messages are returned to help
    ///   a user debug the gateway.
    /// * If the value is omitted, a generic error message is returned to the end
    ///   user.
    exception_level: ?ExceptionLevel = null,

    /// A list of configuration settings for a gateway interceptor. Gateway
    /// interceptors allow custom code to be invoked during gateway invocations.
    interceptor_configurations: ?[]const GatewayInterceptorConfiguration = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt data
    /// associated with the gateway.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the gateway. The name must be unique within your account.
    name: []const u8,

    /// The policy engine configuration for the gateway. A policy engine is a
    /// collection of policies that evaluates and authorizes agent tool calls. When
    /// associated with a gateway, the policy engine intercepts all agent requests
    /// and determines whether to allow or deny each action based on the defined
    /// policies.
    policy_engine_configuration: ?GatewayPolicyEngineConfiguration = null,

    /// The configuration settings for the protocol specified in the `protocolType`
    /// parameter.
    protocol_configuration: ?GatewayProtocolConfiguration = null,

    /// The protocol type for the gateway.
    protocol_type: ?GatewayProtocolType = null,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the gateway to access Amazon Web Services services.
    role_arn: []const u8,

    /// A map of key-value pairs to associate with the gateway as metadata tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .client_token = "clientToken",
        .description = "description",
        .exception_level = "exceptionLevel",
        .interceptor_configurations = "interceptorConfigurations",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .policy_engine_configuration = "policyEngineConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .protocol_type = "protocolType",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateGatewayOutput = struct {
    /// The authorizer configuration for the created gateway.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer used by the gateway.
    authorizer_type: AuthorizerType,

    /// The timestamp when the gateway was created.
    created_at: i64,

    /// The custom transformation configuration for the gateway. This configuration
    /// defines how the gateway transforms requests and responses.
    custom_transform_configuration: ?CustomTransformConfiguration = null,

    /// The description of the gateway.
    description: ?[]const u8 = null,

    /// The level of detail in error messages returned when invoking the gateway.
    ///
    /// * If the value is `DEBUG`, granular exception messages are returned to help
    ///   a user debug the gateway.
    /// * If the value is omitted, a generic error message is returned to the end
    ///   user.
    exception_level: ?ExceptionLevel = null,

    /// The Amazon Resource Name (ARN) of the created gateway.
    gateway_arn: []const u8,

    /// The unique identifier of the created gateway.
    gateway_id: []const u8,

    /// The URL endpoint for the created gateway.
    gateway_url: ?[]const u8 = null,

    /// The list of interceptor configurations for the created gateway.
    interceptor_configurations: ?[]const GatewayInterceptorConfiguration = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt data
    /// associated with the gateway.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the gateway.
    name: []const u8,

    /// The policy engine configuration for the created gateway.
    policy_engine_configuration: ?GatewayPolicyEngineConfiguration = null,

    /// The configuration settings for the protocol used by the gateway.
    protocol_configuration: ?GatewayProtocolConfiguration = null,

    /// The protocol type of the gateway.
    protocol_type: ?GatewayProtocolType = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the gateway.
    role_arn: ?[]const u8 = null,

    /// The current status of the gateway.
    status: GatewayStatus,

    /// The reasons for the current status of the gateway.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the gateway was last updated.
    updated_at: i64,

    /// The Amazon Web Services WAF configuration for the gateway.
    waf_configuration: ?WafConfiguration = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services WAF web ACL
    /// associated with the gateway.
    web_acl_arn: ?[]const u8 = null,

    /// The workload identity details for the created gateway.
    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .custom_transform_configuration = "customTransformConfiguration",
        .description = "description",
        .exception_level = "exceptionLevel",
        .gateway_arn = "gatewayArn",
        .gateway_id = "gatewayId",
        .gateway_url = "gatewayUrl",
        .interceptor_configurations = "interceptorConfigurations",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .policy_engine_configuration = "policyEngineConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .protocol_type = "protocolType",
        .role_arn = "roleArn",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
        .waf_configuration = "wafConfiguration",
        .web_acl_arn = "webAclArn",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGatewayInput, options: CallOptions) !CreateGatewayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/gateways/";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authorizer_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authorizerType\":");
    try aws.json.writeValue(@TypeOf(input.authorizer_type), input.authorizer_type, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.exception_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"exceptionLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.interceptor_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"interceptorConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.policy_engine_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyEngineConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.protocol_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"protocolConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.protocol_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"protocolType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGatewayOutput {
    const result: CreateGatewayOutput = try aws.json.parseJsonObject(
        CreateGatewayOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
