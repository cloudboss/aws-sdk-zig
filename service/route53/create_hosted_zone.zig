const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HostedZoneConfig = @import("hosted_zone_config.zig").HostedZoneConfig;
const VPC = @import("vpc.zig").VPC;
const ChangeInfo = @import("change_info.zig").ChangeInfo;
const DelegationSet = @import("delegation_set.zig").DelegationSet;
const HostedZone = @import("hosted_zone.zig").HostedZone;
const serde = @import("serde.zig");

pub const CreateHostedZoneInput = struct {
    /// A unique string that identifies the request and that allows failed
    /// `CreateHostedZone` requests to be retried without the risk of executing
    /// the operation twice. You must use a unique `CallerReference` string every
    /// time you submit a `CreateHostedZone` request. `CallerReference`
    /// can be any unique string, for example, a date/time stamp.
    caller_reference: []const u8,

    /// If you want to associate a reusable delegation set with this hosted zone,
    /// the ID that
    /// Amazon Route 53 assigned to the reusable delegation set when you created it.
    /// For more information about reusable delegation sets, see
    /// [CreateReusableDelegationSet](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateReusableDelegationSet.html).
    ///
    /// If you are using a reusable delegation set to create a public hosted zone
    /// for a subdomain,
    /// make sure that the parent hosted zone doesn't use one or more of the same
    /// name servers.
    /// If you have overlapping nameservers, the operation will cause a
    /// `ConflictingDomainsExist` error.
    delegation_set_id: ?[]const u8 = null,

    /// (Optional) A complex type that contains the following optional values:
    ///
    /// * For public and private hosted zones, an optional comment
    ///
    /// * For private hosted zones, an optional `PrivateZone` element
    ///
    /// If you don't specify a comment or the `PrivateZone` element, omit
    /// `HostedZoneConfig` and the other elements.
    hosted_zone_config: ?HostedZoneConfig = null,

    /// The name of the domain. Specify a fully qualified domain name, for example,
    /// *www.example.com*. The trailing dot is optional; Amazon Route 53 assumes
    /// that the domain name is fully qualified. This means that
    /// Route 53 treats *www.example.com* (without a trailing
    /// dot) and *www.example.com.* (with a trailing dot) as
    /// identical.
    ///
    /// If you're creating a public hosted zone, this is the name you have
    /// registered with
    /// your DNS registrar. If your domain name is registered with a registrar other
    /// than
    /// Route 53, change the name servers for your domain to the set of
    /// `NameServers` that `CreateHostedZone` returns in
    /// `DelegationSet`.
    name: []const u8,

    /// (Private hosted zones only) A complex type that contains information about
    /// the Amazon
    /// VPC that you're associating with this hosted zone.
    ///
    /// You can specify only one Amazon VPC when you create a private hosted zone.
    /// If you are
    /// associating a VPC with a hosted zone with this request, the paramaters
    /// `VPCId` and `VPCRegion` are also required.
    ///
    /// To associate additional Amazon VPCs with the hosted zone, use
    /// [AssociateVPCWithHostedZone](https://docs.aws.amazon.com/Route53/latest/APIReference/API_AssociateVPCWithHostedZone.html) after you create a hosted zone.
    vpc: ?VPC = null,
};

pub const CreateHostedZoneOutput = struct {
    /// A complex type that contains information about the `CreateHostedZone`
    /// request.
    change_info: ?ChangeInfo = null,

    /// A complex type that describes the name servers for this hosted zone.
    delegation_set: ?DelegationSet = null,

    /// A complex type that contains general information about the hosted zone.
    hosted_zone: ?HostedZone = null,

    /// The unique URL representing the new hosted zone.
    location: []const u8,

    /// A complex type that contains information about an Amazon VPC that you
    /// associated with
    /// this hosted zone.
    vpc: ?VPC = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHostedZoneInput, options: CallOptions) !CreateHostedZoneOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHostedZoneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2013-04-01/hostedzone";

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(allocator, "<CreateHostedZoneRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.caller_reference);
    try body_buf.appendSlice(allocator, "</CallerReference>");
    if (input.delegation_set_id) |v| {
        try body_buf.appendSlice(allocator, "<DelegationSetId>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</DelegationSetId>");
    }
    if (input.hosted_zone_config) |v| {
        try body_buf.appendSlice(allocator, "<HostedZoneConfig>");
        try serde.serializeHostedZoneConfig(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</HostedZoneConfig>");
    }
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    if (input.vpc) |v| {
        try body_buf.appendSlice(allocator, "<VPC>");
        try serde.serializeVPC(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</VPC>");
    }
    try body_buf.appendSlice(allocator, "</CreateHostedZoneRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHostedZoneOutput {
    var result: CreateHostedZoneOutput = undefined;
    result.vpc = null;
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
                if (std.mem.eql(u8, e.local, "ChangeInfo")) {
                    result.change_info = try serde.deserializeChangeInfo(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "DelegationSet")) {
                    result.delegation_set = try serde.deserializeDelegationSet(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "HostedZone")) {
                    result.hosted_zone = try serde.deserializeHostedZone(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "VPC")) {
                    result.vpc = try serde.deserializeVPC(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

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
