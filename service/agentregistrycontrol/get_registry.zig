const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalConfiguration = @import("approval_configuration.zig").ApprovalConfiguration;
const AutoDetection = @import("auto_detection.zig").AutoDetection;
const CustomMetadataSchemaConfiguration = @import("custom_metadata_schema_configuration.zig").CustomMetadataSchemaConfiguration;
const DiscoveryConfiguration = @import("discovery_configuration.zig").DiscoveryConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const RegistryStatus = @import("registry_status.zig").RegistryStatus;

pub const GetRegistryInput = struct {
    /// The identifier of the registry to retrieve (ARN or ID)
    registry_id: []const u8,

    pub const json_field_names = .{
        .registry_id = "registryId",
    };
};

pub const GetRegistryOutput = struct {
    /// Approval configuration for registry records
    approval_configuration: ?ApprovalConfiguration = null,

    /// The registry's auto-detection properties, including the requested
    /// configuration and the current detection status. Present only when
    /// auto-detection was configured for the registry.
    auto_detection: ?AutoDetection = null,

    /// The timestamp when the registry was created
    created_at: i64,

    /// The custom metadata schema configuration for this registry, if one has been
    /// defined.
    custom_metadata_schema_configuration: ?CustomMetadataSchemaConfiguration = null,

    /// The description of the registry
    description: ?[]const u8 = null,

    /// Discovery configuration for the registry
    discovery_configuration: ?DiscoveryConfiguration = null,

    /// The server-side encryption configuration for the registry. Appears only when
    /// a customer-managed Amazon Web Services KMS key encrypts the registry.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The name of the registry
    name: []const u8,

    /// The ARN of the registry
    registry_arn: []const u8,

    /// The unique identifier of the registry
    registry_id: []const u8,

    /// Current status of the registry
    status: RegistryStatus,

    /// The reason for the current status. Typically populated when the status
    /// indicates a failure state.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the registry was last updated
    updated_at: i64,

    pub const json_field_names = .{
        .approval_configuration = "approvalConfiguration",
        .auto_detection = "autoDetection",
        .created_at = "createdAt",
        .custom_metadata_schema_configuration = "customMetadataSchemaConfiguration",
        .description = "description",
        .discovery_configuration = "discoveryConfiguration",
        .encryption_configuration = "encryptionConfiguration",
        .name = "name",
        .registry_arn = "registryArn",
        .registry_id = "registryId",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRegistryInput, options: CallOptions) !GetRegistryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "agent-registry", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRegistryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agent-registry-control", "Agent Registry Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRegistryOutput {
    const result: GetRegistryOutput = try aws.json.parseJsonObject(
        GetRegistryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
