const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdatedApprovalConfiguration = @import("updated_approval_configuration.zig").UpdatedApprovalConfiguration;
const UpdatedAutoDetectionConfiguration = @import("updated_auto_detection_configuration.zig").UpdatedAutoDetectionConfiguration;
const UpdatedCustomMetadataSchemaConfiguration = @import("updated_custom_metadata_schema_configuration.zig").UpdatedCustomMetadataSchemaConfiguration;
const UpdatedDescription = @import("updated_description.zig").UpdatedDescription;
const UpdatedDiscoveryConfiguration = @import("updated_discovery_configuration.zig").UpdatedDiscoveryConfiguration;
const ApprovalConfiguration = @import("approval_configuration.zig").ApprovalConfiguration;
const AutoDetection = @import("auto_detection.zig").AutoDetection;
const CustomMetadataSchemaConfiguration = @import("custom_metadata_schema_configuration.zig").CustomMetadataSchemaConfiguration;
const DiscoveryConfiguration = @import("discovery_configuration.zig").DiscoveryConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const RegistryStatus = @import("registry_status.zig").RegistryStatus;

pub const UpdateRegistryInput = struct {
    /// The updated approval configuration. The change applies only to records that
    /// move to PENDING_APPROVAL after the update; records already in
    /// PENDING_APPROVAL are unaffected.
    approval_configuration: ?UpdatedApprovalConfiguration = null,

    /// The updated auto-detection configuration for the registry, with PATCH
    /// semantics. Omit this field to leave the current configuration unchanged.
    /// Supply an empty wrapper to unset it. Supply `optionalValue` to replace it.
    auto_detection_configuration: ?UpdatedAutoDetectionConfiguration = null,

    /// Updated custom metadata schema configuration for the registry. Omit to leave
    /// the existing schema unchanged. Schema evolution is additive only: you can
    /// add properties and enum values, but you cannot remove properties, change
    /// property types or formats, add or remove enum constraints, or remove record
    /// type overrides.
    custom_metadata_schema_configuration: ?UpdatedCustomMetadataSchemaConfiguration = null,

    /// The updated description of the registry
    description: ?UpdatedDescription = null,

    /// The updated discovery configuration. Changing the discovery authorization
    /// can break existing consumers that rely on the previous authorization type.
    discovery_configuration: ?UpdatedDiscoveryConfiguration = null,

    /// The updated name of the registry
    name: ?[]const u8 = null,

    /// The identifier of the registry to update (ARN or ID)
    registry_id: []const u8,

    pub const json_field_names = .{
        .approval_configuration = "approvalConfiguration",
        .auto_detection_configuration = "autoDetectionConfiguration",
        .custom_metadata_schema_configuration = "customMetadataSchemaConfiguration",
        .description = "description",
        .discovery_configuration = "discoveryConfiguration",
        .name = "name",
        .registry_id = "registryId",
    };
};

pub const UpdateRegistryOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRegistryInput, options: CallOptions) !UpdateRegistryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRegistryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agent-registry-control", "Agent Registry Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.approval_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"approvalConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_detection_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoDetectionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_metadata_schema_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customMetadataSchemaConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.discovery_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"discoveryConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRegistryOutput {
    const result: UpdateRegistryOutput = try aws.json.parseJsonObject(
        UpdateRegistryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
