const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceInput, options: CallOptions) !UpdateServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apprunner", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apprunner", "AppRunner", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AppRunner.UpdateService");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateServiceOutput, body, allocator);
}
