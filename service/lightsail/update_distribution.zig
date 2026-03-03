const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CacheBehaviorPerPath = @import("cache_behavior_per_path.zig").CacheBehaviorPerPath;
const CacheSettings = @import("cache_settings.zig").CacheSettings;
const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const InputOrigin = @import("input_origin.zig").InputOrigin;
const ViewerMinimumTlsProtocolVersionEnum = @import("viewer_minimum_tls_protocol_version_enum.zig").ViewerMinimumTlsProtocolVersionEnum;
const Operation = @import("operation.zig").Operation;

pub const UpdateDistributionInput = struct {
    /// An array of objects that describe the per-path cache behavior for the
    /// distribution.
    cache_behaviors: ?[]const CacheBehaviorPerPath = null,

    /// An object that describes the cache behavior settings for the distribution.
    ///
    /// The `cacheBehaviorSettings` specified in your
    /// `UpdateDistributionRequest` will replace your distribution's existing
    /// settings.
    cache_behavior_settings: ?CacheSettings = null,

    /// The name of the SSL/TLS certificate that you want to attach to the
    /// distribution.
    ///
    /// Only certificates with a status of `ISSUED` can be attached to a
    /// distribution.
    ///
    /// Use the
    /// [GetCertificates](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetCertificates.html)
    /// action to get a list of certificate names that you can specify.
    certificate_name: ?[]const u8 = null,

    /// An object that describes the default cache behavior for the distribution.
    default_cache_behavior: ?CacheBehavior = null,

    /// The name of the distribution to update.
    ///
    /// Use the `GetDistributions` action to get a list of distribution names that
    /// you
    /// can specify.
    distribution_name: []const u8,

    /// Indicates whether to enable the distribution.
    is_enabled: ?bool = null,

    /// An object that describes the origin resource for the distribution, such as a
    /// Lightsail
    /// instance, bucket, or load balancer.
    ///
    /// The distribution pulls, caches, and serves content from the origin.
    origin: ?InputOrigin = null,

    /// Indicates whether the default SSL/TLS certificate is attached to the
    /// distribution. The
    /// default value is `true`. When `true`, the distribution uses the default
    /// domain name such as `d111111abcdef8.cloudfront.net`.
    ///
    /// Set this value to `false` to attach a new certificate to the
    /// distribution.
    use_default_certificate: ?bool = null,

    /// Use this parameter to update the minimum TLS protocol version for the
    /// SSL/TLS certificate
    /// that's attached to the distribution.
    viewer_minimum_tls_protocol_version: ?ViewerMinimumTlsProtocolVersionEnum = null,

    pub const json_field_names = .{
        .cache_behaviors = "cacheBehaviors",
        .cache_behavior_settings = "cacheBehaviorSettings",
        .certificate_name = "certificateName",
        .default_cache_behavior = "defaultCacheBehavior",
        .distribution_name = "distributionName",
        .is_enabled = "isEnabled",
        .origin = "origin",
        .use_default_certificate = "useDefaultCertificate",
        .viewer_minimum_tls_protocol_version = "viewerMinimumTlsProtocolVersion",
    };
};

pub const UpdateDistributionOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operation: ?Operation = null,

    pub const json_field_names = .{
        .operation = "operation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDistributionInput, options: CallOptions) !UpdateDistributionOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDistributionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.UpdateDistribution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDistributionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDistributionOutput, body, allocator);
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
