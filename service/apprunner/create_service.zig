const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const HealthCheckConfiguration = @import("health_check_configuration.zig").HealthCheckConfiguration;
const InstanceConfiguration = @import("instance_configuration.zig").InstanceConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const ServiceObservabilityConfiguration = @import("service_observability_configuration.zig").ServiceObservabilityConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const Tag = @import("tag.zig").Tag;
const Service = @import("service.zig").Service;

pub const CreateServiceInput = struct {
    /// The Amazon Resource Name (ARN) of an App Runner automatic scaling
    /// configuration resource that you want to associate with your service. If not
    /// provided, App Runner
    /// associates the latest revision of a default auto scaling configuration.
    ///
    /// Specify an ARN with a name and a revision number to associate that revision.
    /// For example:
    /// `arn:aws:apprunner:us-east-1:123456789012:autoscalingconfiguration/high-availability/3`
    ///
    /// Specify just the name to associate the latest revision. For example:
    /// `arn:aws:apprunner:us-east-1:123456789012:autoscalingconfiguration/high-availability`
    auto_scaling_configuration_arn: ?[]const u8 = null,

    /// An optional custom encryption key that App Runner uses to encrypt the copy
    /// of your source repository that it maintains and your service logs. By
    /// default,
    /// App Runner uses an Amazon Web Services managed key.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The settings for the health check that App Runner performs to monitor the
    /// health of the App Runner service.
    health_check_configuration: ?HealthCheckConfiguration = null,

    /// The runtime configuration of instances (scaling units) of your service.
    instance_configuration: ?InstanceConfiguration = null,

    /// Configuration settings related to network traffic of the web application
    /// that the App Runner service runs.
    network_configuration: ?NetworkConfiguration = null,

    /// The observability configuration of your service.
    observability_configuration: ?ServiceObservabilityConfiguration = null,

    /// A name for the App Runner service. It must be unique across all the running
    /// App Runner services in your Amazon Web Services account in the Amazon Web
    /// Services Region.
    service_name: []const u8,

    /// The source to deploy to the App Runner service. It can be a code or an image
    /// repository.
    source_configuration: SourceConfiguration,

    /// An optional list of metadata items that you can associate with the App
    /// Runner service resource. A tag is a key-value pair.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .auto_scaling_configuration_arn = "AutoScalingConfigurationArn",
        .encryption_configuration = "EncryptionConfiguration",
        .health_check_configuration = "HealthCheckConfiguration",
        .instance_configuration = "InstanceConfiguration",
        .network_configuration = "NetworkConfiguration",
        .observability_configuration = "ObservabilityConfiguration",
        .service_name = "ServiceName",
        .source_configuration = "SourceConfiguration",
        .tags = "Tags",
    };
};

pub const CreateServiceOutput = struct {
    /// The unique ID of the asynchronous operation that this request started. You
    /// can use it combined with the
    /// [ListOperations](https://docs.aws.amazon.com/apprunner/latest/api/API_ListOperations.html) call to track the operation's progress.
    operation_id: []const u8,

    /// A description of the App Runner service that's created by this request.
    service: ?Service = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
        .service = "Service",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceInput, options: Options) !CreateServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apprunner");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apprunner", "AppRunner", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AppRunner.CreateService");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateServiceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateServiceOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
