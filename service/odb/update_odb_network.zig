const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Access = @import("access.zig").Access;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateOdbNetworkInput = struct {
    /// The cross-Region Amazon S3 restore sources to disable for the ODB network.
    cross_region_s3_restore_sources_to_disable: ?[]const []const u8 = null,

    /// The cross-Region Amazon S3 restore sources to enable for the ODB network.
    cross_region_s3_restore_sources_to_enable: ?[]const []const u8 = null,

    /// The new user-friendly name of the ODB network.
    display_name: ?[]const u8 = null,

    /// The Amazon Web Services Key Management Service (KMS) access configuration
    /// for the ODB network.
    kms_access: ?Access = null,

    /// The Amazon Web Services Key Management Service (KMS) policy document that
    /// defines permissions for key usage within the ODB network.
    kms_policy_document: ?[]const u8 = null,

    /// The unique identifier of the ODB network to update.
    odb_network_id: []const u8,

    /// The list of CIDR ranges from the peered VPC that allow access to the ODB
    /// network.
    peered_cidrs_to_be_added: ?[]const []const u8 = null,

    /// The list of CIDR ranges from the peered VPC to remove from the ODB network.
    peered_cidrs_to_be_removed: ?[]const []const u8 = null,

    /// Specifies the updated configuration for Amazon S3 access from the ODB
    /// network.
    s_3_access: ?Access = null,

    /// Specifies the updated endpoint policy for Amazon S3 access from the ODB
    /// network.
    s_3_policy_document: ?[]const u8 = null,

    /// The Amazon Web Services Security Token Service (STS) access configuration
    /// for the ODB network.
    sts_access: ?Access = null,

    /// The Amazon Web Services Security Token Service (STS) policy document that
    /// defines permissions for token service usage within the ODB network.
    sts_policy_document: ?[]const u8 = null,

    /// Specifies the updated configuration for Zero-ETL access from the ODB
    /// network.
    zero_etl_access: ?Access = null,

    pub const json_field_names = .{
        .cross_region_s3_restore_sources_to_disable = "crossRegionS3RestoreSourcesToDisable",
        .cross_region_s3_restore_sources_to_enable = "crossRegionS3RestoreSourcesToEnable",
        .display_name = "displayName",
        .kms_access = "kmsAccess",
        .kms_policy_document = "kmsPolicyDocument",
        .odb_network_id = "odbNetworkId",
        .peered_cidrs_to_be_added = "peeredCidrsToBeAdded",
        .peered_cidrs_to_be_removed = "peeredCidrsToBeRemoved",
        .s_3_access = "s3Access",
        .s_3_policy_document = "s3PolicyDocument",
        .sts_access = "stsAccess",
        .sts_policy_document = "stsPolicyDocument",
        .zero_etl_access = "zeroEtlAccess",
    };
};

pub const UpdateOdbNetworkOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOdbNetworkInput, options: Options) !UpdateOdbNetworkOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOdbNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.UpdateOdbNetwork");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOdbNetworkOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateOdbNetworkOutput, body, allocator);
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
