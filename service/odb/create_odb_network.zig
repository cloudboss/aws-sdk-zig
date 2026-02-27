const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Access = @import("access.zig").Access;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateOdbNetworkInput = struct {
    /// The Amazon Web Services Availability Zone (AZ) where the ODB network is
    /// located.
    ///
    /// This operation requires that you specify a value for either
    /// `availabilityZone` or `availabilityZoneId`.
    availability_zone: ?[]const u8 = null,

    /// The AZ ID of the AZ where the ODB network is located.
    ///
    /// This operation requires that you specify a value for either
    /// `availabilityZone` or `availabilityZoneId`.
    availability_zone_id: ?[]const u8 = null,

    /// The CIDR range of the backup subnet for the ODB network.
    ///
    /// Constraints:
    ///
    /// * Must not overlap with the CIDR range of the client subnet.
    /// * Must not overlap with the CIDR ranges of the VPCs that are connected to
    ///   the ODB network.
    /// * Must not use the following CIDR ranges that are reserved by OCI:
    ///
    /// * `100.106.0.0/16` and `100.107.0.0/16`
    /// * `169.254.0.0/16`
    /// * `224.0.0.0 - 239.255.255.255`
    /// * `240.0.0.0 - 255.255.255.255`
    backup_subnet_cidr: ?[]const u8 = null,

    /// The CIDR range of the client subnet for the ODB network.
    ///
    /// Constraints:
    ///
    /// * Must not overlap with the CIDR range of the backup subnet.
    /// * Must not overlap with the CIDR ranges of the VPCs that are connected to
    ///   the ODB network.
    /// * Must not use the following CIDR ranges that are reserved by OCI:
    ///
    /// * `100.106.0.0/16` and `100.107.0.0/16`
    /// * `169.254.0.0/16`
    /// * `224.0.0.0 - 239.255.255.255`
    /// * `240.0.0.0 - 255.255.255.255`
    client_subnet_cidr: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you don't specify a client token, the Amazon
    /// Web Services SDK automatically generates a client token and uses it for the
    /// request to ensure idempotency. The client token is valid for up to 24 hours
    /// after it's first used.
    client_token: ?[]const u8 = null,

    /// The cross-Region Amazon S3 restore sources to enable for the ODB network.
    cross_region_s3_restore_sources_to_enable: ?[]const []const u8 = null,

    /// The domain name to use for the resources in the ODB network.
    custom_domain_name: ?[]const u8 = null,

    /// The DNS prefix to the default DNS domain name. The default DNS domain name
    /// is oraclevcn.com.
    default_dns_prefix: ?[]const u8 = null,

    /// A user-friendly name for the ODB network.
    display_name: []const u8,

    /// The Amazon Web Services Key Management Service (KMS) access configuration
    /// for the ODB network.
    kms_access: ?Access = null,

    /// The Amazon Web Services Key Management Service (KMS) policy document that
    /// defines permissions for key usage within the ODB network.
    kms_policy_document: ?[]const u8 = null,

    /// Specifies the configuration for Amazon S3 access from the ODB network.
    s_3_access: ?Access = null,

    /// Specifies the endpoint policy for Amazon S3 access from the ODB network.
    s_3_policy_document: ?[]const u8 = null,

    /// The Amazon Web Services Security Token Service (STS) access configuration
    /// for the ODB network.
    sts_access: ?Access = null,

    /// The Amazon Web Services Security Token Service (STS) policy document that
    /// defines permissions for token service usage within the ODB network.
    sts_policy_document: ?[]const u8 = null,

    /// The list of resource tags to apply to the ODB network.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the configuration for Zero-ETL access from the ODB network.
    zero_etl_access: ?Access = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .availability_zone_id = "availabilityZoneId",
        .backup_subnet_cidr = "backupSubnetCidr",
        .client_subnet_cidr = "clientSubnetCidr",
        .client_token = "clientToken",
        .cross_region_s3_restore_sources_to_enable = "crossRegionS3RestoreSourcesToEnable",
        .custom_domain_name = "customDomainName",
        .default_dns_prefix = "defaultDnsPrefix",
        .display_name = "displayName",
        .kms_access = "kmsAccess",
        .kms_policy_document = "kmsPolicyDocument",
        .s_3_access = "s3Access",
        .s_3_policy_document = "s3PolicyDocument",
        .sts_access = "stsAccess",
        .sts_policy_document = "stsPolicyDocument",
        .tags = "tags",
        .zero_etl_access = "zeroEtlAccess",
    };
};

pub const CreateOdbNetworkOutput = struct {
    /// The user-friendly name of the ODB network.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the ODB network.
    odb_network_id: []const u8,

    /// The current status of the ODB network.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the ODB network.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .odb_network_id = "odbNetworkId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOdbNetworkInput, options: Options) !CreateOdbNetworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "odb");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateOdbNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "Odb.CreateOdbNetwork");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateOdbNetworkOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateOdbNetworkOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
