const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    /// The subnets and IP addresses in your VPC that DNS queries originate from
    /// (for outbound endpoints) or that you forward
    /// DNS queries to (for inbound endpoints). The subnet ID uniquely identifies a
    /// VPC.
    ///
    /// Even though the minimum is 1, Route 53 requires that you create at least
    /// two.
    ip_addresses: []const IpAddressRequest,

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
        .ip_addresses = "IpAddresses",
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53resolver");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResolverEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyDocument")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_document = .{
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
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceException")) {
        return .{ .arena = arena, .kind = .{ .unknown_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
