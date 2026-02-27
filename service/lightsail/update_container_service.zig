const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerServicePowerName = @import("container_service_power_name.zig").ContainerServicePowerName;
const PrivateRegistryAccessRequest = @import("private_registry_access_request.zig").PrivateRegistryAccessRequest;
const ContainerService = @import("container_service.zig").ContainerService;

pub const UpdateContainerServiceInput = struct {
    /// A Boolean value to indicate whether the container service is disabled.
    is_disabled: ?bool = null,

    /// The power for the container service.
    ///
    /// The power specifies the amount of memory, vCPUs, and base monthly cost of
    /// each node of the
    /// container service. The `power` and `scale` of a container service makes
    /// up its configured capacity. To determine the monthly price of your container
    /// service, multiply
    /// the base price of the `power` with the `scale` (the number of nodes) of
    /// the service.
    ///
    /// Use the `GetContainerServicePowers` action to view the specifications of
    /// each
    /// power option.
    power: ?ContainerServicePowerName = null,

    /// An object to describe the configuration for the container service to access
    /// private
    /// container image repositories, such as Amazon Elastic Container Registry
    /// (Amazon ECR) private
    /// repositories.
    ///
    /// For more information, see [Configuring access to an Amazon ECR private
    /// repository for an Amazon Lightsail container
    /// service](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-container-service-ecr-private-repo-access) in the *Amazon Lightsail Developer Guide*.
    private_registry_access: ?PrivateRegistryAccessRequest = null,

    /// The public domain names to use with the container service, such as
    /// `example.com` and `www.example.com`.
    ///
    /// You can specify up to four public domain names for a container service. The
    /// domain names
    /// that you specify are used when you create a deployment with a container
    /// configured as the
    /// public endpoint of your container service.
    ///
    /// If you don't specify public domain names, then you can use the default
    /// domain of the
    /// container service.
    ///
    /// You must create and validate an SSL/TLS certificate before you can use
    /// public domain
    /// names with your container service. Use the `CreateCertificate` action to
    /// create a
    /// certificate for the public domain names you want to use with your container
    /// service.
    ///
    /// You can specify public domain names using a string to array map as shown in
    /// the example
    /// later on this page.
    public_domain_names: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The scale for the container service.
    ///
    /// The scale specifies the allocated compute nodes of the container service.
    /// The
    /// `power` and `scale` of a container service makes up its configured
    /// capacity. To determine the monthly price of your container service, multiply
    /// the base price of
    /// the `power` with the `scale` (the number of nodes) of the
    /// service.
    scale: ?i32 = null,

    /// The name of the container service to update.
    service_name: []const u8,

    pub const json_field_names = .{
        .is_disabled = "isDisabled",
        .power = "power",
        .private_registry_access = "privateRegistryAccess",
        .public_domain_names = "publicDomainNames",
        .scale = "scale",
        .service_name = "serviceName",
    };
};

pub const UpdateContainerServiceOutput = struct {
    /// An object that describes a container service.
    container_service: ?ContainerService = null,

    pub const json_field_names = .{
        .container_service = "containerService",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContainerServiceInput, options: Options) !UpdateContainerServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateContainerServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "Lightsail_20161128.UpdateContainerService");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateContainerServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateContainerServiceOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        return .{ .arena = arena, .kind = .{ .operation_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        return .{ .arena = arena, .kind = .{ .unauthenticated_exception = .{
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
