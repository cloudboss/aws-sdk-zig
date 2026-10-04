const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateFileSystemInput, options: CallOptions) !AssociateFileSystemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.AssociateFileSystem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateFileSystemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateFileSystemOutput, body, allocator);
}
