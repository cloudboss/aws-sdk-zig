const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResponseHeadersPolicy = @import("response_headers_policy.zig").ResponseHeadersPolicy;
const serde = @import("serde.zig");

pub const GetResponseHeadersPolicyInput = struct {
    /// The identifier for the response headers policy.
    ///
    /// If the response headers policy is attached to a distribution's cache
    /// behavior, you can get the policy's identifier using `ListDistributions` or
    /// `GetDistribution`. If the response headers policy is not attached to a cache
    /// behavior, you can get the identifier using `ListResponseHeadersPolicies`.
    id: []const u8,
};

pub const GetResponseHeadersPolicyOutput = struct {
    /// The version identifier for the current version of the response headers
    /// policy.
    e_tag: ?[]const u8 = null,

    /// Contains a response headers policy.
    response_headers_policy: ?ResponseHeadersPolicy = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResponseHeadersPolicyInput, options: Options) !GetResponseHeadersPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudfront");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetResponseHeadersPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2020-05-31/response-headers-policy/");
    try path_buf.appendSlice(alloc, input.id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetResponseHeadersPolicyOutput {
    var result: GetResponseHeadersPolicyOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try alloc.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .arena = arena, .kind = .{ .access_denied = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchTooLarge")) {
        return .{ .arena = arena, .kind = .{ .batch_too_large = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CachePolicyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .cache_policy_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CachePolicyInUse")) {
        return .{ .arena = arena, .kind = .{ .cache_policy_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotChangeImmutablePublicKeyFields")) {
        return .{ .arena = arena, .kind = .{ .cannot_change_immutable_public_key_fields = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteEntityWhileInUse")) {
        return .{ .arena = arena, .kind = .{ .cannot_delete_entity_while_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotUpdateEntityWhileInUse")) {
        return .{ .arena = arena, .kind = .{ .cannot_update_entity_while_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudFrontOriginAccessIdentityAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .cloud_front_origin_access_identity_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudFrontOriginAccessIdentityInUse")) {
        return .{ .arena = arena, .kind = .{ .cloud_front_origin_access_identity_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CNAMEAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .cname_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ContinuousDeploymentPolicyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .continuous_deployment_policy_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ContinuousDeploymentPolicyInUse")) {
        return .{ .arena = arena, .kind = .{ .continuous_deployment_policy_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DistributionAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .distribution_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DistributionNotDisabled")) {
        return .{ .arena = arena, .kind = .{ .distribution_not_disabled = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .entity_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .entity_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityNotFound")) {
        return .{ .arena = arena, .kind = .{ .entity_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntitySizeLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .entity_size_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FieldLevelEncryptionConfigAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .field_level_encryption_config_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FieldLevelEncryptionConfigInUse")) {
        return .{ .arena = arena, .kind = .{ .field_level_encryption_config_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FieldLevelEncryptionProfileAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .field_level_encryption_profile_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FieldLevelEncryptionProfileInUse")) {
        return .{ .arena = arena, .kind = .{ .field_level_encryption_profile_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FieldLevelEncryptionProfileSizeExceeded")) {
        return .{ .arena = arena, .kind = .{ .field_level_encryption_profile_size_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FunctionAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .function_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FunctionInUse")) {
        return .{ .arena = arena, .kind = .{ .function_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FunctionSizeLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .function_size_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalDelete")) {
        return .{ .arena = arena, .kind = .{ .illegal_delete = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalFieldLevelEncryptionConfigAssociationWithCacheBehavior")) {
        return .{ .arena = arena, .kind = .{ .illegal_field_level_encryption_config_association_with_cache_behavior = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalOriginAccessConfiguration")) {
        return .{ .arena = arena, .kind = .{ .illegal_origin_access_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalUpdate")) {
        return .{ .arena = arena, .kind = .{ .illegal_update = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InconsistentQuantities")) {
        return .{ .arena = arena, .kind = .{ .inconsistent_quantities = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgument")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociation")) {
        return .{ .arena = arena, .kind = .{ .invalid_association = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDefaultRootObject")) {
        return .{ .arena = arena, .kind = .{ .invalid_default_root_object = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDomainNameForOriginAccessControl")) {
        return .{ .arena = arena, .kind = .{ .invalid_domain_name_for_origin_access_control = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidErrorCode")) {
        return .{ .arena = arena, .kind = .{ .invalid_error_code = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidForwardCookies")) {
        return .{ .arena = arena, .kind = .{ .invalid_forward_cookies = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFunctionAssociation")) {
        return .{ .arena = arena, .kind = .{ .invalid_function_association = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGeoRestrictionParameter")) {
        return .{ .arena = arena, .kind = .{ .invalid_geo_restriction_parameter = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidHeadersForS3Origin")) {
        return .{ .arena = arena, .kind = .{ .invalid_headers_for_s3_origin = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIfMatchVersion")) {
        return .{ .arena = arena, .kind = .{ .invalid_if_match_version = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLambdaFunctionAssociation")) {
        return .{ .arena = arena, .kind = .{ .invalid_lambda_function_association = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLocationCode")) {
        return .{ .arena = arena, .kind = .{ .invalid_location_code = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMinimumProtocolVersion")) {
        return .{ .arena = arena, .kind = .{ .invalid_minimum_protocol_version = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOrigin")) {
        return .{ .arena = arena, .kind = .{ .invalid_origin = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOriginAccessControl")) {
        return .{ .arena = arena, .kind = .{ .invalid_origin_access_control = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOriginAccessIdentity")) {
        return .{ .arena = arena, .kind = .{ .invalid_origin_access_identity = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOriginKeepaliveTimeout")) {
        return .{ .arena = arena, .kind = .{ .invalid_origin_keepalive_timeout = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOriginReadTimeout")) {
        return .{ .arena = arena, .kind = .{ .invalid_origin_read_timeout = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidProtocolSettings")) {
        return .{ .arena = arena, .kind = .{ .invalid_protocol_settings = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidQueryStringParameters")) {
        return .{ .arena = arena, .kind = .{ .invalid_query_string_parameters = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRelativePath")) {
        return .{ .arena = arena, .kind = .{ .invalid_relative_path = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequiredProtocol")) {
        return .{ .arena = arena, .kind = .{ .invalid_required_protocol = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResponseCode")) {
        return .{ .arena = arena, .kind = .{ .invalid_response_code = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagging")) {
        return .{ .arena = arena, .kind = .{ .invalid_tagging = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTTLOrder")) {
        return .{ .arena = arena, .kind = .{ .invalid_ttl_order = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidViewerCertificate")) {
        return .{ .arena = arena, .kind = .{ .invalid_viewer_certificate = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWebACLId")) {
        return .{ .arena = arena, .kind = .{ .invalid_web_acl_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeyGroupAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .key_group_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingBody")) {
        return .{ .arena = arena, .kind = .{ .missing_body = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MonitoringSubscriptionAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .monitoring_subscription_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchCachePolicy")) {
        return .{ .arena = arena, .kind = .{ .no_such_cache_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchCloudFrontOriginAccessIdentity")) {
        return .{ .arena = arena, .kind = .{ .no_such_cloud_front_origin_access_identity = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchContinuousDeploymentPolicy")) {
        return .{ .arena = arena, .kind = .{ .no_such_continuous_deployment_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchDistribution")) {
        return .{ .arena = arena, .kind = .{ .no_such_distribution = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchFieldLevelEncryptionConfig")) {
        return .{ .arena = arena, .kind = .{ .no_such_field_level_encryption_config = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchFieldLevelEncryptionProfile")) {
        return .{ .arena = arena, .kind = .{ .no_such_field_level_encryption_profile = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchFunctionExists")) {
        return .{ .arena = arena, .kind = .{ .no_such_function_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchInvalidation")) {
        return .{ .arena = arena, .kind = .{ .no_such_invalidation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchMonitoringSubscription")) {
        return .{ .arena = arena, .kind = .{ .no_such_monitoring_subscription = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchOrigin")) {
        return .{ .arena = arena, .kind = .{ .no_such_origin = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchOriginAccessControl")) {
        return .{ .arena = arena, .kind = .{ .no_such_origin_access_control = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchOriginRequestPolicy")) {
        return .{ .arena = arena, .kind = .{ .no_such_origin_request_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchPublicKey")) {
        return .{ .arena = arena, .kind = .{ .no_such_public_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchRealtimeLogConfig")) {
        return .{ .arena = arena, .kind = .{ .no_such_realtime_log_config = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchResource")) {
        return .{ .arena = arena, .kind = .{ .no_such_resource = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchResponseHeadersPolicy")) {
        return .{ .arena = arena, .kind = .{ .no_such_response_headers_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchStreamingDistribution")) {
        return .{ .arena = arena, .kind = .{ .no_such_streaming_distribution = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OriginAccessControlAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .origin_access_control_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OriginAccessControlInUse")) {
        return .{ .arena = arena, .kind = .{ .origin_access_control_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OriginRequestPolicyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .origin_request_policy_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OriginRequestPolicyInUse")) {
        return .{ .arena = arena, .kind = .{ .origin_request_policy_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailed")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PublicKeyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .public_key_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PublicKeyInUse")) {
        return .{ .arena = arena, .kind = .{ .public_key_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryArgProfileEmpty")) {
        return .{ .arena = arena, .kind = .{ .query_arg_profile_empty = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RealtimeLogConfigAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .realtime_log_config_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RealtimeLogConfigInUse")) {
        return .{ .arena = arena, .kind = .{ .realtime_log_config_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RealtimeLogConfigOwnerMismatch")) {
        return .{ .arena = arena, .kind = .{ .realtime_log_config_owner_mismatch = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotDisabled")) {
        return .{ .arena = arena, .kind = .{ .resource_not_disabled = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResponseHeadersPolicyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .response_headers_policy_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResponseHeadersPolicyInUse")) {
        return .{ .arena = arena, .kind = .{ .response_headers_policy_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StagingDistributionInUse")) {
        return .{ .arena = arena, .kind = .{ .staging_distribution_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StreamingDistributionAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .streaming_distribution_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StreamingDistributionNotDisabled")) {
        return .{ .arena = arena, .kind = .{ .streaming_distribution_not_disabled = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TestFunctionFailed")) {
        return .{ .arena = arena, .kind = .{ .test_function_failed = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooLongCSPInResponseHeadersPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_long_csp_in_response_headers_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCacheBehaviors")) {
        return .{ .arena = arena, .kind = .{ .too_many_cache_behaviors = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCachePolicies")) {
        return .{ .arena = arena, .kind = .{ .too_many_cache_policies = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCertificates")) {
        return .{ .arena = arena, .kind = .{ .too_many_certificates = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCloudFrontOriginAccessIdentities")) {
        return .{ .arena = arena, .kind = .{ .too_many_cloud_front_origin_access_identities = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyContinuousDeploymentPolicies")) {
        return .{ .arena = arena, .kind = .{ .too_many_continuous_deployment_policies = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCookieNamesInWhiteList")) {
        return .{ .arena = arena, .kind = .{ .too_many_cookie_names_in_white_list = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCookiesInCachePolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_cookies_in_cache_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCookiesInOriginRequestPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_cookies_in_origin_request_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCustomHeadersInResponseHeadersPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_custom_headers_in_response_headers_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionCNAMEs")) {
        return .{ .arena = arena, .kind = .{ .too_many_distribution_cnam_es = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributions")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsAssociatedToCachePolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_associated_to_cache_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsAssociatedToFieldLevelEncryptionConfig")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_associated_to_field_level_encryption_config = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsAssociatedToKeyGroup")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_associated_to_key_group = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsAssociatedToOriginAccessControl")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_associated_to_origin_access_control = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsAssociatedToOriginRequestPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_associated_to_origin_request_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsAssociatedToResponseHeadersPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_associated_to_response_headers_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsWithFunctionAssociations")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_with_function_associations = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsWithLambdaAssociations")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_with_lambda_associations = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyDistributionsWithSingleFunctionARN")) {
        return .{ .arena = arena, .kind = .{ .too_many_distributions_with_single_function_arn = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFieldLevelEncryptionConfigs")) {
        return .{ .arena = arena, .kind = .{ .too_many_field_level_encryption_configs = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFieldLevelEncryptionContentTypeProfiles")) {
        return .{ .arena = arena, .kind = .{ .too_many_field_level_encryption_content_type_profiles = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFieldLevelEncryptionEncryptionEntities")) {
        return .{ .arena = arena, .kind = .{ .too_many_field_level_encryption_encryption_entities = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFieldLevelEncryptionFieldPatterns")) {
        return .{ .arena = arena, .kind = .{ .too_many_field_level_encryption_field_patterns = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFieldLevelEncryptionProfiles")) {
        return .{ .arena = arena, .kind = .{ .too_many_field_level_encryption_profiles = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFieldLevelEncryptionQueryArgProfiles")) {
        return .{ .arena = arena, .kind = .{ .too_many_field_level_encryption_query_arg_profiles = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFunctionAssociations")) {
        return .{ .arena = arena, .kind = .{ .too_many_function_associations = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFunctions")) {
        return .{ .arena = arena, .kind = .{ .too_many_functions = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyHeadersInCachePolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_headers_in_cache_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyHeadersInForwardedValues")) {
        return .{ .arena = arena, .kind = .{ .too_many_headers_in_forwarded_values = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyHeadersInOriginRequestPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_headers_in_origin_request_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyInvalidationsInProgress")) {
        return .{ .arena = arena, .kind = .{ .too_many_invalidations_in_progress = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyKeyGroups")) {
        return .{ .arena = arena, .kind = .{ .too_many_key_groups = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyKeyGroupsAssociatedToDistribution")) {
        return .{ .arena = arena, .kind = .{ .too_many_key_groups_associated_to_distribution = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyLambdaFunctionAssociations")) {
        return .{ .arena = arena, .kind = .{ .too_many_lambda_function_associations = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyOriginAccessControls")) {
        return .{ .arena = arena, .kind = .{ .too_many_origin_access_controls = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyOriginCustomHeaders")) {
        return .{ .arena = arena, .kind = .{ .too_many_origin_custom_headers = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyOriginGroupsPerDistribution")) {
        return .{ .arena = arena, .kind = .{ .too_many_origin_groups_per_distribution = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyOriginRequestPolicies")) {
        return .{ .arena = arena, .kind = .{ .too_many_origin_request_policies = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyOrigins")) {
        return .{ .arena = arena, .kind = .{ .too_many_origins = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyPublicKeys")) {
        return .{ .arena = arena, .kind = .{ .too_many_public_keys = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyPublicKeysInKeyGroup")) {
        return .{ .arena = arena, .kind = .{ .too_many_public_keys_in_key_group = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyQueryStringParameters")) {
        return .{ .arena = arena, .kind = .{ .too_many_query_string_parameters = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyQueryStringsInCachePolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_query_strings_in_cache_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyQueryStringsInOriginRequestPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_query_strings_in_origin_request_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRealtimeLogConfigs")) {
        return .{ .arena = arena, .kind = .{ .too_many_realtime_log_configs = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRemoveHeadersInResponseHeadersPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_remove_headers_in_response_headers_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyResponseHeadersPolicies")) {
        return .{ .arena = arena, .kind = .{ .too_many_response_headers_policies = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyStreamingDistributionCNAMEs")) {
        return .{ .arena = arena, .kind = .{ .too_many_streaming_distribution_cnam_es = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyStreamingDistributions")) {
        return .{ .arena = arena, .kind = .{ .too_many_streaming_distributions = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrustedSigners")) {
        return .{ .arena = arena, .kind = .{ .too_many_trusted_signers = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustedKeyGroupDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .trusted_key_group_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustedSignerDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .trusted_signer_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperation")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation = .{
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
