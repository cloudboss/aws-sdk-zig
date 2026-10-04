const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizationData = @import("authorization_data.zig").AuthorizationData;
const CertificateConfiguration = @import("certificate_configuration.zig").CertificateConfiguration;
const CredentialProviderConfiguration = @import("credential_provider_configuration.zig").CredentialProviderConfiguration;
const MetadataConfiguration = @import("metadata_configuration.zig").MetadataConfiguration;
const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;
const ManagedResourceDetails = @import("managed_resource_details.zig").ManagedResourceDetails;
const TargetProtocolType = @import("target_protocol_type.zig").TargetProtocolType;
const TargetStatus = @import("target_status.zig").TargetStatus;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;

pub const GetGatewayTargetInput = struct {
    /// The identifier of the gateway that contains the target.
    gateway_identifier: []const u8,

    /// The unique identifier of the target to retrieve.
    target_id: []const u8,

    pub const json_field_names = .{
        .gateway_identifier = "gatewayIdentifier",
        .target_id = "targetId",
    };
};

pub const GetGatewayTargetOutput = struct {
    /// OAuth2 authorization data for the gateway target. This data is returned when
    /// a target is configured with a credential provider with authorization code
    /// grant type and requires user federation.
    authorization_data: ?AuthorizationData = null,

    /// The private certificate authority (CA) configurations for the gateway
    /// target.
    certificate_configurations: ?[]const CertificateConfiguration = null,

    /// The timestamp when the gateway target was created.
    created_at: i64,

    /// The credential provider configurations for the gateway target.
    credential_provider_configurations: ?[]const CredentialProviderConfiguration = null,

    /// The description of the gateway target.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the gateway.
    gateway_arn: []const u8,

    /// The last synchronization of the target.
    last_synchronized_at: ?i64 = null,

    /// The metadata configuration for HTTP header and query parameter propagation
    /// for the retrieved gateway target.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The name of the gateway target.
    name: []const u8,

    /// The private endpoint configuration for the gateway target.
    private_endpoint: ?PrivateEndpoint = null,

    /// The managed resources created by the gateway for private endpoint
    /// connectivity.
    private_endpoint_managed_resources: ?[]const ManagedResourceDetails = null,

    /// The protocol type of the gateway target.
    protocol_type: ?TargetProtocolType = null,

    /// The current status of the gateway target.
    status: TargetStatus,

    /// The reasons for the current status of the gateway target.
    status_reasons: ?[]const []const u8 = null,

    target_configuration: ?TargetConfiguration = null,

    /// The unique identifier of the gateway target.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGatewayTargetInput, options: CallOptions) !GetGatewayTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGatewayTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/targets/");
    try path_buf.appendSlice(allocator, input.target_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGatewayTargetOutput {
    const result: GetGatewayTargetOutput = try aws.json.parseJsonObject(
        GetGatewayTargetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
