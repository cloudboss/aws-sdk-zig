const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;
const ProtocolType = @import("protocol_type.zig").ProtocolType;
const ResourceConfigurationDefinition = @import("resource_configuration_definition.zig").ResourceConfigurationDefinition;
const ResourceConfigurationStatus = @import("resource_configuration_status.zig").ResourceConfigurationStatus;
const ResourceConfigurationType = @import("resource_configuration_type.zig").ResourceConfigurationType;

pub const GetResourceConfigurationInput = struct {
    /// The ID of the resource configuration.
    resource_configuration_identifier: []const u8,

    pub const json_field_names = .{
        .resource_configuration_identifier = "resourceConfigurationIdentifier",
    };
};

pub const GetResourceConfigurationOutput = struct {
    /// Specifies whether the resource configuration is associated with a sharable
    /// service network.
    allow_association_to_shareable_service_network: ?bool = null,

    /// Indicates whether the resource configuration was created and is managed by
    /// Amazon.
    amazon_managed: ?bool = null,

    /// The Amazon Resource Name (ARN) of the resource configuration.
    arn: ?[]const u8 = null,

    /// The date and time that the resource configuration was created, in ISO-8601
    /// format.
    created_at: ?i64 = null,

    /// The custom domain name of the resource configuration.
    custom_domain_name: ?[]const u8 = null,

    /// The ARN of the domain verification.
    domain_verification_arn: ?[]const u8 = null,

    /// The domain verification ID.
    domain_verification_id: ?[]const u8 = null,

    /// The domain verification status.
    domain_verification_status: ?VerificationStatus = null,

    /// The reason the create-resource-configuration request failed.
    failure_reason: ?[]const u8 = null,

    /// (GROUP) The group domain for a group resource configuration. Any domains
    /// that you create for the child resource are subdomains of the group domain.
    /// Child resources inherit the verification status of the domain.
    group_domain: ?[]const u8 = null,

    /// The ID of the resource configuration.
    id: ?[]const u8 = null,

    /// The most recent date and time that the resource configuration was updated,
    /// in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// The name of the resource configuration.
    name: ?[]const u8 = null,

    /// The TCP port ranges that a consumer can use to access a resource
    /// configuration. You can separate port ranges with a comma. Example: 1-65535
    /// or 1,2,22-30
    port_ranges: ?[]const []const u8 = null,

    /// The TCP protocol accepted by the specified resource configuration.
    protocol: ?ProtocolType = null,

    /// The resource configuration.
    resource_configuration_definition: ?ResourceConfigurationDefinition = null,

    /// The ID of the group resource configuration.
    resource_configuration_group_id: ?[]const u8 = null,

    /// The ID of the resource gateway used to connect to the resource configuration
    /// in a given VPC. You can specify the resource gateway identifier only for
    /// resource configurations with type SINGLE, GROUP, or ARN.
    resource_gateway_id: ?[]const u8 = null,

    /// The status of the resource configuration.
    status: ?ResourceConfigurationStatus = null,

    /// The type of resource configuration.
    ///
    /// * `SINGLE` - A single resource.
    /// * `GROUP` - A group of resources.
    /// * `CHILD` - A single resource that is part of a group resource
    ///   configuration.
    /// * `ARN` - An Amazon Web Services resource.
    type: ?ResourceConfigurationType = null,

    pub const json_field_names = .{
        .allow_association_to_shareable_service_network = "allowAssociationToShareableServiceNetwork",
        .amazon_managed = "amazonManaged",
        .arn = "arn",
        .created_at = "createdAt",
        .custom_domain_name = "customDomainName",
        .domain_verification_arn = "domainVerificationArn",
        .domain_verification_id = "domainVerificationId",
        .domain_verification_status = "domainVerificationStatus",
        .failure_reason = "failureReason",
        .group_domain = "groupDomain",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .port_ranges = "portRanges",
        .protocol = "protocol",
        .resource_configuration_definition = "resourceConfigurationDefinition",
        .resource_configuration_group_id = "resourceConfigurationGroupId",
        .resource_gateway_id = "resourceGatewayId",
        .status = "status",
        .type = "type",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceConfigurationInput, options: Options) !GetResourceConfigurationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetResourceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpclattice", "VPC Lattice", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/resourceconfigurations/");
    try path_buf.appendSlice(alloc, input.resource_configuration_identifier);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetResourceConfigurationOutput {
    var result: GetResourceConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceConfigurationOutput, body, alloc);
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
