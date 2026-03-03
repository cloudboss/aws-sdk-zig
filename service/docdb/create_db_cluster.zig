const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const Tag = @import("tag.zig").Tag;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const CreateDBClusterInput = struct {
    /// A list of Amazon EC2 Availability Zones that instances in the
    /// cluster can be created in.
    availability_zones: ?[]const []const u8 = null,

    /// The number of days for which automated backups are retained. You
    /// must specify a minimum value of 1.
    ///
    /// Default: 1
    ///
    /// Constraints:
    ///
    /// * Must be a value from 1 to 35.
    backup_retention_period: ?i32 = null,

    /// The cluster identifier. This parameter is stored as a lowercase
    /// string.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    ///
    /// * The first character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `my-cluster`
    db_cluster_identifier: []const u8,

    /// The name of the cluster parameter group to associate with this
    /// cluster.
    db_cluster_parameter_group_name: ?[]const u8 = null,

    /// A subnet group to associate with this cluster.
    ///
    /// Constraints: Must match the name of an existing
    /// `DBSubnetGroup`. Must not be default.
    ///
    /// Example: `mySubnetgroup`
    db_subnet_group_name: ?[]const u8 = null,

    /// Specifies whether this cluster can be deleted. If
    /// `DeletionProtection` is enabled, the cluster cannot be
    /// deleted unless it is modified and `DeletionProtection` is
    /// disabled. `DeletionProtection` protects clusters from
    /// being accidentally deleted.
    deletion_protection: ?bool = null,

    /// A list of log types that need to be enabled for exporting to Amazon
    /// CloudWatch Logs. You can enable audit logs or profiler logs. For more
    /// information, see [
    /// Auditing Amazon DocumentDB
    /// Events](https://docs.aws.amazon.com/documentdb/latest/developerguide/event-auditing.html)
    /// and [
    /// Profiling Amazon DocumentDB
    /// Operations](https://docs.aws.amazon.com/documentdb/latest/developerguide/profiling.html).
    enable_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// The name of the database engine to be used for this cluster.
    ///
    /// Valid values: `docdb`
    engine: []const u8,

    /// The version number of the database engine to use. The `--engine-version`
    /// will default to the latest major engine version. For production workloads,
    /// we recommend explicitly declaring this parameter with the intended major
    /// engine version.
    engine_version: ?[]const u8 = null,

    /// The cluster identifier of the new global cluster.
    global_cluster_identifier: ?[]const u8 = null,

    /// The KMS key identifier for an encrypted cluster.
    ///
    /// The KMS key identifier is the Amazon Resource Name (ARN) for the KMS
    /// encryption key. If you are creating a cluster using the same Amazon Web
    /// Services account that owns the KMS encryption key that is used to encrypt
    /// the new cluster, you can use the KMS key alias instead of the ARN for the
    /// KMS encryption key.
    ///
    /// If an encryption key is not specified in `KmsKeyId`:
    ///
    /// * If the `StorageEncrypted` parameter is
    /// `true`, Amazon DocumentDB uses your default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account has a different default encryption key for
    /// each Amazon Web Services Regions.
    kms_key_id: ?[]const u8 = null,

    /// Specifies whether to manage the master user password with Amazon Web
    /// Services Secrets Manager.
    ///
    /// Constraint: You can't manage the master user password with Amazon Web
    /// Services Secrets Manager if `MasterUserPassword` is specified.
    manage_master_user_password: ?bool = null,

    /// The name of the master user for the cluster.
    ///
    /// Constraints:
    ///
    /// * Must be from 1 to 63 letters or numbers.
    ///
    /// * The first character must be a letter.
    ///
    /// * Cannot be a reserved word for the chosen database engine.
    master_username: ?[]const u8 = null,

    /// The password for the master database user. This password can
    /// contain any printable ASCII character except forward slash (/),
    /// double quote ("), or the "at" symbol (@).
    ///
    /// Constraints: Must contain from 8 to 100 characters.
    master_user_password: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier to encrypt a secret that is
    /// automatically generated and managed in Amazon Web Services Secrets Manager.
    /// This setting is valid only if the master user password is managed by Amazon
    /// DocumentDB in Amazon Web Services Secrets Manager for the DB cluster.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    /// To use a KMS key in a different Amazon Web Services account, specify the key
    /// ARN or alias ARN.
    ///
    /// If you don't specify `MasterUserSecretKmsKeyId`, then the
    /// `aws/secretsmanager` KMS key is used to encrypt the secret.
    /// If the secret is in a different Amazon Web Services account, then you can't
    /// use the `aws/secretsmanager` KMS key to encrypt the secret, and you must use
    /// a customer managed KMS key.
    ///
    /// There is a default KMS key for your Amazon Web Services account.
    /// Your Amazon Web Services account has a different default KMS key for each
    /// Amazon Web Services Region.
    master_user_secret_kms_key_id: ?[]const u8 = null,

    /// The network type of the cluster.
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for the
    /// cluster.
    /// A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4 and the
    /// IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [DocumentDB clusters in a
    /// VPC](https://docs.aws.amazon.com/documentdb/latest/developerguide/vpc-clusters.html) in the Amazon DocumentDB Developer Guide.
    ///
    /// Valid Values: `IPV4` | `DUAL`
    network_type: ?[]const u8 = null,

    /// The port number on which the instances in the cluster accept
    /// connections.
    port: ?i32 = null,

    /// The daily time range during which automated backups are created if
    /// automated backups are enabled using the `BackupRetentionPeriod` parameter.
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region.
    ///
    /// Constraints:
    ///
    /// * Must be in the format `hh24:mi-hh24:mi`.
    ///
    /// * Must be in Universal Coordinated Time (UTC).
    ///
    /// * Must not conflict with the preferred maintenance window.
    ///
    /// * Must be at least 30 minutes.
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur,
    /// in Universal Coordinated Time (UTC).
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region, occurring on a random day of the
    /// week.
    ///
    /// Valid days: Mon, Tue, Wed, Thu, Fri, Sat, Sun
    ///
    /// Constraints: Minimum 30-minute window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// Not currently supported.
    pre_signed_url: ?[]const u8 = null,

    /// Contains the scaling configuration of an Amazon DocumentDB Serverless
    /// cluster.
    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfiguration = null,

    /// Specifies whether the cluster is encrypted.
    storage_encrypted: ?bool = null,

    /// The storage type to associate with the DB cluster.
    ///
    /// For information on storage types for Amazon DocumentDB clusters, see
    /// Cluster storage configurations in the *Amazon DocumentDB Developer Guide*.
    ///
    /// Valid values for storage type - `standard | iopt1`
    ///
    /// Default value is `standard `
    ///
    /// When you create an Amazon DocumentDB cluster with the storage type set to
    /// `iopt1`, the storage type is returned
    /// in the response. The storage type isn't returned when you set it to
    /// `standard`.
    storage_type: ?[]const u8 = null,

    /// The tags to be assigned to the cluster.
    tags: ?[]const Tag = null,

    /// A list of EC2 VPC security groups to associate with this cluster.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const CreateDBClusterOutput = struct {
    db_cluster: ?DBCluster = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBClusterInput, options: Options) !CreateDBClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "docdb");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("docdb", "DocDB", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateDBCluster&Version=2014-10-31");
    if (input.availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZones.AvailabilityZone.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.backup_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&BackupRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    if (input.db_cluster_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_subnet_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBSubnetGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(allocator, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_cloudwatch_logs_exports) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EnableCloudwatchLogsExports.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.global_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&GlobalClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.manage_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&ManageMasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.master_username) |v| {
        try body_buf.appendSlice(allocator, "&MasterUsername=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.master_user_secret_kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserSecretKmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.network_type) |v| {
        try body_buf.appendSlice(allocator, "&NetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.port) |v| {
        try body_buf.appendSlice(allocator, "&Port=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.preferred_backup_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredBackupWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.pre_signed_url) |v| {
        try body_buf.appendSlice(allocator, "&PreSignedUrl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.serverless_v2_scaling_configuration) |v| {
        if (v.max_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.MaxCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.min_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.MinCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.storage_encrypted) |v| {
        try body_buf.appendSlice(allocator, "&StorageEncrypted=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.storage_type) |v| {
        try body_buf.appendSlice(allocator, "&StorageType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.vpc_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSecurityGroupIds.VpcSecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBClusterResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBCluster")) {
                    result.db_cluster = try serde.deserializeDBCluster(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
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

    if (std.mem.eql(u8, error_code, "AuthorizationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .certificate_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterSnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterSnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBParameterGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_parameter_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBParameterGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_parameter_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSecurityGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_security_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupDoesNotCoverEnoughAZs")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_does_not_cover_enough_a_zs = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSubnetQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBUpgradeDependencyFailureFault")) {
        return .{ .arena = arena, .kind = .{ .db_upgrade_dependency_failure_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventSubscriptionQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .event_subscription_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalClusterAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .global_cluster_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalClusterNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .global_cluster_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalClusterQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .global_cluster_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .instance_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientDBClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_db_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientDBInstanceCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_db_instance_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientStorageClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_storage_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_snapshot_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBInstanceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_instance_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBParameterGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_parameter_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSecurityGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_security_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_snapshot_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSubnetGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_subnet_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBSubnetStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_subnet_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventSubscriptionStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_subscription_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGlobalClusterStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_global_cluster_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_restore_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidVPCNetworkStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_vpc_network_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "NetworkTypeNotSupported")) {
        return .{ .arena = arena, .kind = .{ .network_type_not_supported = .{
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
    if (std.mem.eql(u8, error_code, "SharedSnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .shared_snapshot_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_quota_exceeded_fault = .{
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
    if (std.mem.eql(u8, error_code, "SNSTopicArnNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .sns_topic_arn_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .source_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "StorageTypeNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .storage_type_not_supported_fault = .{
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
    if (std.mem.eql(u8, error_code, "SubscriptionAlreadyExistFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_already_exist_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionCategoryNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_category_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_not_found_fault = .{
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
