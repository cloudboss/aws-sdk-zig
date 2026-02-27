const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const HealthCheckConfiguration = @import("health_check_configuration.zig").HealthCheckConfiguration;
const InstanceConfiguration = @import("instance_configuration.zig").InstanceConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const ServiceObservabilityConfiguration = @import("service_observability_configuration.zig").ServiceObservabilityConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const Service = @import("service.zig").Service;

pub const UpdateServiceInput = struct {
    /// The Amazon Resource Name (ARN) of an App Runner automatic scaling
    /// configuration resource that you want to associate with the App Runner
    /// service.
    auto_scaling_configuration_arn: ?[]const u8 = null,

    /// The settings for the health check that App Runner performs to monitor the
    /// health of the App Runner service.
    health_check_configuration: ?HealthCheckConfiguration = null,

    /// The runtime configuration to apply to instances (scaling units) of your
    /// service.
    instance_configuration: ?InstanceConfiguration = null,

    /// Configuration settings related to network traffic of the web application
    /// that the App Runner service runs.
    network_configuration: ?NetworkConfiguration = null,

    /// The observability configuration of your service.
    observability_configuration: ?ServiceObservabilityConfiguration = null,

    /// The Amazon Resource Name (ARN) of the App Runner service that you want to
    /// update.
    service_arn: []const u8,

    /// The source configuration to apply to the App Runner service.
    ///
    /// You can change the configuration of the code or image repository that the
    /// service uses. However, you can't switch from code to image or the other way
    /// around. This means that you must provide the same structure member of
    /// `SourceConfiguration` that you originally included when you created the
    /// service. Specifically, you can include either `CodeRepository` or
    /// `ImageRepository`. To update the source configuration, set the
    /// values to members of the structure that you include.
    source_configuration: ?SourceConfiguration = null,

    pub const json_field_names = .{
        .auto_scaling_configuration_arn = "AutoScalingConfigurationArn",
        .health_check_configuration = "HealthCheckConfiguration",
        .instance_configuration = "InstanceConfiguration",
        .network_configuration = "NetworkConfiguration",
        .observability_configuration = "ObservabilityConfiguration",
        .service_arn = "ServiceArn",
        .source_configuration = "SourceConfiguration",
    };
};

pub const UpdateServiceOutput = struct {
    /// The unique ID of the asynchronous operation that this request started. You
    /// can use it combined with the ListOperations call to track
    /// the operation's progress.
    operation_id: []const u8,

    /// A description of the App Runner service updated by this request. All
    /// configuration values in the returned `Service` structure reflect
    /// configuration changes that are being applied by this request.
    service: ?Service = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
        .service = "Service",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceInput, options: Options) !UpdateServiceOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateServiceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AppRunner.UpdateService");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateServiceOutput, body, alloc);
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
