const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalConfiguration = @import("approval_configuration.zig").ApprovalConfiguration;
const AutoDetectionConfiguration = @import("auto_detection_configuration.zig").AutoDetectionConfiguration;
const CustomMetadataSchemaConfiguration = @import("custom_metadata_schema_configuration.zig").CustomMetadataSchemaConfiguration;
const DiscoveryConfiguration = @import("discovery_configuration.zig").DiscoveryConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

pub const CreateRegistryInput = struct {
    /// Approval configuration for registry records
    approval_configuration: ?ApprovalConfiguration = null,

    /// The optional auto-detection configuration for the registry. When provided,
    /// the registry is automatically populated with resources discovered according
    /// to the configuration. Omit this field for registries whose records are
    /// managed exclusively through the Agent Registry Control API.
    auto_detection_configuration: ?AutoDetectionConfiguration = null,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The optional custom metadata schema configuration for the registry. When
    /// provided, registry records can carry structured metadata validated against
    /// this schema.
    custom_metadata_schema_configuration: ?CustomMetadataSchemaConfiguration = null,

    /// The description of the registry
    description: ?[]const u8 = null,

    /// Discovery configuration for the registry
    discovery_configuration: ?DiscoveryConfiguration = null,

    /// The optional server-side encryption configuration for the registry. When you
    /// provide this field, the specified customer-managed Amazon Web Services KMS
    /// key encrypts the registry's content. Omit this field to use an Amazon Web
    /// Services-owned encryption key. You cannot change the encryption
    /// configuration after registry creation.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The name of the registry
    name: []const u8,

    /// Tags to associate with the registry
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .approval_configuration = "approvalConfiguration",
        .auto_detection_configuration = "autoDetectionConfiguration",
        .client_token = "clientToken",
        .custom_metadata_schema_configuration = "customMetadataSchemaConfiguration",
        .description = "description",
        .discovery_configuration = "discoveryConfiguration",
        .encryption_configuration = "encryptionConfiguration",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateRegistryOutput = struct {
    /// The ARN of the created registry
    registry_arn: []const u8,

    pub const json_field_names = .{
        .registry_arn = "registryArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistryInput, options: CallOptions) !CreateRegistryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agent-registry-control", "Agent Registry Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/registries";

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
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
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
    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistryOutput {
    const result: CreateRegistryOutput = try aws.json.parseJsonObject(
        CreateRegistryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
