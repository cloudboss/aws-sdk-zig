const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TrafficPolicySummary = @import("traffic_policy_summary.zig").TrafficPolicySummary;
const serde = @import("serde.zig");

pub const ListTrafficPoliciesInput = struct {
    /// (Optional) The maximum number of traffic policies that you want Amazon Route
    /// 53 to
    /// return in response to this request. If you have more than `MaxItems` traffic
    /// policies, the value of `IsTruncated` in the response is `true`,
    /// and the value of `TrafficPolicyIdMarker` is the ID of the first traffic
    /// policy that Route 53 will return if you submit another request.
    max_items: ?i32 = null,

    /// (Conditional) For your first request to `ListTrafficPolicies`, don't
    /// include the `TrafficPolicyIdMarker` parameter.
    ///
    /// If you have more traffic policies than the value of `MaxItems`,
    /// `ListTrafficPolicies` returns only the first `MaxItems`
    /// traffic policies. To get the next group of policies, submit another request
    /// to
    /// `ListTrafficPolicies`. For the value of
    /// `TrafficPolicyIdMarker`, specify the value of
    /// `TrafficPolicyIdMarker` that was returned in the previous
    /// response.
    traffic_policy_id_marker: ?[]const u8 = null,
};

pub const ListTrafficPoliciesOutput = struct {
    /// A flag that indicates whether there are more traffic policies to be listed.
    /// If the
    /// response was truncated, you can get the next group of traffic policies by
    /// submitting
    /// another `ListTrafficPolicies` request and specifying the value of
    /// `TrafficPolicyIdMarker` in the `TrafficPolicyIdMarker` request
    /// parameter.
    is_truncated: ?bool = null,

    /// The value that you specified for the `MaxItems` parameter in the
    /// `ListTrafficPolicies` request that produced the current response.
    max_items: i32,

    /// If the value of `IsTruncated` is `true`,
    /// `TrafficPolicyIdMarker` is the ID of the first traffic policy in the next
    /// group of `MaxItems` traffic policies.
    traffic_policy_id_marker: []const u8,

    /// A list that contains one `TrafficPolicySummary` element for each traffic
    /// policy that was created by the current Amazon Web Services account.
    traffic_policy_summaries: ?[]const TrafficPolicySummary = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrafficPoliciesInput, options: Options) !ListTrafficPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrafficPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2013-04-01/trafficpolicies";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxitems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.traffic_policy_id_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "trafficpolicyid=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrafficPoliciesOutput {
    var result: ListTrafficPoliciesOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyIdMarker")) {
                    result.traffic_policy_id_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicySummaries")) {
                    result.traffic_policy_summaries = try serde.deserializeTrafficPolicySummaries(allocator, &reader, "TrafficPolicySummary");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "CidrBlockInUseException")) {
        return .{ .arena = arena, .kind = .{ .cidr_block_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CidrCollectionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .cidr_collection_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CidrCollectionInUseException")) {
        return .{ .arena = arena, .kind = .{ .cidr_collection_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CidrCollectionVersionMismatchException")) {
        return .{ .arena = arena, .kind = .{ .cidr_collection_version_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModification")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictingDomainExists")) {
        return .{ .arena = arena, .kind = .{ .conflicting_domain_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictingTypes")) {
        return .{ .arena = arena, .kind = .{ .conflicting_types = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetAlreadyCreated")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_already_created = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetAlreadyReusable")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_already_reusable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetInUse")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetNotAvailable")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_not_available = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetNotReusable")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_not_reusable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DNSSECNotFound")) {
        return .{ .arena = arena, .kind = .{ .dnssec_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthCheckAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .health_check_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthCheckInUse")) {
        return .{ .arena = arena, .kind = .{ .health_check_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthCheckVersionMismatch")) {
        return .{ .arena = arena, .kind = .{ .health_check_version_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZoneAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZoneNotEmpty")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_not_empty = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZoneNotFound")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZoneNotPrivate")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_not_private = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZonePartiallyDelegated")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_partially_delegated = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleVersion")) {
        return .{ .arena = arena, .kind = .{ .incompatible_version = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCloudWatchLogsResourcePolicy")) {
        return .{ .arena = arena, .kind = .{ .insufficient_cloud_watch_logs_resource_policy = .{
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
    if (std.mem.eql(u8, error_code, "InvalidChangeBatch")) {
        return .{ .arena = arena, .kind = .{ .invalid_change_batch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDomainName")) {
        return .{ .arena = arena, .kind = .{ .invalid_domain_name = .{
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
    if (std.mem.eql(u8, error_code, "InvalidKeySigningKeyName")) {
        return .{ .arena = arena, .kind = .{ .invalid_key_signing_key_name = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKeySigningKeyStatus")) {
        return .{ .arena = arena, .kind = .{ .invalid_key_signing_key_status = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKMSArn")) {
        return .{ .arena = arena, .kind = .{ .invalid_kms_arn = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSigningStatus")) {
        return .{ .arena = arena, .kind = .{ .invalid_signing_status = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTrafficPolicyDocument")) {
        return .{ .arena = arena, .kind = .{ .invalid_traffic_policy_document = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidVPCId")) {
        return .{ .arena = arena, .kind = .{ .invalid_vpc_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeySigningKeyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .key_signing_key_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeySigningKeyInParentDSRecord")) {
        return .{ .arena = arena, .kind = .{ .key_signing_key_in_parent_ds_record = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeySigningKeyInUse")) {
        return .{ .arena = arena, .kind = .{ .key_signing_key_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeySigningKeyWithActiveStatusNotFound")) {
        return .{ .arena = arena, .kind = .{ .key_signing_key_with_active_status_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LastVPCAssociation")) {
        return .{ .arena = arena, .kind = .{ .last_vpc_association = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitsExceeded")) {
        return .{ .arena = arena, .kind = .{ .limits_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchChange")) {
        return .{ .arena = arena, .kind = .{ .no_such_change = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchCidrCollectionException")) {
        return .{ .arena = arena, .kind = .{ .no_such_cidr_collection_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchCidrLocationException")) {
        return .{ .arena = arena, .kind = .{ .no_such_cidr_location_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchCloudWatchLogsLogGroup")) {
        return .{ .arena = arena, .kind = .{ .no_such_cloud_watch_logs_log_group = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchDelegationSet")) {
        return .{ .arena = arena, .kind = .{ .no_such_delegation_set = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchGeoLocation")) {
        return .{ .arena = arena, .kind = .{ .no_such_geo_location = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchHealthCheck")) {
        return .{ .arena = arena, .kind = .{ .no_such_health_check = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchHostedZone")) {
        return .{ .arena = arena, .kind = .{ .no_such_hosted_zone = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKeySigningKey")) {
        return .{ .arena = arena, .kind = .{ .no_such_key_signing_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchQueryLoggingConfig")) {
        return .{ .arena = arena, .kind = .{ .no_such_query_logging_config = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchTrafficPolicy")) {
        return .{ .arena = arena, .kind = .{ .no_such_traffic_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchTrafficPolicyInstance")) {
        return .{ .arena = arena, .kind = .{ .no_such_traffic_policy_instance = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PriorRequestNotComplete")) {
        return .{ .arena = arena, .kind = .{ .prior_request_not_complete = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PublicZoneVPCAssociation")) {
        return .{ .arena = arena, .kind = .{ .public_zone_vpc_association = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryLoggingConfigAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .query_logging_config_already_exists = .{
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
    if (std.mem.eql(u8, error_code, "TooManyHealthChecks")) {
        return .{ .arena = arena, .kind = .{ .too_many_health_checks = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyHostedZones")) {
        return .{ .arena = arena, .kind = .{ .too_many_hosted_zones = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyKeySigningKeys")) {
        return .{ .arena = arena, .kind = .{ .too_many_key_signing_keys = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrafficPolicies")) {
        return .{ .arena = arena, .kind = .{ .too_many_traffic_policies = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrafficPolicyInstances")) {
        return .{ .arena = arena, .kind = .{ .too_many_traffic_policy_instances = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrafficPolicyVersionsForCurrentPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_traffic_policy_versions_for_current_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyVPCAssociationAuthorizations")) {
        return .{ .arena = arena, .kind = .{ .too_many_vpc_association_authorizations = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrafficPolicyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .traffic_policy_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrafficPolicyInUse")) {
        return .{ .arena = arena, .kind = .{ .traffic_policy_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrafficPolicyInstanceAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .traffic_policy_instance_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VPCAssociationAuthorizationNotFound")) {
        return .{ .arena = arena, .kind = .{ .vpc_association_authorization_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VPCAssociationNotFound")) {
        return .{ .arena = arena, .kind = .{ .vpc_association_not_found = .{
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
