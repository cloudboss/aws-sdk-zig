const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const KerberosAuthenticationSettings = @import("kerberos_authentication_settings.zig").KerberosAuthenticationSettings;
const ReplicationInstance = @import("replication_instance.zig").ReplicationInstance;

pub const ModifyReplicationInstanceInput = struct {
    /// The amount of storage (in gigabytes) to be allocated for the replication
    /// instance.
    allocated_storage: ?i32 = null,

    /// Indicates that major version upgrades are allowed. Changing this parameter
    /// does not
    /// result in an outage, and the change is asynchronously applied as soon as
    /// possible.
    ///
    /// This parameter must be set to `true` when specifying a value for the
    /// `EngineVersion` parameter that is a different major version than the
    /// replication instance's current version.
    allow_major_version_upgrade: ?bool = null,

    /// Indicates whether the changes should be applied immediately or during the
    /// next
    /// maintenance window.
    apply_immediately: ?bool = null,

    /// A value that indicates that minor version upgrades are applied automatically
    /// to the
    /// replication instance during the maintenance window. Changing this parameter
    /// doesn't result
    /// in an outage, except in the case described following. The change is
    /// asynchronously applied
    /// as soon as possible.
    ///
    /// An outage does result if these factors apply:
    ///
    /// * This parameter is set to `true` during the maintenance window.
    ///
    /// * A newer minor version is available.
    ///
    /// * DMS has enabled automatic patching for the given engine version.
    auto_minor_version_upgrade: ?bool = null,

    /// The engine version number of the replication instance.
    ///
    /// When modifying a major engine version of an instance, also set
    /// `AllowMajorVersionUpgrade` to `true`.
    engine_version: ?[]const u8 = null,

    /// Specifies the settings required for kerberos authentication when modifying a
    /// replication
    /// instance.
    kerberos_authentication_settings: ?KerberosAuthenticationSettings = null,

    /// Specifies whether the replication instance is a Multi-AZ deployment. You
    /// can't set
    /// the `AvailabilityZone` parameter if the Multi-AZ parameter is set to
    /// `true`.
    multi_az: ?bool = null,

    /// The type of IP address protocol used by a replication instance, such as IPv4
    /// only or
    /// Dual-stack that supports both IPv4 and IPv6 addressing. IPv6 only is not yet
    /// supported.
    network_type: ?[]const u8 = null,

    /// The weekly time range (in UTC) during which system maintenance can occur,
    /// which might
    /// result in an outage. Changing this parameter does not result in an outage,
    /// except in the
    /// following situation, and the change is asynchronously applied as soon as
    /// possible. If
    /// moving this window to the current time, there must be at least 30 minutes
    /// between the
    /// current time and end of the window to ensure pending changes are applied.
    ///
    /// Default: Uses existing setting
    ///
    /// Format: ddd:hh24:mi-ddd:hh24:mi
    ///
    /// Valid Days: Mon | Tue | Wed | Thu | Fri | Sat | Sun
    ///
    /// Constraints: Must be at least 30 minutes
    preferred_maintenance_window: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the replication instance.
    replication_instance_arn: []const u8,

    /// The compute and memory capacity of the replication instance as defined for
    /// the specified
    /// replication instance class. For example to specify the instance class
    /// dms.c4.large, set
    /// this parameter to `"dms.c4.large"`.
    ///
    /// For more information on the settings and capacities for the available
    /// replication
    /// instance classes, see [ Selecting the right DMS replication instance for
    /// your
    /// migration](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.html#CHAP_ReplicationInstance.InDepth).
    replication_instance_class: ?[]const u8 = null,

    /// The replication instance identifier. This parameter is stored as a lowercase
    /// string.
    replication_instance_identifier: ?[]const u8 = null,

    /// Specifies the VPC security group to be used with the replication instance.
    /// The VPC
    /// security group must work with the VPC containing the replication instance.
    vpc_security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .allow_major_version_upgrade = "AllowMajorVersionUpgrade",
        .apply_immediately = "ApplyImmediately",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .engine_version = "EngineVersion",
        .kerberos_authentication_settings = "KerberosAuthenticationSettings",
        .multi_az = "MultiAZ",
        .network_type = "NetworkType",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .replication_instance_arn = "ReplicationInstanceArn",
        .replication_instance_class = "ReplicationInstanceClass",
        .replication_instance_identifier = "ReplicationInstanceIdentifier",
        .vpc_security_group_ids = "VpcSecurityGroupIds",
    };
};

pub const ModifyReplicationInstanceOutput = struct {
    /// The modified replication instance.
    replication_instance: ?ReplicationInstance = null,

    pub const json_field_names = .{
        .replication_instance = "ReplicationInstance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyReplicationInstanceInput, options: CallOptions) !ModifyReplicationInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyReplicationInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ModifyReplicationInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyReplicationInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyReplicationInstanceOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedFault")) {
        const parsed_error: ?errors.AccessDeniedFault = aws.json.parseJsonObject(errors.AccessDeniedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CollectorNotFoundFault")) {
        const parsed_error: ?errors.CollectorNotFoundFault = aws.json.parseJsonObject(errors.CollectorNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .collector_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FailedDependencyFault")) {
        const parsed_error: ?errors.FailedDependencyFault = aws.json.parseJsonObject(errors.FailedDependencyFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .failed_dependency_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientResourceCapacityFault")) {
        const parsed_error: ?errors.InsufficientResourceCapacityFault = aws.json.parseJsonObject(errors.InsufficientResourceCapacityFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_resource_capacity_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateFault")) {
        const parsed_error: ?errors.InvalidCertificateFault = aws.json.parseJsonObject(errors.InvalidCertificateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_certificate_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationFault")) {
        const parsed_error: ?errors.InvalidOperationFault = aws.json.parseJsonObject(errors.InvalidOperationFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_operation_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateFault")) {
        const parsed_error: ?errors.InvalidResourceStateFault = aws.json.parseJsonObject(errors.InvalidResourceStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        const parsed_error: ?errors.InvalidSubnet = aws.json.parseJsonObject(errors.InvalidSubnet, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_subnet = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedFault")) {
        const parsed_error: ?errors.KMSAccessDeniedFault = aws.json.parseJsonObject(errors.KMSAccessDeniedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_access_denied_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledFault")) {
        const parsed_error: ?errors.KMSDisabledFault = aws.json.parseJsonObject(errors.KMSDisabledFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_disabled_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSFault")) {
        const parsed_error: ?errors.KMSFault = aws.json.parseJsonObject(errors.KMSFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateFault")) {
        const parsed_error: ?errors.KMSInvalidStateFault = aws.json.parseJsonObject(errors.KMSInvalidStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        const parsed_error: ?errors.KMSKeyNotAccessibleFault = aws.json.parseJsonObject(errors.KMSKeyNotAccessibleFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundFault")) {
        const parsed_error: ?errors.KMSNotFoundFault = aws.json.parseJsonObject(errors.KMSNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingFault")) {
        const parsed_error: ?errors.KMSThrottlingFault = aws.json.parseJsonObject(errors.KMSThrottlingFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_throttling_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReplicationSubnetGroupDoesNotCoverEnoughAZs")) {
        const parsed_error: ?errors.ReplicationSubnetGroupDoesNotCoverEnoughAZs = aws.json.parseJsonObject(errors.ReplicationSubnetGroupDoesNotCoverEnoughAZs, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .replication_subnet_group_does_not_cover_enough_a_zs = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsFault")) {
        const parsed_error: ?errors.ResourceAlreadyExistsFault = aws.json.parseJsonObject(errors.ResourceAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        const parsed_error: ?errors.ResourceNotFoundFault = aws.json.parseJsonObject(errors.ResourceNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceQuotaExceededFault")) {
        const parsed_error: ?errors.ResourceQuotaExceededFault = aws.json.parseJsonObject(errors.ResourceQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "S3AccessDeniedFault")) {
        const parsed_error: ?errors.S3AccessDeniedFault = aws.json.parseJsonObject(errors.S3AccessDeniedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .s3_access_denied_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "S3ResourceNotFoundFault")) {
        const parsed_error: ?errors.S3ResourceNotFoundFault = aws.json.parseJsonObject(errors.S3ResourceNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .s3_resource_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        const parsed_error: ?errors.SNSInvalidTopicFault = aws.json.parseJsonObject(errors.SNSInvalidTopicFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        const parsed_error: ?errors.SNSNoAuthorizationFault = aws.json.parseJsonObject(errors.SNSNoAuthorizationFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StorageQuotaExceededFault")) {
        const parsed_error: ?errors.StorageQuotaExceededFault = aws.json.parseJsonObject(errors.StorageQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .storage_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        const parsed_error: ?errors.SubnetAlreadyInUse = aws.json.parseJsonObject(errors.SubnetAlreadyInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_already_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UpgradeDependencyFailureFault")) {
        const parsed_error: ?errors.UpgradeDependencyFailureFault = aws.json.parseJsonObject(errors.UpgradeDependencyFailureFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .upgrade_dependency_failure_fault = typed_error } };
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
