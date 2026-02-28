const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DeploymentConfig = @import("deployment_config.zig").DeploymentConfig;
const VariantProperty = @import("variant_property.zig").VariantProperty;

pub const UpdateEndpointInput = struct {
    /// The deployment configuration for an endpoint, which contains the desired
    /// deployment strategy and rollback configurations.
    deployment_config: ?DeploymentConfig = null,

    /// The name of the new endpoint configuration.
    endpoint_config_name: []const u8,

    /// The name of the endpoint whose configuration you want to update.
    endpoint_name: []const u8,

    /// When you are updating endpoint resources with `RetainAllVariantProperties`,
    /// whose value is set to `true`, `ExcludeRetainedVariantProperties` specifies
    /// the list of type
    /// [VariantProperty](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VariantProperty.html) to override with the values provided by `EndpointConfig`. If you don't specify a value for `ExcludeRetainedVariantProperties`, no variant properties are overridden.
    exclude_retained_variant_properties: ?[]const VariantProperty = null,

    /// When updating endpoint resources, enables or disables the retention of
    /// [variant
    /// properties](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VariantProperty.html), such as the instance count or the variant weight. To retain the variant properties of an endpoint when updating it, set `RetainAllVariantProperties` to `true`. To use the variant properties specified in a new `EndpointConfig` call when updating an endpoint, set `RetainAllVariantProperties` to `false`. The default is `false`.
    retain_all_variant_properties: ?bool = null,

    /// Specifies whether to reuse the last deployment configuration. The default
    /// value is false (the configuration is not reused).
    retain_deployment_config: ?bool = null,

    pub const json_field_names = .{
        .deployment_config = "DeploymentConfig",
        .endpoint_config_name = "EndpointConfigName",
        .endpoint_name = "EndpointName",
        .exclude_retained_variant_properties = "ExcludeRetainedVariantProperties",
        .retain_all_variant_properties = "RetainAllVariantProperties",
        .retain_deployment_config = "RetainDeploymentConfig",
    };
};

pub const UpdateEndpointOutput = struct {
    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    pub const json_field_names = .{
        .endpoint_arn = "EndpointArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEndpointInput, options: Options) !UpdateEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.UpdateEndpoint");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateEndpointOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateEndpointOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
