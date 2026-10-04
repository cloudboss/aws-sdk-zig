const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const Tag = @import("tag.zig").Tag;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const RestoreDBClusterToPointInTimeInput = struct {
    /// Specifies whether to copy all tags from the restored DB cluster to snapshots
    /// of the restored DB cluster. The default is not to copy them.
    copy_tags_to_snapshot: ?bool = null,

    /// The name of the new cluster to be created.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    ///
    /// * The first character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    db_cluster_identifier: []const u8,

    /// The subnet group name to use for the new cluster.
    ///
    /// Constraints: If provided, must match the name of an existing
    /// `DBSubnetGroup`.
    ///
    /// Example: `mySubnetgroup`
    db_subnet_group_name: ?[]const u8 = null,

    /// Specifies whether this cluster can be deleted. If `DeletionProtection` is
    /// enabled, the cluster cannot be deleted unless it is modified and
    /// `DeletionProtection` is disabled. `DeletionProtection` protects clusters
    /// from being accidentally deleted.
    deletion_protection: ?bool = null,

    /// A list of log types that must be enabled for exporting to Amazon CloudWatch
    /// Logs.
    enable_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// The KMS key identifier to use when restoring an encrypted cluster from an
    /// encrypted cluster.
    ///
    /// The KMS key identifier is the Amazon Resource Name (ARN) for the KMS
    /// encryption key. If you are restoring a cluster with the same Amazon Web
    /// Services account that owns the KMS encryption key used to encrypt the new
    /// cluster, then you can use the KMS key alias instead of the ARN for the KMS
    /// encryption key.
    ///
    /// You can restore to a new cluster and encrypt the new cluster with an KMS key
    /// that is different from the KMS key used to encrypt the source cluster. The
    /// new DB cluster is encrypted with the KMS key identified by the `KmsKeyId`
    /// parameter.
    ///
    /// If you do not specify a value for the `KmsKeyId` parameter, then the
    /// following occurs:
    ///
    /// * If the cluster is encrypted, then the restored cluster is encrypted using
    ///   the KMS key that was used to encrypt the source cluster.
    ///
    /// * If the cluster is not encrypted, then the restored cluster is not
    ///   encrypted.
    ///
    /// If `DBClusterIdentifier` refers to a cluster that is not encrypted, then
    /// the restore request is rejected.
    kms_key_id: ?[]const u8 = null,

    /// The network type of the cluster.
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for the
    /// cluster.
    /// A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4 and the
    /// IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [DocumentDB clusters in a
    /// VPC](https://docs.aws.amazon.com/documentdb/latest/devguide/vpc-clusters.html) in the Amazon DocumentDB Developer Guide.
    ///
    /// Valid Values: `IPV4` | `DUAL`
    network_type: ?[]const u8 = null,

    /// The port number on which the new cluster accepts connections.
    ///
    /// Constraints: Must be a value from `1150` to `65535`.
    ///
    /// Default: The default port for the engine.
    port: ?i32 = null,

    /// The date and time to restore the cluster to.
    ///
    /// Valid values: A time in Universal Coordinated Time (UTC) format.
    ///
    /// Constraints:
    ///
    /// * Must be before the latest restorable time for the instance.
    ///
    /// * Must be specified if the `UseLatestRestorableTime` parameter is not
    ///   provided.
    ///
    /// * Cannot be specified if the `UseLatestRestorableTime` parameter is `true`.
    ///
    /// * Cannot be specified if the `RestoreType` parameter is `copy-on-write`.
    ///
    /// Example: `2015-03-07T23:45:00Z`
    restore_to_time: ?i64 = null,

    /// The type of restore to be performed. You can specify one of the following
    /// values:
    ///
    /// * `full-copy` - The new DB cluster is restored as a full copy of the
    /// source DB cluster.
    ///
    /// * `copy-on-write` - The new DB cluster is restored as a clone of the
    /// source DB cluster.
    ///
    /// Constraints: You can't specify `copy-on-write` if the engine version of the
    /// source DB cluster is earlier than 1.11.
    ///
    /// If you don't specify a `RestoreType` value, then the new DB cluster is
    /// restored as a full copy of the source DB cluster.
    restore_type: ?[]const u8 = null,

    /// Contains the scaling configuration of an Amazon DocumentDB Serverless
    /// cluster.
    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfiguration = null,

    /// The identifier of the source cluster from which to restore.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing `DBCluster`.
    source_db_cluster_identifier: []const u8,

    /// The storage type to associate with the DB cluster.
    ///
    /// For information on storage types for Amazon DocumentDB clusters, see
    /// Cluster storage configurations in the *Amazon DocumentDB Developer Guide*.
    ///
    /// Valid values for storage type - `standard | iopt1`
    ///
    /// Default value is `standard `
    storage_type: ?[]const u8 = null,

    /// The tags to be assigned to the restored cluster.
    tags: ?[]const Tag = null,

    /// A value that is set to `true` to restore the cluster to the latest
    /// restorable backup time, and `false` otherwise.
    ///
    /// Default: `false`
    ///
    /// Constraints: Cannot be specified if the `RestoreToTime` parameter is
    /// provided.
    use_latest_restorable_time: ?bool = null,

    /// A list of VPC security groups that the new cluster belongs to.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const RestoreDBClusterToPointInTimeOutput = struct {
    db_cluster: ?DBCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreDBClusterToPointInTimeInput, options: CallOptions) !RestoreDBClusterToPointInTimeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreDBClusterToPointInTimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "DocDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RestoreDBClusterToPointInTime&Version=2014-10-31");
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
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
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
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
    if (input.restore_to_time) |v| {
        try body_buf.appendSlice(allocator, "&RestoreToTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.restore_type) |v| {
        try body_buf.appendSlice(allocator, "&RestoreType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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
    try body_buf.appendSlice(allocator, "&SourceDBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_db_cluster_identifier);
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
    if (input.use_latest_restorable_time) |v| {
        try body_buf.appendSlice(allocator, "&UseLatestRestorableTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreDBClusterToPointInTimeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RestoreDBClusterToPointInTimeResult")) break;
            },
            else => {},
        }
    }

    var result: RestoreDBClusterToPointInTimeOutput = .{};
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
