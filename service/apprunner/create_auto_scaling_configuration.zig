const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const AutoScalingConfiguration = @import("auto_scaling_configuration.zig").AutoScalingConfiguration;

pub const CreateAutoScalingConfigurationInput = struct {
    /// A name for the auto scaling configuration. When you use it for the first
    /// time in an Amazon Web Services Region, App Runner creates revision number
    /// `1` of this name. When you use the same name in subsequent calls, App Runner
    /// creates incremental revisions of the configuration.
    ///
    /// Prior to the release of [Auto scale
    /// configuration
    /// enhancements](https://docs.aws.amazon.com/apprunner/latest/relnotes/release-2023-09-22-auto-scale-config.html), the name `DefaultConfiguration` was reserved.
    ///
    /// This restriction is no longer in place. You can now manage
    /// `DefaultConfiguration` the same way you manage your custom auto scaling
    /// configurations. This means you can do the following with the
    /// `DefaultConfiguration` that App Runner provides:
    ///
    /// * Create new revisions of the `DefaultConfiguration`.
    ///
    /// * Delete the revisions of the `DefaultConfiguration`.
    ///
    /// * Delete the auto scaling configuration for which the App Runner
    ///   `DefaultConfiguration` was created.
    ///
    /// * If you delete the auto scaling configuration you can create another custom
    ///   auto scaling configuration with the same
    /// `DefaultConfiguration` name. The original `DefaultConfiguration` resource
    /// provided by App Runner remains in your account unless
    /// you make changes to it.
    auto_scaling_configuration_name: []const u8,

    /// The maximum number of concurrent requests that you want an instance to
    /// process. If the number of concurrent requests exceeds this limit, App Runner
    /// scales
    /// up your service.
    ///
    /// Default: `100`
    max_concurrency: ?i32 = null,

    /// The maximum number of instances that your service scales up to. At most
    /// `MaxSize` instances actively serve traffic for your service.
    ///
    /// Default: `25`
    max_size: ?i32 = null,

    /// The minimum number of instances that App Runner provisions for your service.
    /// The service always has at least `MinSize` provisioned instances.
    /// Some of them actively serve traffic. The rest of them (provisioned and
    /// inactive instances) are a cost-effective compute capacity reserve and are
    /// ready to
    /// be quickly activated. You pay for memory usage of all the provisioned
    /// instances. You pay for CPU usage of only the active subset.
    ///
    /// App Runner temporarily doubles the number of provisioned instances during
    /// deployments, to maintain the same capacity for both old and new code.
    ///
    /// Default: `1`
    min_size: ?i32 = null,

    /// A list of metadata items that you can associate with your auto scaling
    /// configuration resource. A tag is a key-value pair.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .auto_scaling_configuration_name = "AutoScalingConfigurationName",
        .max_concurrency = "MaxConcurrency",
        .max_size = "MaxSize",
        .min_size = "MinSize",
        .tags = "Tags",
    };
};

pub const CreateAutoScalingConfigurationOutput = struct {
    /// A description of the App Runner auto scaling configuration that's created by
    /// this request.
    auto_scaling_configuration: ?AutoScalingConfiguration = null,

    pub const json_field_names = .{
        .auto_scaling_configuration = "AutoScalingConfiguration",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutoScalingConfigurationInput, options: Options) !CreateAutoScalingConfigurationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAutoScalingConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AppRunner.CreateAutoScalingConfiguration");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAutoScalingConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAutoScalingConfigurationOutput, body, alloc);
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
