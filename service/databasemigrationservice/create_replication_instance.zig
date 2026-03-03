const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const KerberosAuthenticationSettings = @import("kerberos_authentication_settings.zig").KerberosAuthenticationSettings;
const Tag = @import("tag.zig").Tag;
const ReplicationInstance = @import("replication_instance.zig").ReplicationInstance;

pub const CreateReplicationInstanceInput = struct {
    /// The amount of storage (in gigabytes) to be initially allocated for the
    /// replication
    /// instance.
    allocated_storage: ?i32 = null,

    /// A value that indicates whether minor engine upgrades are applied
    /// automatically to the
    /// replication instance during the maintenance window. This parameter defaults
    /// to
    /// `true`.
    ///
    /// Default: `true`
    auto_minor_version_upgrade: ?bool = null,

    /// The Availability Zone where the replication instance will be created. The
    /// default value
    /// is a random, system-chosen Availability Zone in the endpoint's Amazon Web
    /// Services Region, for example:
    /// `us-east-1d`.
    availability_zone: ?[]const u8 = null,

    /// A list of custom DNS name servers supported for the replication instance to
    /// access your
    /// on-premise source or target database. This list overrides the default name
    /// servers
    /// supported by the replication instance. You can specify a comma-separated
    /// list of internet
    /// addresses for up to four on-premise DNS name servers. For example:
    /// `"1.1.1.1,2.2.2.2,3.3.3.3,4.4.4.4"`
    dns_name_servers: ?[]const u8 = null,

    /// The engine version number of the replication instance.
    ///
    /// If an engine version number is not specified when a replication instance is
    /// created, the
    /// default is the latest engine version available.
    engine_version: ?[]const u8 = null,

    /// Specifies the settings required for kerberos authentication when creating
    /// the
    /// replication instance.
    kerberos_authentication_settings: ?KerberosAuthenticationSettings = null,

    /// An KMS key identifier that is used to encrypt the data on the replication
    /// instance.
    ///
    /// If you don't specify a value for the `KmsKeyId` parameter, then DMS uses
    /// your default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account has
    /// a different default encryption key for each Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

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

    /// The weekly time range during which system maintenance can occur, in
    /// Universal
    /// Coordinated Time (UTC).
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// Default: A 30-minute window selected at random from an 8-hour block of time
    /// per
    /// Amazon Web Services Region, occurring on a random day of the week.
    ///
    /// Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun
    ///
    /// Constraints: Minimum 30-minute window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// Specifies the accessibility options for the replication instance. A value of
    /// `true` represents an instance with a public IP address. A value of
    /// `false` represents an instance with a private IP address. The default value
    /// is `true`.
    publicly_accessible: ?bool = null,

    /// The compute and memory capacity of the replication instance as defined for
    /// the specified
    /// replication instance class. For example to specify the instance class
    /// dms.c4.large, set
    /// this parameter to `"dms.c4.large"`.
    ///
    /// For more information on the settings and capacities for the available
    /// replication
    /// instance classes, see [
    /// Choosing the right DMS replication
    /// instance](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.Types.html ); and, [Selecting the best size for a replication instance](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_BestPractices.SizingReplicationInstance.html).
    replication_instance_class: []const u8,

    /// The replication instance identifier. This parameter is stored as a lowercase
    /// string.
    ///
    /// Constraints:
    ///
    /// * Must contain 1-63 alphanumeric characters or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `myrepinstance`
    replication_instance_identifier: []const u8,

    /// A subnet group to associate with the replication instance.
    replication_subnet_group_identifier: ?[]const u8 = null,

    /// A friendly name for the resource identifier at the end of the `EndpointArn`
    /// response parameter that is returned in the created `Endpoint` object. The
    /// value
    /// for this parameter can have up to 31 characters. It can contain only ASCII
    /// letters, digits,
    /// and hyphen ('-'). Also, it can't end with a hyphen or contain two
    /// consecutive hyphens,
    /// and can only begin with a letter, such as `Example-App-ARN1`. For example,
    /// this
    /// value might result in the `EndpointArn` value
    /// `arn:aws:dms:eu-west-1:012345678901:rep:Example-App-ARN1`. If you don't
    /// specify a `ResourceIdentifier` value, DMS generates a default identifier
    /// value
    /// for the end of `EndpointArn`.
    resource_identifier: ?[]const u8 = null,

    /// One or more tags to be assigned to the replication instance.
    tags: ?[]const Tag = null,

    /// Specifies the VPC security group to be used with the replication instance.
    /// The VPC
    /// security group must work with the VPC containing the replication instance.
    vpc_security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .availability_zone = "AvailabilityZone",
        .dns_name_servers = "DnsNameServers",
        .engine_version = "EngineVersion",
        .kerberos_authentication_settings = "KerberosAuthenticationSettings",
        .kms_key_id = "KmsKeyId",
        .multi_az = "MultiAZ",
        .network_type = "NetworkType",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .publicly_accessible = "PubliclyAccessible",
        .replication_instance_class = "ReplicationInstanceClass",
        .replication_instance_identifier = "ReplicationInstanceIdentifier",
        .replication_subnet_group_identifier = "ReplicationSubnetGroupIdentifier",
        .resource_identifier = "ResourceIdentifier",
        .tags = "Tags",
        .vpc_security_group_ids = "VpcSecurityGroupIds",
    };
};

pub const CreateReplicationInstanceOutput = struct {
    /// The replication instance that was created.
    replication_instance: ?ReplicationInstance = null,

    pub const json_field_names = .{
        .replication_instance = "ReplicationInstance",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReplicationInstanceInput, options: Options) !CreateReplicationInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "databasemigrationservice");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicationInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databasemigrationservice", "Database Migration Service", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateReplicationInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicationInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateReplicationInstanceOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CollectorNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .collector_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FailedDependencyFault")) {
        return .{ .arena = arena, .kind = .{ .failed_dependency_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientResourceCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_resource_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_certificate_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSFault")) {
        return .{ .arena = arena, .kind = .{ .kms_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateFault")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingFault")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationSubnetGroupDoesNotCoverEnoughAZs")) {
        return .{ .arena = arena, .kind = .{ .replication_subnet_group_does_not_cover_enough_a_zs = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .resource_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3AccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .s3_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .s3_resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StorageQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .storage_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_already_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpgradeDependencyFailureFault")) {
        return .{ .arena = arena, .kind = .{ .upgrade_dependency_failure_fault = .{
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
