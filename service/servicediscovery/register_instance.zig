const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const RegisterInstanceInput = struct {
    /// A string map that contains the following information for the service that
    /// you specify in
    /// `ServiceId`:
    ///
    /// * The attributes that apply to the records that are defined in the service.
    ///
    /// * For each attribute, the applicable value.
    ///
    /// Do not include sensitive information in the attributes if the namespace is
    /// discoverable by
    /// public DNS queries.
    ///
    /// The following are the supported attribute keys.
    ///
    /// **AWS_ALIAS_DNS_NAME**
    ///
    /// If you want Cloud Map to create an Amazon Route 53 alias record that routes
    /// traffic to an
    /// Elastic Load Balancing load balancer, specify the DNS name that's associated
    /// with the load balancer. For
    /// information about how to get the DNS name, see "DNSName" in the topic
    /// [AliasTarget](https://docs.aws.amazon.com/Route53/latest/APIReference/API_AliasTarget.html) in the *Route 53 API Reference*.
    ///
    /// Note the following:
    ///
    /// * The configuration for the service that's specified by `ServiceId` must
    /// include settings for an `A` record, an `AAAA` record, or both.
    ///
    /// * In the service that's specified by `ServiceId`, the value of
    /// `RoutingPolicy` must be `WEIGHTED`.
    ///
    /// * If the service that's specified by `ServiceId` includes
    /// `HealthCheckConfig` settings, Cloud Map will create the Route 53 health
    /// check, but
    /// it doesn't associate the health check with the alias record.
    ///
    /// * Cloud Map currently doesn't support creating alias records that route
    ///   traffic to
    /// Amazon Web Services resources other than Elastic Load Balancing load
    /// balancers.
    ///
    /// * If you specify a value for `AWS_ALIAS_DNS_NAME`, don't specify values for
    /// any of the `AWS_INSTANCE` attributes.
    ///
    /// * The `AWS_ALIAS_DNS_NAME` is not supported in the GovCloud (US)
    /// Regions.
    ///
    /// **AWS_EC2_INSTANCE_ID**
    ///
    /// *HTTP namespaces only.* The Amazon EC2 instance ID for the instance. If the
    /// `AWS_EC2_INSTANCE_ID` attribute is specified, then the only other attribute
    /// that
    /// can be specified is `AWS_INIT_HEALTH_STATUS`. When the
    /// `AWS_EC2_INSTANCE_ID` attribute is specified, then the
    /// `AWS_INSTANCE_IPV4` attribute will be filled out with the primary private
    /// IPv4
    /// address.
    ///
    /// **AWS_INIT_HEALTH_STATUS**
    ///
    /// If the service configuration includes `HealthCheckCustomConfig`, you can
    /// optionally use `AWS_INIT_HEALTH_STATUS` to specify the initial status of the
    /// custom
    /// health check, `HEALTHY` or `UNHEALTHY`. If you don't specify a value for
    /// `AWS_INIT_HEALTH_STATUS`, the initial status is `HEALTHY`.
    ///
    /// **AWS_INSTANCE_CNAME**
    ///
    /// If the service configuration includes a `CNAME` record, the domain name that
    /// you want Route 53 to return in response to DNS queries (for example,
    /// `example.com`).
    ///
    /// This value is required if the service specified by `ServiceId` includes
    /// settings for an `CNAME` record.
    ///
    /// **AWS_INSTANCE_IPV4**
    ///
    /// If the service configuration includes an `A` record, the IPv4 address that
    /// you
    /// want Route 53 to return in response to DNS queries (for example,
    /// `192.0.2.44`).
    ///
    /// This value is required if the service specified by `ServiceId` includes
    /// settings for an `A` record. If the service includes settings for an
    /// `SRV` record, you must specify a value for `AWS_INSTANCE_IPV4`,
    /// `AWS_INSTANCE_IPV6`, or both.
    ///
    /// **AWS_INSTANCE_IPV6**
    ///
    /// If the service configuration includes an `AAAA` record, the IPv6 address
    /// that
    /// you want Route 53 to return in response to DNS queries (for example,
    /// `2001:0db8:85a3:0000:0000:abcd:0001:2345`).
    ///
    /// This value is required if the service specified by `ServiceId` includes
    /// settings for an `AAAA` record. If the service includes settings for an
    /// `SRV` record, you must specify a value for `AWS_INSTANCE_IPV4`,
    /// `AWS_INSTANCE_IPV6`, or both.
    ///
    /// **AWS_INSTANCE_PORT**
    ///
    /// If the service includes an `SRV` record, the value that you want Route 53 to
    /// return for the port.
    ///
    /// If the service includes `HealthCheckConfig`, the port on the endpoint that
    /// you
    /// want Route 53 to send requests to.
    ///
    /// This value is required if you specified settings for an `SRV` record or a
    /// Route 53 health check when you created the service.
    ///
    /// **Custom attributes**
    ///
    /// You can add up to 30 custom attributes. For each key-value pair, the maximum
    /// length of
    /// the attribute name is 255 characters, and the maximum length of the
    /// attribute value is 1,024
    /// characters. The total size of all provided attributes (sum of all keys and
    /// values) must not
    /// exceed 5,000 characters.
    attributes: []const aws.map.StringMapEntry,

    /// A unique string that identifies the request and that allows failed
    /// `RegisterInstance` requests to be retried without the risk of executing the
    /// operation
    /// twice. You must use a unique `CreatorRequestId` string every time you submit
    /// a
    /// `RegisterInstance` request if you're registering additional instances for
    /// the same
    /// namespace and service. `CreatorRequestId` can be any unique string (for
    /// example, a
    /// date/time stamp).
    creator_request_id: ?[]const u8 = null,

    /// An identifier that you want to associate with the instance. Note the
    /// following:
    ///
    /// * If the service that's specified by `ServiceId` includes settings for an
    /// `SRV` record, the value of `InstanceId` is automatically included as
    /// part of the value for the `SRV` record. For more information, see [DnsRecord
    /// >
    /// Type](https://docs.aws.amazon.com/cloud-map/latest/api/API_DnsRecord.html#cloudmap-Type-DnsRecord-Type).
    ///
    /// * You can use this value to update an existing instance.
    ///
    /// * To register a new instance, you must specify a value that's unique among
    ///   instances that
    /// you register by using the same service.
    ///
    /// * If you specify an existing `InstanceId` and `ServiceId`, Cloud Map
    /// updates the existing DNS records, if any. If there's also an existing health
    /// check, Cloud Map
    /// deletes the old health check and creates a new one.
    ///
    /// The health check isn't deleted immediately, so it will still appear for a
    /// while if you
    /// submit a `ListHealthChecks` request, for example.
    ///
    /// Do not include sensitive information in `InstanceId` if the namespace is
    /// discoverable by public DNS queries and any `Type` member of `DnsRecord`
    /// for the service contains `SRV` because the `InstanceId` is discoverable by
    /// public DNS queries.
    instance_id: []const u8,

    /// The ID or Amazon Resource Name (ARN) of the service that you want to use for
    /// settings for the instance. For
    /// services created in a shared namespace, specify the service ARN. For more
    /// information about
    /// shared namespaces, see [Cross-account Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the
    /// *Cloud Map Developer Guide*.
    service_id: []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .creator_request_id = "CreatorRequestId",
        .instance_id = "InstanceId",
        .service_id = "ServiceId",
    };
};

pub const RegisterInstanceOutput = struct {
    /// A value that you can use to determine whether the request completed
    /// successfully.
    /// To get the status of the operation, see
    /// [GetOperation](https://docs.aws.amazon.com/cloud-map/latest/api/API_GetOperation.html).
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterInstanceInput, options: CallOptions) !RegisterInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "servicediscovery");

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicediscovery", "ServiceDiscovery", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.RegisterInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterInstanceOutput, body, allocator);
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
