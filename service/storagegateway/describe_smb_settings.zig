const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ActiveDirectoryStatus = @import("active_directory_status.zig").ActiveDirectoryStatus;
const SMBLocalGroups = @import("smb_local_groups.zig").SMBLocalGroups;
const SMBSecurityStrategy = @import("smb_security_strategy.zig").SMBSecurityStrategy;

pub const DescribeSMBSettingsInput = struct {
    gateway_arn: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub const DescribeSMBSettingsOutput = struct {
    /// Indicates the status of a gateway that is a member of the Active Directory
    /// domain.
    ///
    /// This field is only used as part of a `JoinDomain` request. It is not
    /// affected by Active Directory connectivity changes that occur after the
    /// `JoinDomain` request succeeds.
    ///
    /// * `ACCESS_DENIED`: Indicates that the `JoinDomain` operation
    /// failed due to an authentication error.
    ///
    /// * `DETACHED`: Indicates that gateway is not joined to a domain.
    ///
    /// * `JOINED`: Indicates that the gateway has successfully joined a
    /// domain.
    ///
    /// * `JOINING`: Indicates that a `JoinDomain` operation is in
    /// progress.
    ///
    /// * `NETWORK_ERROR`: Indicates that `JoinDomain` operation
    /// failed due to a network or connectivity error.
    ///
    /// * `TIMEOUT`: Indicates that the `JoinDomain` operation failed
    /// because the operation didn't complete within the allotted time.
    ///
    /// * `UNKNOWN_ERROR`: Indicates that the `JoinDomain` operation
    /// failed due to another type of error.
    active_directory_status: ?ActiveDirectoryStatus = null,

    /// The name of the domain that the gateway is joined to.
    domain_name: ?[]const u8 = null,

    /// The shares on this gateway appear when listing shares. Only supported for S3
    /// File
    /// Gateways.
    file_shares_visible: ?bool = null,

    gateway_arn: ?[]const u8 = null,

    /// This value is `true` if a password for the guest user `smbguest`
    /// is set, otherwise `false`. Only supported for S3 File Gateways.
    ///
    /// Valid Values: `true` | `false`
    smb_guest_password_set: ?bool = null,

    /// A list of Active Directory users and groups that have special permissions
    /// for SMB file
    /// shares on the gateway.
    smb_local_groups: ?SMBLocalGroups = null,

    /// The type of security strategy that was specified for file gateway.
    ///
    /// * `ClientSpecified`: If you choose this option, requests are established
    /// based on what is negotiated by the client. This option is recommended when
    /// you want
    /// to maximize compatibility across different clients in your environment.
    /// Supported
    /// only for S3 File Gateway.
    ///
    /// * `MandatorySigning`: If you choose this option, File Gateway only allows
    /// connections from SMBv2 or SMBv3 clients that have signing turned on. This
    /// option
    /// works with SMB clients on Microsoft Windows Vista, Windows Server 2008, or
    /// later.
    ///
    /// * `MandatoryEncryption`: If you choose this option, File Gateway only
    /// allows connections from SMBv3 clients that have encryption turned on. Both
    /// 256-bit
    /// and 128-bit algorithms are allowed. This option is recommended for
    /// environments that
    /// handle sensitive data. It works with SMB clients on Microsoft Windows 8,
    /// Windows
    /// Server 2012, or later.
    ///
    /// * `MandatoryEncryptionNoAes128`: If you choose this option, File Gateway
    /// only allows connections from SMBv3 clients that use 256-bit AES encryption
    /// algorithms. 128-bit algorithms are not allowed. This option is recommended
    /// for
    /// environments that handle sensitive data. It works with SMB clients on
    /// Microsoft
    /// Windows 8, Windows Server 2012, or later.
    smb_security_strategy: ?SMBSecurityStrategy = null,

    pub const json_field_names = .{
        .active_directory_status = "ActiveDirectoryStatus",
        .domain_name = "DomainName",
        .file_shares_visible = "FileSharesVisible",
        .gateway_arn = "GatewayARN",
        .smb_guest_password_set = "SMBGuestPasswordSet",
        .smb_local_groups = "SMBLocalGroups",
        .smb_security_strategy = "SMBSecurityStrategy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSMBSettingsInput, options: CallOptions) !DescribeSMBSettingsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSMBSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeSMBSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSMBSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSMBSettingsOutput, body, allocator);
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
