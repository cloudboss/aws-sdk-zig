const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ProtocolType = @import("protocol_type.zig").ProtocolType;
const ResourceConfigurationDefinition = @import("resource_configuration_definition.zig").ResourceConfigurationDefinition;
const ResourceConfigurationType = @import("resource_configuration_type.zig").ResourceConfigurationType;
const ResourceConfigurationStatus = @import("resource_configuration_status.zig").ResourceConfigurationStatus;

pub const CreateResourceConfigurationInput = struct {
    /// (SINGLE, GROUP, ARN) Specifies whether the resource configuration can be
    /// associated with a sharable service network. The default is false.
    allow_association_to_shareable_service_network: ?bool = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token and parameters, the retry succeeds
    /// without performing any actions. If the parameters aren't identical, the
    /// retry fails.
    client_token: ?[]const u8 = null,

    /// A custom domain name for your resource configuration. Additionally, provide
    /// a DomainVerificationID to prove your ownership of a domain.
    custom_domain_name: ?[]const u8 = null,

    /// The domain verification ID of your verified custom domain name. If you don't
    /// provide an ID, you must configure the DNS settings yourself.
    domain_verification_identifier: ?[]const u8 = null,

    /// (GROUP) The group domain for a group resource configuration. Any domains
    /// that you create for the child resource are subdomains of the group domain.
    /// Child resources inherit the verification status of the domain.
    group_domain: ?[]const u8 = null,

    /// The name of the resource configuration. The name must be unique within the
    /// account. The valid characters are a-z, 0-9, and hyphens (-). You can't use a
    /// hyphen as the first or last character, or immediately after another hyphen.
    name: []const u8,

    /// (SINGLE, GROUP, CHILD) The TCP port ranges that a consumer can use to access
    /// a resource configuration (for example: 1-65535). You can separate port
    /// ranges using commas (for example: 1,2,22-30).
    port_ranges: ?[]const []const u8 = null,

    /// (SINGLE, GROUP) The protocol accepted by the resource configuration.
    protocol: ?ProtocolType = null,

    /// Identifies the resource configuration in one of the following ways:
    ///
    /// * **Amazon Resource Name (ARN)** - Supported resource-types that are
    ///   provisioned by Amazon Web Services services, such as RDS databases, can be
    ///   identified by their ARN.
    /// * **Domain name** - Any domain name that is publicly resolvable.
    /// * **IP address** - For IPv4 and IPv6, only IP addresses in the VPC are
    ///   supported.
    resource_configuration_definition: ?ResourceConfigurationDefinition = null,

    /// (CHILD) The ID or ARN of the parent resource configuration of type `GROUP`.
    /// This is used to associate a child resource configuration with a group
    /// resource configuration.
    resource_configuration_group_identifier: ?[]const u8 = null,

    /// (SINGLE, GROUP, ARN) The ID or ARN of the resource gateway used to connect
    /// to the resource configuration. For a child resource configuration, this
    /// value is inherited from the parent resource configuration.
    resource_gateway_identifier: ?[]const u8 = null,

    /// The tags for the resource configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of resource configuration. A resource configuration can be one of
    /// the following types:
    ///
    /// * **SINGLE** - A single resource.
    /// * **GROUP** - A group of resources. You must create a group resource
    ///   configuration before you create a child resource configuration.
    /// * **CHILD** - A single resource that is part of a group resource
    ///   configuration.
    /// * **ARN** - An Amazon Web Services resource.
    @"type": ResourceConfigurationType,

    pub const json_field_names = .{
        .allow_association_to_shareable_service_network = "allowAssociationToShareableServiceNetwork",
        .client_token = "clientToken",
        .custom_domain_name = "customDomainName",
        .domain_verification_identifier = "domainVerificationIdentifier",
        .group_domain = "groupDomain",
        .name = "name",
        .port_ranges = "portRanges",
        .protocol = "protocol",
        .resource_configuration_definition = "resourceConfigurationDefinition",
        .resource_configuration_group_identifier = "resourceConfigurationGroupIdentifier",
        .resource_gateway_identifier = "resourceGatewayIdentifier",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub const CreateResourceConfigurationOutput = struct {
    /// Specifies whether the resource configuration can be associated with a
    /// sharable service network.
    allow_association_to_shareable_service_network: ?bool = null,

    /// The Amazon Resource Name (ARN) of the resource configuration.
    arn: ?[]const u8 = null,

    /// The date and time that the resource configuration was created, in ISO-8601
    /// format.
    created_at: ?i64 = null,

    /// The custom domain name for your resource configuration.
    custom_domain_name: ?[]const u8 = null,

    /// The verification ID ARN
    domain_verification_arn: ?[]const u8 = null,

    /// The domain name verification ID.
    domain_verification_id: ?[]const u8 = null,

    /// The reason that the request failed.
    failure_reason: ?[]const u8 = null,

    /// (GROUP) The group domain for a group resource configuration. Any domains
    /// that you create for the child resource are subdomains of the group domain.
    /// Child resources inherit the verification status of the domain.
    group_domain: ?[]const u8 = null,

    /// The ID of the resource configuration.
    id: ?[]const u8 = null,

    /// The name of the resource configuration.
    name: ?[]const u8 = null,

    /// The port range.
    port_ranges: ?[]const []const u8 = null,

    /// The protocol.
    protocol: ?ProtocolType = null,

    /// Identifies the resource configuration in one of the following ways:
    ///
    /// * **Amazon Resource Name (ARN)** - Supported resource-types that are
    ///   provisioned by Amazon Web Services services, such as RDS databases, can be
    ///   identified by their ARN.
    /// * **Domain name** - Any domain name that is publicly resolvable.
    /// * **IP address** - For IPv4 and IPv6, only IP addresses in the VPC are
    ///   supported.
    resource_configuration_definition: ?ResourceConfigurationDefinition = null,

    /// The ID of the parent resource configuration of type `GROUP`.
    resource_configuration_group_id: ?[]const u8 = null,

    /// The ID of the resource gateway associated with the resource configuration.
    resource_gateway_id: ?[]const u8 = null,

    /// The current status of the resource configuration.
    status: ?ResourceConfigurationStatus = null,

    /// The type of resource configuration. A resource configuration can be one of
    /// the following types:
    ///
    /// * **SINGLE** - A single resource.
    /// * **GROUP** - A group of resources. You must create a group resource
    ///   configuration before you create a child resource configuration.
    /// * **CHILD** - A single resource that is part of a group resource
    ///   configuration.
    /// * **ARN** - An Amazon Web Services resource.
    @"type": ?ResourceConfigurationType = null,

    pub const json_field_names = .{
        .allow_association_to_shareable_service_network = "allowAssociationToShareableServiceNetwork",
        .arn = "arn",
        .created_at = "createdAt",
        .custom_domain_name = "customDomainName",
        .domain_verification_arn = "domainVerificationArn",
        .domain_verification_id = "domainVerificationId",
        .failure_reason = "failureReason",
        .group_domain = "groupDomain",
        .id = "id",
        .name = "name",
        .port_ranges = "portRanges",
        .protocol = "protocol",
        .resource_configuration_definition = "resourceConfigurationDefinition",
        .resource_configuration_group_id = "resourceConfigurationGroupId",
        .resource_gateway_id = "resourceGatewayId",
        .status = "status",
        .@"type" = "type",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceConfigurationInput, options: Options) !CreateResourceConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "vpclattice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateResourceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpclattice", "VPC Lattice", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/resourceconfigurations";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.allow_association_to_shareable_service_network) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"allowAssociationToShareableServiceNetwork\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.custom_domain_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"customDomainName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.domain_verification_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"domainVerificationIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.group_domain) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"groupDomain\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (input.port_ranges) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"portRanges\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.protocol) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"protocol\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.resource_configuration_definition) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"resourceConfigurationDefinition\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.resource_configuration_group_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"resourceConfigurationGroupIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.resource_gateway_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"resourceGatewayIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateResourceConfigurationOutput {
    var result: CreateResourceConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateResourceConfigurationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
