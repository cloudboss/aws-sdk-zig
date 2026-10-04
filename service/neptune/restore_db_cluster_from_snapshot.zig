const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const Tag = @import("tag.zig").Tag;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const RestoreDBClusterFromSnapshotInput = struct {
    /// Provides the list of EC2 Availability Zones that instances in the restored
    /// DB cluster can
    /// be created in.
    availability_zones: ?[]const []const u8 = null,

    /// *If set to `true`, tags are copied to any snapshot of
    /// the restored DB cluster that is created.*
    copy_tags_to_snapshot: ?bool = null,

    /// Not supported.
    database_name: ?[]const u8 = null,

    /// The name of the DB cluster to create from the DB snapshot or DB cluster
    /// snapshot. This
    /// parameter isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens
    ///
    /// * First character must be a letter
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens
    ///
    /// Example: `my-snapshot-id`
    db_cluster_identifier: []const u8,

    /// The name of the DB cluster parameter group to associate with the new DB
    /// cluster.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the name of an existing DBClusterParameterGroup.
    db_cluster_parameter_group_name: ?[]const u8 = null,

    /// The name of the DB subnet group to use for the new DB cluster.
    ///
    /// Constraints: If supplied, must match the name of an existing DBSubnetGroup.
    ///
    /// Example: `mySubnetgroup`
    db_subnet_group_name: ?[]const u8 = null,

    /// A value that indicates whether the DB cluster has deletion protection
    /// enabled.
    /// The database can't be deleted when deletion protection is enabled. By
    /// default,
    /// deletion protection is disabled.
    deletion_protection: ?bool = null,

    /// The list of logs that the restored DB cluster is to export to Amazon
    /// CloudWatch Logs.
    enable_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// True to enable mapping of Amazon Identity and Access Management (IAM)
    /// accounts to database
    /// accounts, and otherwise false.
    ///
    /// Default: `false`
    enable_iam_database_authentication: ?bool = null,

    /// The database engine to use for the new DB cluster.
    ///
    /// Default: The same as source
    ///
    /// Constraint: Must be compatible with the engine of the source
    engine: []const u8,

    /// The version of the database engine to use for the new DB cluster.
    engine_version: ?[]const u8 = null,

    /// The Amazon KMS key identifier to use when restoring an encrypted DB cluster
    /// from a DB
    /// snapshot or DB cluster snapshot.
    ///
    /// The KMS key identifier is the Amazon Resource Name (ARN) for the KMS
    /// encryption key. If
    /// you are restoring a DB cluster with the same Amazon account that owns the
    /// KMS encryption key used
    /// to encrypt the new DB cluster, then you can use the KMS key alias instead of
    /// the ARN for the
    /// KMS encryption key.
    ///
    /// If you do not specify a value for the `KmsKeyId` parameter, then the
    /// following
    /// will occur:
    ///
    /// * If the DB snapshot or DB cluster snapshot in `SnapshotIdentifier` is
    /// encrypted, then the restored DB cluster is encrypted using the KMS key that
    /// was used to
    /// encrypt the DB snapshot or DB cluster snapshot.
    ///
    /// * If the DB snapshot or DB cluster snapshot in `SnapshotIdentifier` is not
    /// encrypted, then the restored DB cluster is not encrypted.
    kms_key_id: ?[]const u8 = null,

    /// The network type of the DB cluster.
    ///
    /// Valid Values:
    ///
    /// * **
    /// `IPV4`
    /// **   –
    /// ( *the default* ) The DB cluster uses only IPv4 addresses for communication.
    ///
    /// * **
    /// `DUAL`
    /// **   –
    /// The DB cluster uses both IPv4 and IPv6 addresses for communication. The DB
    /// subnet group
    /// associated with the cluster must support IPv6.
    network_type: ?[]const u8 = null,

    /// *(Not supported by Neptune)*
    option_group_name: ?[]const u8 = null,

    /// The port number on which the new DB cluster accepts connections.
    ///
    /// Constraints: Value must be `1150-65535`
    ///
    /// Default: The same port as the original DB cluster.
    port: ?i32 = null,

    /// Contains the scaling configuration of a Neptune Serverless DB cluster.
    ///
    /// For more information, see [Using Amazon Neptune
    /// Serverless](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-serverless-using.html) in the
    /// *Amazon Neptune User Guide*.
    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfiguration = null,

    /// The identifier for the DB snapshot or DB cluster snapshot to restore from.
    ///
    /// You can use either the name or the Amazon Resource Name (ARN) to specify a
    /// DB cluster
    /// snapshot. However, you can use only the ARN to specify a DB snapshot.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing Snapshot.
    snapshot_identifier: []const u8,

    /// Specifies the storage type to be associated with the DB cluster.
    ///
    /// Valid values: `standard`, `iopt1`
    ///
    /// Default: `standard`
    storage_type: ?[]const u8 = null,

    /// The tags to be assigned to the restored DB cluster.
    tags: ?[]const Tag = null,

    /// A list of VPC security groups that the new DB cluster will belong to.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const RestoreDBClusterFromSnapshotOutput = struct {
    db_cluster: ?DBCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreDBClusterFromSnapshotInput, options: CallOptions) !RestoreDBClusterFromSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreDBClusterFromSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RestoreDBClusterFromSnapshot&Version=2014-10-31");
    if (input.availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZones.AvailabilityZone.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.database_name) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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
    if (input.enable_iam_database_authentication) |v| {
        try body_buf.appendSlice(allocator, "&EnableIAMDatabaseAuthentication=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.network_type) |v| {
        try body_buf.appendSlice(allocator, "&NetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.option_group_name) |v| {
        try body_buf.appendSlice(allocator, "&OptionGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.port) |v| {
        try body_buf.appendSlice(allocator, "&Port=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.serverless_v2_scaling_configuration) |v| {
        if (v.max_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.MaxCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.min_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.MinCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    try body_buf.appendSlice(allocator, "&SnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.snapshot_identifier);
    if (input.storage_type) |v| {
        try body_buf.appendSlice(allocator, "&StorageType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreDBClusterFromSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RestoreDBClusterFromSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: RestoreDBClusterFromSnapshotOutput = .{};
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
