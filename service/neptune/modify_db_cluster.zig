const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudwatchLogsExportConfiguration = @import("cloudwatch_logs_export_configuration.zig").CloudwatchLogsExportConfiguration;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const ModifyDBClusterInput = struct {
    /// A value that indicates whether upgrades between different major versions are
    /// allowed.
    ///
    /// Constraints: You must set the allow-major-version-upgrade flag when
    /// providing an
    /// `EngineVersion` parameter that uses a different major version than the DB
    /// cluster's current
    /// version.
    allow_major_version_upgrade: ?bool = null,

    /// A value that specifies whether the modifications in this request and any
    /// pending
    /// modifications are asynchronously applied as soon as possible, regardless of
    /// the
    /// `PreferredMaintenanceWindow` setting for the DB cluster. If this parameter
    /// is set
    /// to `false`, changes to the DB cluster are applied during the next
    /// maintenance
    /// window.
    ///
    /// The `ApplyImmediately` parameter only affects `NewDBClusterIdentifier`
    /// values. If you set the `ApplyImmediately` parameter value to false, then
    /// changes to
    /// `NewDBClusterIdentifier` values are applied during the next maintenance
    /// window.
    /// All other changes are applied immediately, regardless of the value of the
    /// `ApplyImmediately` parameter.
    ///
    /// Default: `false`
    apply_immediately: ?bool = null,

    /// The number of days for which automated backups are retained. You must
    /// specify a minimum
    /// value of 1.
    ///
    /// Default: 1
    ///
    /// Constraints:
    ///
    /// * Must be a value from 1 to 35
    backup_retention_period: ?i32 = null,

    /// The configuration setting for the log types to be enabled for export to
    /// CloudWatch Logs
    /// for a specific DB cluster. See [Using the
    /// CLI to publish Neptune audit logs to CloudWatch
    /// Logs](https://docs.aws.amazon.com/neptune/latest/userguide/cloudwatch-logs.html#cloudwatch-logs-cli).
    cloudwatch_logs_export_configuration: ?CloudwatchLogsExportConfiguration = null,

    /// *If set to `true`, tags are copied to any snapshot of
    /// the DB cluster that is created.*
    copy_tags_to_snapshot: ?bool = null,

    /// The DB cluster identifier for the cluster being modified. This parameter is
    /// not
    /// case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing DBCluster.
    db_cluster_identifier: []const u8,

    /// The name of the DB cluster parameter group to use for the DB cluster.
    db_cluster_parameter_group_name: ?[]const u8 = null,

    /// The name of the DB parameter group to apply to all instances of the DB
    /// cluster.
    ///
    /// When you apply a parameter group using `DBInstanceParameterGroupName`,
    /// parameter changes aren't applied during the next maintenance window but
    /// instead are
    /// applied immediately.
    ///
    /// Default: The existing name setting
    ///
    /// Constraints:
    ///
    /// * The DB parameter group must be in the same DB parameter group family as
    /// the target DB cluster version.
    ///
    /// * The `DBInstanceParameterGroupName` parameter is only valid in combination
    ///   with
    /// the `AllowMajorVersionUpgrade` parameter.
    db_instance_parameter_group_name: ?[]const u8 = null,

    /// A value that indicates whether the DB cluster has deletion protection
    /// enabled.
    /// The database can't be deleted when deletion protection is enabled. By
    /// default,
    /// deletion protection is disabled.
    deletion_protection: ?bool = null,

    /// True to enable mapping of Amazon Identity and Access Management (IAM)
    /// accounts to database
    /// accounts, and otherwise false.
    ///
    /// Default: `false`
    enable_iam_database_authentication: ?bool = null,

    /// The version number of the database engine to which you want to upgrade.
    /// Changing this
    /// parameter results in an outage. The change is applied during the next
    /// maintenance window
    /// unless the `ApplyImmediately` parameter is set to true.
    ///
    /// For a list of valid engine versions, see [Engine Releases for Amazon
    /// Neptune](https://docs.aws.amazon.com/neptune/latest/userguide/engine-releases.html), or call DescribeDBEngineVersions.
    engine_version: ?[]const u8 = null,

    /// Not supported by Neptune.
    master_user_password: ?[]const u8 = null,

    /// The network type of the DB cluster.
    ///
    /// Valid Values:
    ///
    /// * **
    /// `IPV4`
    /// **   –
    /// The DB cluster uses only IPv4 addresses for communication.
    ///
    /// * **
    /// `DUAL`
    /// **   –
    /// The DB cluster uses both IPv4 and IPv6 addresses for communication. The DB
    /// subnet group
    /// associated with the cluster must support IPv6.
    network_type: ?[]const u8 = null,

    /// The new DB cluster identifier for the DB cluster when renaming a DB cluster.
    /// This value is
    /// stored as a lowercase string.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens
    ///
    /// * The first character must be a letter
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens
    ///
    /// Example: `my-cluster2`
    new_db_cluster_identifier: ?[]const u8 = null,

    /// *Not supported by Neptune.*
    option_group_name: ?[]const u8 = null,

    /// The port number on which the DB cluster accepts connections.
    ///
    /// Constraints: Value must be `1150-65535`
    ///
    /// Default: The same port as the original DB cluster.
    port: ?i32 = null,

    /// The daily time range during which automated backups are created if automated
    /// backups are
    /// enabled, using the `BackupRetentionPeriod` parameter.
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each
    /// Amazon Region.
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

    /// The weekly time range during which system maintenance can occur, in
    /// Universal Coordinated
    /// Time (UTC).
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each
    /// Amazon Region, occurring on a random day of the
    /// week.
    ///
    /// Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun.
    ///
    /// Constraints: Minimum 30-minute window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// Contains the scaling configuration of a Neptune Serverless DB cluster.
    ///
    /// For more information, see [Using Amazon Neptune
    /// Serverless](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-serverless-using.html) in the
    /// *Amazon Neptune User Guide*.
    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfiguration = null,

    /// The storage type to associate with the DB cluster.
    ///
    /// Valid Values:
    ///
    /// * **
    /// `standard`
    /// **   –
    /// ( *the default* ) Configures cost-effective database storage for
    /// applications
    /// with moderate to small I/O usage.
    ///
    /// * **
    /// `iopt1`
    /// **   –
    /// Enables [I/O-Optimized
    /// storage](https://docs.aws.amazon.com/neptune/latest/userguide/storage-types.html#provisioned-iops-storage)
    /// that's designed to meet the needs of I/O-intensive graph workloads that
    /// require predictable pricing with low I/O latency and consistent I/O
    /// throughput.
    ///
    /// Neptune I/O-Optimized storage is only available starting with engine release
    /// 1.3.0.0.
    storage_type: ?[]const u8 = null,

    /// A list of VPC security groups that the DB cluster will belong to.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const ModifyDBClusterOutput = struct {
    db_cluster: ?DBCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBClusterInput, options: CallOptions) !ModifyDBClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBCluster&Version=2014-10-31");
    if (input.allow_major_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AllowMajorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.apply_immediately) |v| {
        try body_buf.appendSlice(allocator, "&ApplyImmediately=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.backup_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&BackupRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.cloudwatch_logs_export_configuration) |v| {
        if (v.disable_log_types) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CloudwatchLogsExportConfiguration.DisableLogTypes.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
        if (v.enable_log_types) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CloudwatchLogsExportConfiguration.EnableLogTypes.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
    }
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    if (input.db_cluster_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_instance_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBInstanceParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(allocator, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_iam_database_authentication) |v| {
        try body_buf.appendSlice(allocator, "&EnableIAMDatabaseAuthentication=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.network_type) |v| {
        try body_buf.appendSlice(allocator, "&NetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.new_db_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&NewDBClusterIdentifier=");
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
    if (input.preferred_backup_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredBackupWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
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
    if (input.storage_type) |v| {
        try body_buf.appendSlice(allocator, "&StorageType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBClusterResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBClusterOutput = .{};
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
