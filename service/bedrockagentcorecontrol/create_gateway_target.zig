const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateConfiguration = @import("certificate_configuration.zig").CertificateConfiguration;
const CredentialProviderConfiguration = @import("credential_provider_configuration.zig").CredentialProviderConfiguration;
const MetadataConfiguration = @import("metadata_configuration.zig").MetadataConfiguration;
const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;
const AuthorizationData = @import("authorization_data.zig").AuthorizationData;
const ManagedResourceDetails = @import("managed_resource_details.zig").ManagedResourceDetails;
const TargetProtocolType = @import("target_protocol_type.zig").TargetProtocolType;
const TargetStatus = @import("target_status.zig").TargetStatus;

pub const CreateGatewayTargetInput = struct {
    /// The private certificate authority (CA) configurations for the gateway
    /// target. Use this to have the gateway trust a private CA when it establishes
    /// TLS connections to the target endpoint. Provide each certificate by
    /// reference to an Amazon S3 object or an Amazon Web Services Secrets Manager
    /// secret. You can specify only one certificate authority configuration in this
    /// list.
    certificate_configurations: ?[]const CertificateConfiguration = null,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The credential provider configurations for the target. These configurations
    /// specify how the gateway authenticates with the target endpoint.
    credential_provider_configurations: ?[]const CredentialProviderConfiguration = null,

    /// The description of the gateway target.
    description: ?[]const u8 = null,

    /// The identifier of the gateway to create a target for.
    gateway_identifier: []const u8,

    /// Optional configuration for HTTP header and query parameter propagation to
    /// and from the gateway target.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The name of the gateway target. The name must be unique within the gateway.
    name: ?[]const u8 = null,

    /// The private endpoint configuration for the gateway target. Use this to
    /// connect the gateway to private resources in your VPC.
    private_endpoint: ?PrivateEndpoint = null,

    /// The configuration settings for the target, including endpoint information
    /// and schema definitions.
    target_configuration: TargetConfiguration,

    pub const json_field_names = .{
        .certificate_configurations = "certificateConfigurations",
        .client_token = "clientToken",
        .credential_provider_configurations = "credentialProviderConfigurations",
        .description = "description",
        .gateway_identifier = "gatewayIdentifier",
        .metadata_configuration = "metadataConfiguration",
        .name = "name",
        .private_endpoint = "privateEndpoint",
        .target_configuration = "targetConfiguration",
    };
};

pub const CreateGatewayTargetOutput = struct {
    /// OAuth2 authorization data for the created gateway target. This data is
    /// returned when a target is configured with a credential provider with
    /// authorization code grant type and requires user federation.
    authorization_data: ?AuthorizationData = null,

    /// The private certificate authority (CA) configurations for the gateway
    /// target.
    certificate_configurations: ?[]const CertificateConfiguration = null,

    /// The timestamp when the target was created.
    created_at: i64,

    /// The credential provider configurations for the target.
    credential_provider_configurations: ?[]const CredentialProviderConfiguration = null,

    /// The description of the target.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the gateway.
    gateway_arn: []const u8,

    /// The last synchronization of the target.
    last_synchronized_at: ?i64 = null,

    /// The metadata configuration that was applied to the created gateway target.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The name of the target.
    name: []const u8,

    /// The private endpoint configuration for the gateway target.
    private_endpoint: ?PrivateEndpoint = null,

    /// The managed resources created by the gateway for private endpoint
    /// connectivity.
    private_endpoint_managed_resources: ?[]const ManagedResourceDetails = null,

    /// The protocol type of the created gateway target.
    protocol_type: ?TargetProtocolType = null,

    /// The current status of the target.
    status: TargetStatus,

    /// The reasons for the current status of the target.
    status_reasons: ?[]const []const u8 = null,

    /// The configuration settings for the target.
    target_configuration: ?TargetConfiguration = null,

    /// The unique identifier of the created target.
    target_id: []const u8,

    /// The timestamp when the target was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .authorization_data = "authorizationData",
        .certificate_configurations = "certificateConfigurations",
        .created_at = "createdAt",
        .credential_provider_configurations = "credentialProviderConfigurations",
        .description = "description",
        .gateway_arn = "gatewayArn",
        .last_synchronized_at = "lastSynchronizedAt",
        .metadata_configuration = "metadataConfiguration",
        .name = "name",
        .private_endpoint = "privateEndpoint",
        .private_endpoint_managed_resources = "privateEndpointManagedResources",
        .protocol_type = "protocolType",
        .status = "status",
        .status_reasons = "statusReasons",
        .target_configuration = "targetConfiguration",
        .target_id = "targetId",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGatewayTargetInput, options: CallOptions) !CreateGatewayTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGatewayTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/targets/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.certificate_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.credential_provider_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"credentialProviderConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.private_endpoint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"privateEndpoint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.target_configuration), input.target_configuration, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGatewayTargetOutput {
    const result: CreateGatewayTargetOutput = try aws.json.parseJsonObject(
        CreateGatewayTargetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
