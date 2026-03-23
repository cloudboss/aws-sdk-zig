const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerServiceDeploymentRequest = @import("container_service_deployment_request.zig").ContainerServiceDeploymentRequest;
const ContainerServicePowerName = @import("container_service_power_name.zig").ContainerServicePowerName;
const PrivateRegistryAccessRequest = @import("private_registry_access_request.zig").PrivateRegistryAccessRequest;
const Tag = @import("tag.zig").Tag;
const ContainerService = @import("container_service.zig").ContainerService;

pub const CreateContainerServiceInput = struct {
    /// An object that describes a deployment for the container service.
    ///
    /// A deployment specifies the containers that will be launched on the container
    /// service and
    /// their settings, such as the ports to open, the environment variables to
    /// apply, and the launch
    /// command to run. It also specifies the container that will serve as the
    /// public endpoint of the
    /// deployment and its settings, such as the HTTP or HTTPS port to use, and the
    /// health check
    /// configuration.
    deployment: ?ContainerServiceDeploymentRequest = null,

    /// The power specification for the container service.
    ///
    /// The power specifies the amount of memory, vCPUs, and base monthly cost of
    /// each node of the
    /// container service. The `power` and `scale` of a container service makes
    /// up its configured capacity. To determine the monthly price of your container
    /// service, multiply
    /// the base price of the `power` with the `scale` (the number of nodes) of
    /// the service.
    ///
    /// Use the `GetContainerServicePowers` action to get a list of power options
    /// that
    /// you can specify using this parameter, and their base monthly cost.
    power: ContainerServicePowerName,

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

    /// The scale specification for the container service.
    ///
    /// The scale specifies the allocated compute nodes of the container service.
    /// The
    /// `power` and `scale` of a container service makes up its configured
    /// capacity. To determine the monthly price of your container service, multiply
    /// the base price of
    /// the `power` with the `scale` (the number of nodes) of the
    /// service.
    scale: i32,

    /// The name for the container service.
    ///
    /// The name that you specify for your container service will make up part of
    /// its default
    /// domain. The default domain of a container service is typically
    /// `https://...cs.amazonlightsail.com`.
    /// If the name of your container service is `container-service-1`, and it's
    /// located in
    /// the US East (Ohio) Amazon Web Services Region (`us-east-2`), then the domain
    /// for
    /// your container service will be like the following example:
    /// `https://container-service-1.ur4EXAMPLE2uq.us-east-2.cs.amazonlightsail.com`
    ///
    /// The following are the requirements for container service names:
    ///
    /// * Must be unique within each Amazon Web Services Region in your Lightsail
    /// account.
    ///
    /// * Must contain 1 to 63 characters.
    ///
    /// * Must contain only alphanumeric characters and hyphens.
    ///
    /// * A hyphen (-) can separate words but cannot be at the start or end of the
    ///   name.
    service_name: []const u8,

    /// The tag keys and optional values to add to the container service during
    /// create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    ///
    /// For more information about tags in Lightsail, see the [Amazon Lightsail
    /// Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .deployment = "deployment",
        .power = "power",
        .private_registry_access = "privateRegistryAccess",
        .public_domain_names = "publicDomainNames",
        .scale = "scale",
        .service_name = "serviceName",
        .tags = "tags",
    };
};

pub const CreateContainerServiceOutput = struct {
    /// An object that describes a container service.
    container_service: ?ContainerService = null,

    pub const json_field_names = .{
        .container_service = "containerService",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContainerServiceInput, options: CallOptions) !CreateContainerServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContainerServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateContainerService");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContainerServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateContainerServiceOutput, body, allocator);
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
