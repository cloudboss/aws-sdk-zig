const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ResolverEndpointDirection = @import("resolver_endpoint_direction.zig").ResolverEndpointDirection;
const IpAddressRequest = @import("ip_address_request.zig").IpAddressRequest;
const Protocol = @import("protocol.zig").Protocol;
const ResolverEndpointType = @import("resolver_endpoint_type.zig").ResolverEndpointType;
const Tag = @import("tag.zig").Tag;
const ResolverEndpoint = @import("resolver_endpoint.zig").ResolverEndpoint;

pub const CreateResolverEndpointInput = struct {
    /// A unique string that identifies the request and that allows failed requests
    /// to be retried
    /// without the risk of running the operation twice. `CreatorRequestId` can be
    /// any unique string, for example, a date/time stamp.
    creator_request_id: []const u8,

    /// Specify the applicable value:
    ///
    /// * `INBOUND`: Resolver forwards DNS queries to the DNS service for a VPC from
    ///   your network.
    ///
    /// * `OUTBOUND`: Resolver forwards DNS queries from the DNS service for a VPC
    ///   to your network.
    ///
    /// * `INBOUND_DELEGATION`: Resolver delegates queries to Route 53 private
    ///   hosted zones from your network.
    direction: ResolverEndpointDirection,

    /// Specifies whether DNS64 is enabled for the inbound Resolver endpoint. When
    /// set to `true`, Route 53 Resolver
    /// synthesizes AAAA (IPv6) records for IPv4-only services by prepending the
    /// `64:ff9b::/96` prefix to the IPv4 address.
    /// This enables IPv6-only clients that send queries through the inbound
    /// endpoint to reach IPv4-only services.
    /// DNS64 works with NAT64 to provide complete IPv6-to-IPv4 translation. Default
    /// is false.
    dns_64_enabled: ?bool = null,

    /// The subnets and IP addresses in your VPC that DNS queries originate from
    /// (for outbound endpoints) or that you forward
    /// DNS queries to (for inbound endpoints). The subnet ID uniquely identifies a
    /// VPC.
    ///
    /// Even though the minimum is 1, Route 53 requires that you create at least
    /// two.
    ip_addresses: []const IpAddressRequest,

    /// Specifies whether IPv6 internet access is enabled for the outbound Resolver
    /// endpoint. When set to `true`,
    /// the endpoint elastic network interfaces (ENIs) can forward DNS queries to
    /// public IPv6 targets through an internet gateway.
    /// Default is false.
    ///
    /// When you enable IPv6 internet access, use network controls like security
    /// groups, NACLs, or egress-only internet gateways
    /// to protect the endpoint ENIs from unsolicited ingress traffic. Be aware that
    /// some network controls can affect DNS query
    /// throughput due to connection tracking. For more information, see
    /// [Amazon EC2 security group connection
    /// tracking](https://docs.aws.amazon.com/ec2/latest/userguide/security-group-connection-tracking.html)
    /// and [Resolver endpoint
    /// scaling](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/best-practices-resolver-endpoint-scaling.html).
    ipv_6_internet_access_enabled: ?bool = null,

    /// A friendly name that lets you easily find a configuration in the Resolver
    /// dashboard in the Route 53 console.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Outpost. If you specify this, you must
    /// also specify a
    /// value for the `PreferredInstanceType`.
    outpost_arn: ?[]const u8 = null,

    /// The instance type. If you specify this, you must also specify a value for
    /// the `OutpostArn`.
    preferred_instance_type: ?[]const u8 = null,

    /// The protocols you want to use for the endpoint. DoH-FIPS is applicable for
    /// default inbound endpoints only.
    ///
    /// For a default inbound endpoint you can apply the protocols as follows:
    ///
    /// * Do53 and DoH in combination.
    ///
    /// * Do53 and DoH-FIPS in combination.
    ///
    /// * Do53 alone.
    ///
    /// * DoH alone.
    ///
    /// * DoH-FIPS alone.
    ///
    /// * None, which is treated as Do53.
    ///
    /// For a delegation inbound endpoint you can use Do53 only.
    ///
    /// For an outbound endpoint you can apply the protocols as follows:
    ///
    /// * Do53 and DoH in combination.
    ///
    /// * Do53 alone.
    ///
    /// * DoH alone.
    ///
    /// * None, which is treated as Do53.
    protocols: ?[]const Protocol = null,

    /// For the endpoint type you can choose either IPv4, IPv6, or dual-stack.
    /// A dual-stack endpoint means that it will resolve via both IPv4 and IPv6.
    /// This
    /// endpoint type is applied to all IP addresses.
    resolver_endpoint_type: ?ResolverEndpointType = null,

    /// Specifies whether RNI enhanced metrics are enabled for the Resolver
    /// endpoints.
    /// When set to true, one-minute granular metrics are published in CloudWatch
    /// for each RNI associated with this endpoint.
    /// When set to false, metrics are not published. Default is false.
    ///
    /// Standard CloudWatch pricing and charges are applied for using the Route 53
    /// Resolver
    /// endpoint RNI enhanced metrics. For more information, see [Detailed
    /// metrics](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/monitoring-resolver-with-cloudwatch.html).
    rni_enhanced_metrics_enabled: ?bool = null,

    /// The ID of one or more security groups that you want to use to control access
    /// to this VPC. The security group that you specify
    /// must include one or more inbound rules (for inbound Resolver endpoints) or
    /// outbound rules (for outbound Resolver endpoints).
    /// Inbound and outbound rules must allow TCP and UDP access. For inbound
    /// access, open port 53. For outbound access, open the port
    /// that you're using for DNS queries on your network.
    ///
    /// Some security group rules will cause your connection to be tracked. For
    /// outbound resolver endpoint, it can potentially impact the
    /// maximum queries per second from outbound endpoint to your target name
    /// server. For inbound resolver endpoint, it can bring down the overall maximum
    /// queries per second per IP address to as low as 1500.
    /// To avoid connection tracking caused by security group, see
    /// [Untracked
    /// connections](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html#untracked-connectionsl).
    security_group_ids: []const []const u8,

    /// A list of the tag keys and values that you want to associate with the
    /// endpoint.
    tags: ?[]const Tag = null,

    /// Specifies whether target name server metrics are enabled for the outbound
    /// Resolver endpoints.
    /// When set to true, one-minute granular metrics are published in CloudWatch
    /// for each target name server associated with this endpoint.
    /// When set to false, metrics are not published. Default is false. This is not
    /// supported for inbound Resolver endpoints.
    ///
    /// Standard CloudWatch pricing and charges are applied for using the Route 53
    /// Resolver
    /// endpoint target name server metrics. For more information, see [Detailed
    /// metrics](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/monitoring-resolver-with-cloudwatch.html).
    target_name_server_metrics_enabled: ?bool = null,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .direction = "Direction",
        .dns_64_enabled = "Dns64Enabled",
        .ip_addresses = "IpAddresses",
        .ipv_6_internet_access_enabled = "Ipv6InternetAccessEnabled",
        .name = "Name",
        .outpost_arn = "OutpostArn",
        .preferred_instance_type = "PreferredInstanceType",
        .protocols = "Protocols",
        .resolver_endpoint_type = "ResolverEndpointType",
        .rni_enhanced_metrics_enabled = "RniEnhancedMetricsEnabled",
        .security_group_ids = "SecurityGroupIds",
        .tags = "Tags",
        .target_name_server_metrics_enabled = "TargetNameServerMetricsEnabled",
    };
};

pub const CreateResolverEndpointOutput = struct {
    /// Information about the `CreateResolverEndpoint` request, including the status
    /// of the request.
    resolver_endpoint: ?ResolverEndpoint = null,

    pub const json_field_names = .{
        .resolver_endpoint = "ResolverEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResolverEndpointInput, options: CallOptions) !CreateResolverEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53resolver", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResolverEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.CreateResolverEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResolverEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateResolverEndpointOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        const parsed_error: ?errors.InternalServiceErrorException = aws.json.parseJsonObject(errors.InternalServiceErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?errors.InvalidParameterException = aws.json.parseJsonObject(errors.InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyDocument")) {
        const parsed_error: ?errors.InvalidPolicyDocument = aws.json.parseJsonObject(errors.InvalidPolicyDocument, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_policy_document = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?errors.InvalidRequestException = aws.json.parseJsonObject(errors.InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        const parsed_error: ?errors.InvalidTagException = aws.json.parseJsonObject(errors.InvalidTagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        const parsed_error: ?errors.ResourceExistsException = aws.json.parseJsonObject(errors.ResourceExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        const parsed_error: ?errors.ResourceUnavailableException = aws.json.parseJsonObject(errors.ResourceUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceException")) {
        const parsed_error: ?errors.UnknownResourceException = aws.json.parseJsonObject(errors.UnknownResourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unknown_resource_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
