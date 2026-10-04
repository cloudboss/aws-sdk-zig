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

pub const UpdateGatewayTargetInput = struct {
    /// The private certificate authority (CA) configurations for the gateway
    /// target. Use this to have the gateway trust a private CA when it establishes
    /// TLS connections to the target endpoint. Provide each certificate by
    /// reference to an Amazon S3 object or an Amazon Web Services Secrets Manager
    /// secret. You can specify only one certificate authority configuration in this
    /// list. To remove a previously configured certificate authority, omit this
    /// field on update.
    certificate_configurations: ?[]const CertificateConfiguration = null,

    /// The updated credential provider configurations for the gateway target.
    credential_provider_configurations: ?[]const CredentialProviderConfiguration = null,

    /// The updated description for the gateway target.
    description: ?[]const u8 = null,

    /// The unique identifier of the gateway associated with the target.
    gateway_identifier: []const u8,

    /// Configuration for HTTP header and query parameter propagation to the gateway
    /// target.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The updated name for the gateway target.
    name: ?[]const u8 = null,

    /// The private endpoint configuration for the gateway target. Use this to
    /// connect the gateway to private resources in your VPC.
    private_endpoint: ?PrivateEndpoint = null,

    target_configuration: TargetConfiguration,

    /// The unique identifier of the gateway target to update.
    target_id: []const u8,

    pub const json_field_names = .{
        .certificate_configurations = "certificateConfigurations",
        .credential_provider_configurations = "credentialProviderConfigurations",
        .description = "description",
        .gateway_identifier = "gatewayIdentifier",
        .metadata_configuration = "metadataConfiguration",
        .name = "name",
        .private_endpoint = "privateEndpoint",
        .target_configuration = "targetConfiguration",
        .target_id = "targetId",
    };
};

pub const UpdateGatewayTargetOutput = struct {
    /// OAuth2 authorization data for the updated gateway target. This data is
    /// returned when a target is configured with a credential provider with
    /// authorization code grant type and requires user federation.
    authorization_data: ?AuthorizationData = null,

    /// The private certificate authority (CA) configurations for the gateway
    /// target.
    certificate_configurations: ?[]const CertificateConfiguration = null,

    /// The timestamp when the gateway target was created.
    created_at: i64,

    /// The updated credential provider configurations for the gateway target.
    credential_provider_configurations: ?[]const CredentialProviderConfiguration = null,

    /// The updated description of the gateway target.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the gateway.
    gateway_arn: []const u8,

    /// The date and time at which the targets were last synchronized.
    last_synchronized_at: ?i64 = null,

    /// The metadata configuration that was applied to the gateway target.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The updated name of the gateway target.
    name: []const u8,

    /// The private endpoint configuration for the gateway target.
    private_endpoint: ?PrivateEndpoint = null,

    /// The managed resources created by the gateway for private endpoint
    /// connectivity.
    private_endpoint_managed_resources: ?[]const ManagedResourceDetails = null,

    /// The protocol type of the updated gateway target.
    protocol_type: ?TargetProtocolType = null,

    /// The current status of the updated gateway target.
    status: TargetStatus,

    /// The reasons for the current status of the updated gateway target.
    status_reasons: ?[]const []const u8 = null,

    target_configuration: ?TargetConfiguration = null,

    /// The unique identifier of the updated gateway target.
    target_id: []const u8,

    /// The timestamp when the gateway target was last updated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGatewayTargetInput, options: CallOptions) !UpdateGatewayTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGatewayTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/targets/");
    try path_buf.appendSlice(allocator, input.target_id);
    try path_buf.appendSlice(allocator, "/");
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGatewayTargetOutput {
    const result: UpdateGatewayTargetOutput = try aws.json.parseJsonObject(
        UpdateGatewayTargetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
