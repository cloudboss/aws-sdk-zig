const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Protocol = @import("protocol.zig").Protocol;
const ResolverEndpointType = @import("resolver_endpoint_type.zig").ResolverEndpointType;
const UpdateIpAddress = @import("update_ip_address.zig").UpdateIpAddress;
const ResolverEndpoint = @import("resolver_endpoint.zig").ResolverEndpoint;

pub const UpdateResolverEndpointInput = struct {
    /// The name of the Resolver endpoint that you want to update.
    name: ?[]const u8 = null,

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
    ///
    /// You can't change the protocol of an inbound endpoint directly from only Do53
    /// to only DoH, or DoH-FIPS.
    /// This is to prevent a sudden disruption to incoming traffic that
    /// relies on Do53. To change the protocol from Do53 to DoH, or DoH-FIPS, you
    /// must
    /// first enable both Do53 and DoH, or Do53 and DoH-FIPS, to make sure that all
    /// incoming traffic
    /// has transferred to using the DoH protocol, or DoH-FIPS, and then remove the
    /// Do53.
    protocols: ?[]const Protocol = null,

    /// The ID of the Resolver endpoint that you want to update.
    resolver_endpoint_id: []const u8,

    /// Specifies the endpoint type for what type of IP address the endpoint uses to
    /// forward DNS queries.
    ///
    /// Updating to `IPV6` type isn't currently supported.
    resolver_endpoint_type: ?ResolverEndpointType = null,

    /// Updates whether RNI enhanced metrics are enabled for the Resolver endpoints.
    /// When set to true, one-minute granular metrics are published in CloudWatch
    /// for each RNI associated with this endpoint.
    /// When set to false, metrics are not published.
    ///
    /// Standard CloudWatch pricing and charges are applied for using the Route 53
    /// Resolver
    /// endpoint RNI enhanced metrics. For more information, see [Detailed
    /// metrics](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/monitoring-resolver-with-cloudwatch.html).
    rni_enhanced_metrics_enabled: ?bool = null,

    /// Updates whether target name server metrics are enabled for the outbound
    /// Resolver endpoints.
    /// When set to true, one-minute granular metrics are published in CloudWatch
    /// for each target name server associated with this endpoint.
    /// When set to false, metrics are not published. This setting is not supported
    /// for inbound Resolver endpoints.
    ///
    /// Standard CloudWatch pricing and charges are applied for using the Route 53
    /// Resolver
    /// endpoint target name server metrics. For more information, see [Detailed
    /// metrics](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/monitoring-resolver-with-cloudwatch.html).
    target_name_server_metrics_enabled: ?bool = null,

    /// Specifies the IPv6 address when you update the Resolver endpoint from IPv4
    /// to dual-stack.
    /// If you don't specify an IPv6 address, one will be automatically chosen from
    /// your subnet.
    update_ip_addresses: ?[]const UpdateIpAddress = null,

    pub const json_field_names = .{
        .name = "Name",
        .protocols = "Protocols",
        .resolver_endpoint_id = "ResolverEndpointId",
        .resolver_endpoint_type = "ResolverEndpointType",
        .rni_enhanced_metrics_enabled = "RniEnhancedMetricsEnabled",
        .target_name_server_metrics_enabled = "TargetNameServerMetricsEnabled",
        .update_ip_addresses = "UpdateIpAddresses",
    };
};

pub const UpdateResolverEndpointOutput = struct {
    /// The response to an `UpdateResolverEndpoint` request.
    resolver_endpoint: ?ResolverEndpoint = null,

    pub const json_field_names = .{
        .resolver_endpoint = "ResolverEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResolverEndpointInput, options: CallOptions) !UpdateResolverEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResolverEndpointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.UpdateResolverEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResolverEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateResolverEndpointOutput, body, allocator);
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
