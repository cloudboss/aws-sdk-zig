const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DnsConfig = @import("dns_config.zig").DnsConfig;
const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;
const HealthCheckCustomConfig = @import("health_check_custom_config.zig").HealthCheckCustomConfig;
const Tag = @import("tag.zig").Tag;
const ServiceTypeOption = @import("service_type_option.zig").ServiceTypeOption;
const Service = @import("service.zig").Service;

pub const CreateServiceInput = struct {
    /// A unique string that identifies the request and that allows failed
    /// `CreateService` requests to be retried without the risk of running the
    /// operation
    /// twice. `CreatorRequestId` can be any unique string (for example, a
    /// date/timestamp).
    creator_request_id: ?[]const u8 = null,

    /// A description for the service.
    description: ?[]const u8 = null,

    /// A complex type that contains information about the Amazon Route 53 records
    /// that you want
    /// Cloud Map to create when you register an instance.
    dns_config: ?DnsConfig = null,

    /// *Public DNS and HTTP namespaces only.* A complex type that contains
    /// settings for an optional Route 53 health check. If you specify settings for
    /// a health check,
    /// Cloud Map associates the health check with all the Route 53 DNS records that
    /// you specify in
    /// `DnsConfig`.
    ///
    /// If you specify a health check configuration, you can specify either
    /// `HealthCheckCustomConfig` or `HealthCheckConfig` but not both.
    ///
    /// For information about the charges for health checks, see [Cloud Map
    /// Pricing](http://aws.amazon.com/cloud-map/pricing/).
    health_check_config: ?HealthCheckConfig = null,

    /// A complex type that contains information about an optional custom health
    /// check.
    ///
    /// If you specify a health check configuration, you can specify either
    /// `HealthCheckCustomConfig` or `HealthCheckConfig` but not both.
    ///
    /// You can't add, update, or delete a `HealthCheckCustomConfig` configuration
    /// from
    /// an existing service.
    health_check_custom_config: ?HealthCheckCustomConfig = null,

    /// The name that you want to assign to the service.
    ///
    /// Do not include sensitive information in the name if the namespace is
    /// discoverable by public
    /// DNS queries.
    ///
    /// If you want Cloud Map to create an `SRV` record when you register an
    /// instance
    /// and you're using a system that requires a specific `SRV` format, such as
    /// [HAProxy](http://www.haproxy.org/), specify the following for
    /// `Name`:
    ///
    /// * Start the name with an underscore (_), such as `_exampleservice`.
    ///
    /// * End the name with *._protocol*, such as `._tcp`.
    ///
    /// When you register an instance, Cloud Map creates an `SRV` record and assigns
    /// a
    /// name to the record by concatenating the service name and the namespace name
    /// (for example,
    ///
    /// `_exampleservice._tcp.example.com`).
    ///
    /// For services that are accessible by DNS queries, you can't create multiple
    /// services with
    /// names that differ only by case (such as EXAMPLE and example). Otherwise,
    /// these services have the
    /// same DNS name and can't be distinguished. However, if you use a namespace
    /// that's only accessible
    /// by API calls, then you can create services that with names that differ only
    /// by case.
    name: []const u8,

    /// The ID or Amazon Resource Name (ARN) of the namespace that you want to use
    /// to create the service. For
    /// namespaces shared with your Amazon Web Services account, specify the
    /// namespace ARN. For more information
    /// about shared namespaces, see [Cross-account Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the
    /// *Cloud Map Developer Guide*.
    namespace_id: ?[]const u8 = null,

    /// The tags to add to the service. Each tag consists of a key and an optional
    /// value that you
    /// define. Tags keys can be up to 128 characters in length, and tag values can
    /// be up to 256
    /// characters in length.
    tags: ?[]const Tag = null,

    /// If present, specifies that the service instances are only discoverable using
    /// the
    /// `DiscoverInstances` API operation. No DNS records is registered for the
    /// service
    /// instances. The only valid value is `HTTP`.
    type: ?ServiceTypeOption = null,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .description = "Description",
        .dns_config = "DnsConfig",
        .health_check_config = "HealthCheckConfig",
        .health_check_custom_config = "HealthCheckCustomConfig",
        .name = "Name",
        .namespace_id = "NamespaceId",
        .tags = "Tags",
        .type = "Type",
    };
};

pub const CreateServiceOutput = struct {
    /// A complex type that contains information about the new service.
    service: ?Service = null,

    pub const json_field_names = .{
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "servicediscovery");

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
    const endpoint = try config.getEndpointForService("servicediscovery", "ServiceDiscovery", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "Route53AutoNaming_v20170314.CreateService");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
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

    if (std.mem.eql(u8, error_code, "CustomHealthNotFound")) {
        return .{ .arena = arena, .kind = .{ .custom_health_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequest")) {
        return .{ .arena = arena, .kind = .{ .duplicate_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceNotFound")) {
        return .{ .arena = arena, .kind = .{ .instance_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInput")) {
        return .{ .arena = arena, .kind = .{ .invalid_input = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NamespaceAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .namespace_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NamespaceNotFound")) {
        return .{ .arena = arena, .kind = .{ .namespace_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotFound")) {
        return .{ .arena = arena, .kind = .{ .operation_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .request_limit_exceeded = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .service_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceAttributesLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_attributes_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotFound")) {
        return .{ .arena = arena, .kind = .{ .service_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
