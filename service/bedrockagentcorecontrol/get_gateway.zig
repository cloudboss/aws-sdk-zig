const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;
const CustomTransformConfiguration = @import("custom_transform_configuration.zig").CustomTransformConfiguration;
const ExceptionLevel = @import("exception_level.zig").ExceptionLevel;
const GatewayInterceptorConfiguration = @import("gateway_interceptor_configuration.zig").GatewayInterceptorConfiguration;
const GatewayPolicyEngineConfiguration = @import("gateway_policy_engine_configuration.zig").GatewayPolicyEngineConfiguration;
const GatewayProtocolConfiguration = @import("gateway_protocol_configuration.zig").GatewayProtocolConfiguration;
const GatewayProtocolType = @import("gateway_protocol_type.zig").GatewayProtocolType;
const GatewayStatus = @import("gateway_status.zig").GatewayStatus;
const WafConfiguration = @import("waf_configuration.zig").WafConfiguration;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const GetGatewayInput = struct {
    /// The identifier of the gateway to retrieve.
    gateway_identifier: []const u8,

    pub const json_field_names = .{
        .gateway_identifier = "gatewayIdentifier",
    };
};

pub const GetGatewayOutput = struct {
    /// The authorizer configuration for the gateway.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// Authorizer type for the gateway.
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

    /// The Amazon Resource Name (ARN) of the gateway.
    gateway_arn: []const u8,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// An endpoint for invoking gateway.
    gateway_url: ?[]const u8 = null,

    /// The interceptors configured on the gateway.
    interceptor_configurations: ?[]const GatewayInterceptorConfiguration = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the gateway.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the gateway.
    name: []const u8,

    /// The policy engine configuration for the gateway.
    policy_engine_configuration: ?GatewayPolicyEngineConfiguration = null,

    protocol_configuration: ?GatewayProtocolConfiguration = null,

    /// Protocol applied to a gateway.
    protocol_type: ?GatewayProtocolType = null,

    /// The IAM role ARN that provides permissions for the gateway.
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

    /// The workload identity details for the gateway.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGatewayInput, options: CallOptions) !GetGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGatewayOutput {
    const result: GetGatewayOutput = try aws.json.parseJsonObject(
        GetGatewayOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
