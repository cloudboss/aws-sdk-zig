const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CacheAttributes = @import("cache_attributes.zig").CacheAttributes;
const EndpointNetworkConfiguration = @import("endpoint_network_configuration.zig").EndpointNetworkConfiguration;
const Tag = @import("tag.zig").Tag;

pub const AssociateFileSystemInput = struct {
    /// The Amazon Resource Name (ARN) of the storage used for the audit logs.
    audit_destination_arn: ?[]const u8 = null,

    cache_attributes: ?CacheAttributes = null,

    /// A unique string value that you supply that is used by the FSx File Gateway
    /// to ensure
    /// idempotent file system association creation.
    client_token: []const u8,

    /// Specifies the network configuration information for the gateway associated
    /// with the
    /// Amazon FSx file system.
    ///
    /// If multiple file systems are associated with this gateway, this parameter's
    /// `IpAddresses` field is required.
    endpoint_network_configuration: ?EndpointNetworkConfiguration = null,

    gateway_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon FSx file system to associate
    /// with
    /// the FSx File Gateway.
    location_arn: []const u8,

    /// The password of the user credential.
    password: []const u8,

    /// A list of up to 50 tags that can be assigned to the file system association.
    /// Each tag is
    /// a key-value pair.
    tags: ?[]const Tag = null,

    /// The user name of the user credential that has permission to access the root
    /// share D$ of
    /// the Amazon FSx file system. The user account must belong to the Amazon FSx
    /// delegated admin user group.
    user_name: []const u8,

    pub const json_field_names = .{
        .audit_destination_arn = "AuditDestinationARN",
        .cache_attributes = "CacheAttributes",
        .client_token = "ClientToken",
        .endpoint_network_configuration = "EndpointNetworkConfiguration",
        .gateway_arn = "GatewayARN",
        .location_arn = "LocationARN",
        .password = "Password",
        .tags = "Tags",
        .user_name = "UserName",
    };
};

pub const AssociateFileSystemOutput = struct {
    /// The ARN of the newly created file system association.
    file_system_association_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_association_arn = "FileSystemAssociationARN",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateFileSystemInput, options: Options) !AssociateFileSystemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

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

fn serializeRequest(alloc: std.mem.Allocator, input: AssociateFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "StorageGateway_20130630.AssociateFileSystem");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AssociateFileSystemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateFileSystemOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
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
