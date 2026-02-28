const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const Tag = @import("tag.zig").Tag;
const Operation = @import("operation.zig").Operation;

pub const CreateLoadBalancerInput = struct {
    /// The optional alternative domains and subdomains to use with your SSL/TLS
    /// certificate
    /// (`www.example.com`, `example.com`, `m.example.com`,
    /// `blog.example.com`).
    certificate_alternative_names: ?[]const []const u8 = null,

    /// The domain name with which your certificate is associated
    /// (`example.com`).
    ///
    /// If you specify `certificateDomainName`, then `certificateName` is
    /// required (and vice-versa).
    certificate_domain_name: ?[]const u8 = null,

    /// The name of the SSL/TLS certificate.
    ///
    /// If you specify `certificateName`, then `certificateDomainName` is
    /// required (and vice-versa).
    certificate_name: ?[]const u8 = null,

    /// The path you provided to perform the load balancer health check. If you
    /// didn't specify a
    /// health check path, Lightsail uses the root path of your website (`"/"`).
    ///
    /// You may want to specify a custom health check path other than the root of
    /// your application
    /// if your home page loads slowly or has a lot of media or scripting on it.
    health_check_path: ?[]const u8 = null,

    /// The instance port where you're creating your load balancer.
    instance_port: ?i32 = null,

    /// The IP address type for the load balancer.
    ///
    /// The possible values are `ipv4` for IPv4 only, `ipv6` for IPv6 only,
    /// and `dualstack` for IPv4 and IPv6.
    ///
    /// The default value is `dualstack`.
    ip_address_type: ?IpAddressType = null,

    /// The name of your load balancer.
    load_balancer_name: []const u8,

    /// The tag keys and optional values to add to the resource during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    /// The name of the TLS policy to apply to the load balancer.
    ///
    /// Use the
    /// [GetLoadBalancerTlsPolicies](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetLoadBalancerTlsPolicies.html) action to get a list of TLS policy names that you can
    /// specify.
    ///
    /// For more information about load balancer TLS policies, see [Configuring TLS
    /// security policies on your Amazon Lightsail load
    /// balancers](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configure-load-balancer-tls-security-policy) in the *Amazon Lightsail Developer Guide*.
    tls_policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_alternative_names = "certificateAlternativeNames",
        .certificate_domain_name = "certificateDomainName",
        .certificate_name = "certificateName",
        .health_check_path = "healthCheckPath",
        .instance_port = "instancePort",
        .ip_address_type = "ipAddressType",
        .load_balancer_name = "loadBalancerName",
        .tags = "tags",
        .tls_policy_name = "tlsPolicyName",
    };
};

pub const CreateLoadBalancerOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLoadBalancerInput, options: Options) !CreateLoadBalancerOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateLoadBalancerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "Lightsail_20161128.CreateLoadBalancer");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateLoadBalancerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLoadBalancerOutput, body, alloc);
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
