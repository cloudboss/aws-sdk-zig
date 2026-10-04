const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateBasedAuthProperties = @import("certificate_based_auth_properties.zig").CertificateBasedAuthProperties;
const ServiceAccountCredentials = @import("service_account_credentials.zig").ServiceAccountCredentials;
const DirectoryConfig = @import("directory_config.zig").DirectoryConfig;

pub const UpdateDirectoryConfigInput = struct {
    /// The certificate-based authentication properties used to authenticate SAML
    /// 2.0 Identity
    /// Provider (IdP) user identities to Active Directory domain-joined streaming
    /// instances.
    /// Fallback is turned on by default when certificate-based authentication is
    /// **Enabled** . Fallback allows users to log in using their AD
    /// domain password if certificate-based authentication is unsuccessful, or to
    /// unlock a
    /// desktop lock screen. **Enabled_no_directory_login_fallback** enables
    /// certificate-based
    /// authentication, but does not allow users to log in using their AD domain
    /// password. Users
    /// will be disconnected to re-authenticate using certificates.
    certificate_based_auth_properties: ?CertificateBasedAuthProperties = null,

    /// The name of the Directory Config object.
    directory_name: []const u8,

    /// The distinguished names of the organizational units for computer accounts.
    organizational_unit_distinguished_names: ?[]const []const u8 = null,

    /// The credentials for the service account used by the fleet or image builder
    /// to connect to the directory.
    service_account_credentials: ?ServiceAccountCredentials = null,

    pub const json_field_names = .{
        .certificate_based_auth_properties = "CertificateBasedAuthProperties",
        .directory_name = "DirectoryName",
        .organizational_unit_distinguished_names = "OrganizationalUnitDistinguishedNames",
        .service_account_credentials = "ServiceAccountCredentials",
    };
};

pub const UpdateDirectoryConfigOutput = struct {
    /// Information about the Directory Config object.
    directory_config: ?DirectoryConfig = null,

    pub const json_field_names = .{
        .directory_config = "DirectoryConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDirectoryConfigInput, options: CallOptions) !UpdateDirectoryConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDirectoryConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.UpdateDirectoryConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDirectoryConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDirectoryConfigOutput, body, allocator);
}
