const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DomainVersion = @import("domain_version.zig").DomainVersion;
const SingleSignOn = @import("single_sign_on.zig").SingleSignOn;
const DomainStatus = @import("domain_status.zig").DomainStatus;

pub const GetDomainInput = struct {
    /// The identifier of the specified Amazon DataZone domain.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const GetDomainOutput = struct {
    /// The ARN of the specified Amazon DataZone domain.
    arn: ?[]const u8 = null,

    /// The timestamp of when the Amazon DataZone domain was created.
    created_at: ?i64 = null,

    /// The description of the Amazon DataZone domain.
    description: ?[]const u8 = null,

    /// The domain execution role with which the Amazon DataZone domain is created.
    domain_execution_role: []const u8,

    /// The version of the domain.
    domain_version: ?DomainVersion = null,

    /// The identifier of the specified Amazon DataZone domain.
    id: []const u8,

    /// The identifier of the Amazon Web Services Key Management Service (KMS) key
    /// that is used to encrypt the Amazon DataZone domain, metadata, and reporting
    /// data.
    kms_key_identifier: ?[]const u8 = null,

    /// The timestamp of when the Amazon DataZone domain was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the Amazon DataZone domain.
    name: ?[]const u8 = null,

    /// The URL of the data portal for this Amazon DataZone domain.
    portal_url: ?[]const u8 = null,

    /// The ID of the root domain in Amazon Datazone.
    root_domain_unit_id: ?[]const u8 = null,

    /// The service role of the domain.
    service_role: ?[]const u8 = null,

    /// The single sing-on option of the specified Amazon DataZone domain.
    single_sign_on: ?SingleSignOn = null,

    /// The status of the specified Amazon DataZone domain.
    status: DomainStatus,

    /// The tags specified for the Amazon DataZone domain.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .domain_execution_role = "domainExecutionRole",
        .domain_version = "domainVersion",
        .id = "id",
        .kms_key_identifier = "kmsKeyIdentifier",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .portal_url = "portalUrl",
        .root_domain_unit_id = "rootDomainUnitId",
        .service_role = "serviceRole",
        .single_sign_on = "singleSignOn",
        .status = "status",
        .tags = "tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainInput, options: Options) !GetDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datazone");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainOutput {
    var result: GetDomainOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDomainOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
