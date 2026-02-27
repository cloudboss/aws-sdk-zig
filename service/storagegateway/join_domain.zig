const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActiveDirectoryStatus = @import("active_directory_status.zig").ActiveDirectoryStatus;

pub const JoinDomainInput = struct {
    /// List of IP addresses, NetBIOS names, or host names of your domain server. If
    /// you need to
    /// specify the port number include it after the colon (“:”). For example,
    /// `mydc.mydomain.com:389`.
    ///
    /// S3 File Gateway supports IPv6 addresses in addition to IPv4 and other
    /// existing
    /// formats.
    ///
    /// FSx File Gateway does not support IPv6.
    domain_controllers: ?[]const []const u8 = null,

    /// The name of the domain that you want the gateway to join.
    domain_name: []const u8,

    /// The Amazon Resource Name (ARN) of the gateway. Use the `ListGateways`
    /// operation to return a list of gateways for your account and Amazon Web
    /// Services Region.
    gateway_arn: []const u8,

    /// The organizational unit (OU) is a container in an Active Directory that can
    /// hold users,
    /// groups, computers, and other OUs and this parameter specifies the OU that
    /// the gateway will
    /// join within the AD domain.
    organizational_unit: ?[]const u8 = null,

    /// Sets the password of the user who has permission to add the gateway to the
    /// Active
    /// Directory domain.
    password: []const u8,

    /// Specifies the time in seconds, in which the `JoinDomain` operation must
    /// complete. The default is 20 seconds.
    timeout_in_seconds: ?i32 = null,

    /// Sets the user name of user who has permission to add the gateway to the
    /// Active Directory
    /// domain. The domain user account should be enabled to join computers to the
    /// domain. For
    /// example, you can use the domain administrator account or an account with
    /// delegated
    /// permissions to join computers to the domain.
    user_name: []const u8,

    pub const json_field_names = .{
        .domain_controllers = "DomainControllers",
        .domain_name = "DomainName",
        .gateway_arn = "GatewayARN",
        .organizational_unit = "OrganizationalUnit",
        .password = "Password",
        .timeout_in_seconds = "TimeoutInSeconds",
        .user_name = "UserName",
    };
};

pub const JoinDomainOutput = struct {
    /// Indicates the status of the gateway as a member of the Active Directory
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
    /// * `INSUFFICIENT_PERMISSIONS`: Indicates that the `JoinDomain`
    /// operation failed because the specified user lacks the necessary permissions
    /// to join
    /// the domain.
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

    /// The unique Amazon Resource Name (ARN) of the gateway that joined the domain.
    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_directory_status = "ActiveDirectoryStatus",
        .gateway_arn = "GatewayARN",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: JoinDomainInput, options: Options) !JoinDomainOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: JoinDomainInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "StorageGateway_20130630.JoinDomain");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !JoinDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(JoinDomainOutput, body, alloc);
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
