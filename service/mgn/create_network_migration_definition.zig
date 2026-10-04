const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CidrMapping = @import("cidr_mapping.zig").CidrMapping;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const TargetDeployment = @import("target_deployment.zig").TargetDeployment;
const TargetNetwork = @import("target_network.zig").TargetNetwork;
const TargetS3Configuration = @import("target_s3_configuration.zig").TargetS3Configuration;
const VpcProvisioningStrategy = @import("vpc_provisioning_strategy.zig").VpcProvisioningStrategy;

pub const CreateNetworkMigrationDefinitionInput = struct {
    /// A list of CIDR mappings that map original source CIDR ranges to updated
    /// target CIDR ranges. CIDR mappings can be provided only when
    /// `vpcProvisioningStrategy` is set to `USE_EXISTING`.
    cidr_mappings: ?[]const CidrMapping = null,

    /// A description of the network migration definition.
    description: ?[]const u8 = null,

    /// The name of the network migration definition.
    name: []const u8,

    /// Scope tags for the network migration definition to control access and
    /// organization.
    scope_tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of source configurations for the network migration.
    source_configurations: ?[]const SourceConfiguration = null,

    /// Tags to assign to the network migration definition.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The target deployment configuration for the migrated network.
    target_deployment: ?TargetDeployment = null,

    /// The target network configuration including topology and CIDR ranges.
    target_network: TargetNetwork,

    /// The S3 configuration for storing the target network artifacts.
    target_s3_configuration: TargetS3Configuration,

    /// Specifies whether to create new target VPCs or use existing ones. Set to
    /// `CREATE_NEW` to provision new target VPCs as part of the migration, or
    /// `USE_EXISTING` to migrate into existing VPCs in the target account.
    vpc_provisioning_strategy: ?VpcProvisioningStrategy = null,

    pub const json_field_names = .{
        .cidr_mappings = "cidrMappings",
        .description = "description",
        .name = "name",
        .scope_tags = "scopeTags",
        .source_configurations = "sourceConfigurations",
        .tags = "tags",
        .target_deployment = "targetDeployment",
        .target_network = "targetNetwork",
        .target_s3_configuration = "targetS3Configuration",
        .vpc_provisioning_strategy = "vpcProvisioningStrategy",
    };
};

pub const CreateNetworkMigrationDefinitionOutput = struct {
    /// The Amazon Resource Name (ARN) of the network migration definition.
    arn: ?[]const u8 = null,

    /// A list of CIDR mappings that map original source CIDR ranges to updated
    /// target CIDR ranges. CIDR mappings apply only when `vpcProvisioningStrategy`
    /// is set to `USE_EXISTING`.
    cidr_mappings: ?[]const CidrMapping = null,

    /// The timestamp when the network migration definition was created.
    created_at: ?i64 = null,

    /// A description of the network migration definition.
    description: ?[]const u8 = null,

    /// The name of the network migration definition.
    name: ?[]const u8 = null,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: ?[]const u8 = null,

    /// Scope tags for the network migration definition.
    scope_tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of source configurations for the network migration.
    source_configurations: ?[]const SourceConfiguration = null,

    /// Tags assigned to the network migration definition.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The target deployment configuration for the migrated network.
    target_deployment: ?TargetDeployment = null,

    /// The target network configuration including topology and CIDR ranges.
    target_network: ?TargetNetwork = null,

    /// The S3 configuration for storing the target network artifacts.
    target_s3_configuration: ?TargetS3Configuration = null,

    /// The timestamp when the network migration definition was last updated.
    updated_at: ?i64 = null,

    /// Indicates whether the migration creates new target VPCs or uses existing
    /// ones. `CREATE_NEW` provisions new target VPCs; `USE_EXISTING` migrates into
    /// existing VPCs in the target account.
    vpc_provisioning_strategy: ?VpcProvisioningStrategy = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cidr_mappings = "cidrMappings",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .scope_tags = "scopeTags",
        .source_configurations = "sourceConfigurations",
        .tags = "tags",
        .target_deployment = "targetDeployment",
        .target_network = "targetNetwork",
        .target_s3_configuration = "targetS3Configuration",
        .updated_at = "updatedAt",
        .vpc_provisioning_strategy = "vpcProvisioningStrategy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNetworkMigrationDefinitionInput, options: CallOptions) !CreateNetworkMigrationDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNetworkMigrationDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/network-migration/CreateNetworkMigrationDefinition";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cidr_mappings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cidrMappings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.scope_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scopeTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_deployment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetDeployment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetNetwork\":");
    try aws.json.writeValue(@TypeOf(input.target_network), input.target_network, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetS3Configuration\":");
    try aws.json.writeValue(@TypeOf(input.target_s3_configuration), input.target_s3_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.vpc_provisioning_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcProvisioningStrategy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNetworkMigrationDefinitionOutput {
    const result: CreateNetworkMigrationDefinitionOutput = try aws.json.parseJsonObject(
        CreateNetworkMigrationDefinitionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
