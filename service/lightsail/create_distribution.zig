const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CacheBehaviorPerPath = @import("cache_behavior_per_path.zig").CacheBehaviorPerPath;
const CacheSettings = @import("cache_settings.zig").CacheSettings;
const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const InputOrigin = @import("input_origin.zig").InputOrigin;
const Tag = @import("tag.zig").Tag;
const ViewerMinimumTlsProtocolVersionEnum = @import("viewer_minimum_tls_protocol_version_enum.zig").ViewerMinimumTlsProtocolVersionEnum;
const LightsailDistribution = @import("lightsail_distribution.zig").LightsailDistribution;
const Operation = @import("operation.zig").Operation;

pub const CreateDistributionInput = struct {
    /// The bundle ID to use for the distribution.
    ///
    /// A distribution bundle describes the specifications of your distribution,
    /// such as the
    /// monthly cost and monthly network transfer quota.
    ///
    /// Use the `GetDistributionBundles` action to get a list of distribution bundle
    /// IDs that you can specify.
    bundle_id: []const u8,

    /// An array of objects that describe the per-path cache behavior for the
    /// distribution.
    cache_behaviors: ?[]const CacheBehaviorPerPath = null,

    /// An object that describes the cache behavior settings for the distribution.
    cache_behavior_settings: ?CacheSettings = null,

    /// The name of the SSL/TLS certificate that you want to attach to the
    /// distribution.
    ///
    /// Use the
    /// [GetCertificates](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetCertificates.html)
    /// action to get a list of certificate names that you can specify.
    certificate_name: ?[]const u8 = null,

    /// An object that describes the default cache behavior for the distribution.
    default_cache_behavior: CacheBehavior,

    /// The name for the distribution.
    distribution_name: []const u8,

    /// The IP address type for the distribution.
    ///
    /// The possible values are `ipv4` for IPv4 only, and `dualstack` for
    /// IPv4 and IPv6.
    ///
    /// The default value is `dualstack`.
    ip_address_type: ?IpAddressType = null,

    /// An object that describes the origin resource for the distribution, such as a
    /// Lightsail
    /// instance, bucket, or load balancer.
    ///
    /// The distribution pulls, caches, and serves content from the origin.
    origin: InputOrigin,

    /// The tag keys and optional values to add to the distribution during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    /// The minimum TLS protocol version for the SSL/TLS certificate.
    viewer_minimum_tls_protocol_version: ?ViewerMinimumTlsProtocolVersionEnum = null,

    pub const json_field_names = .{
        .bundle_id = "bundleId",
        .cache_behaviors = "cacheBehaviors",
        .cache_behavior_settings = "cacheBehaviorSettings",
        .certificate_name = "certificateName",
        .default_cache_behavior = "defaultCacheBehavior",
        .distribution_name = "distributionName",
        .ip_address_type = "ipAddressType",
        .origin = "origin",
        .tags = "tags",
        .viewer_minimum_tls_protocol_version = "viewerMinimumTlsProtocolVersion",
    };
};

pub const CreateDistributionOutput = struct {
    /// An object that describes the distribution created.
    distribution: ?LightsailDistribution = null,

    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operation: ?Operation = null,

    pub const json_field_names = .{
        .distribution = "distribution",
        .operation = "operation",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDistributionInput, options: Options) !CreateDistributionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDistributionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "Lightsail_20161128.CreateDistribution");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDistributionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDistributionOutput, body, alloc);
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
