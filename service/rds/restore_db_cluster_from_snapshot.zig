const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RdsCustomClusterConfiguration = @import("rds_custom_cluster_configuration.zig").RdsCustomClusterConfiguration;
const ScalingConfiguration = @import("scaling_configuration.zig").ScalingConfiguration;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const Tag = @import("tag.zig").Tag;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const RestoreDBClusterFromSnapshotInput = struct {
    /// Provides the list of Availability Zones (AZs) where instances in the
    /// restored DB cluster can be created.
    ///
    /// Valid for: Aurora DB clusters only
    availability_zones: ?[]const []const u8 = null,

    /// The target backtrack window, in seconds. To disable backtracking, set this
    /// value to 0.
    ///
    /// Currently, Backtrack is only supported for Aurora MySQL DB clusters.
    ///
    /// Default: 0
    ///
    /// Constraints:
    ///
    /// * If specified, this value must be set to a number from 0 to 259,200 (72
    ///   hours).
    ///
    /// Valid for: Aurora DB clusters only
    backtrack_window: ?i64 = null,

    /// The number of days for which automated backups are retained. Specify a
    /// minimum value of `1`.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Default: Uses existing setting
    ///
    /// Constraints:
    ///
    /// * Must be a value from 1 to 35.
    backup_retention_period: ?i32 = null,

    /// Specifies whether to copy all tags from the restored DB cluster to snapshots
    /// of the restored DB cluster. The default is not to copy them.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    copy_tags_to_snapshot: ?bool = null,

    /// The database name for the restored DB cluster.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    database_name: ?[]const u8 = null,

    /// The name of the DB cluster to create from the DB snapshot or DB cluster
    /// snapshot. This parameter isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens
    /// * First character must be a letter
    /// * Can't end with a hyphen or contain two consecutive hyphens
    ///
    /// Example: `my-snapshot-id`
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    db_cluster_identifier: []const u8,

    /// The compute and memory capacity of the each DB instance in the Multi-AZ DB
    /// cluster, for example db.m6gd.xlarge. Not all DB instance classes are
    /// available in all Amazon Web Services Regions, or for all database engines.
    ///
    /// For the full list of DB instance classes, and availability for your engine,
    /// see [DB Instance
    /// Class](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the *Amazon RDS User Guide.*
    ///
    /// Valid for: Multi-AZ DB clusters only
    db_cluster_instance_class: ?[]const u8 = null,

    /// The name of the DB cluster parameter group to associate with this DB
    /// cluster. If this argument is omitted, the default DB cluster parameter group
    /// for the specified engine is used.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the name of an existing default DB cluster
    ///   parameter group.
    /// * Must be 1 to 255 letters, numbers, or hyphens.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    db_cluster_parameter_group_name: ?[]const u8 = null,

    /// The name of the DB subnet group to use for the new DB cluster.
    ///
    /// Constraints: If supplied, must match the name of an existing DB subnet
    /// group.
    ///
    /// Example: `mydbsubnetgroup`
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    db_subnet_group_name: ?[]const u8 = null,

    /// Specifies whether to enable deletion protection for the DB cluster. The
    /// database can't be deleted when deletion protection is enabled. By default,
    /// deletion protection isn't enabled.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    deletion_protection: ?bool = null,

    /// The Active Directory directory ID to restore the DB cluster in. The domain
    /// must be created prior to this operation. Currently, only MySQL, Microsoft
    /// SQL Server, Oracle, and PostgreSQL DB instances can be created in an Active
    /// Directory Domain.
    ///
    /// For more information, see [ Kerberos
    /// Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/kerberos-authentication.html) in the *Amazon RDS User Guide*.
    ///
    /// Valid for: Aurora DB clusters only
    domain: ?[]const u8 = null,

    /// The name of the IAM role to be used when making API calls to the Directory
    /// Service.
    ///
    /// Valid for: Aurora DB clusters only
    domain_iam_role_name: ?[]const u8 = null,

    /// The list of logs that the restored DB cluster is to export to Amazon
    /// CloudWatch Logs. The values in the list depend on the DB engine being used.
    ///
    /// **RDS for MySQL**
    ///
    /// Possible values are `error`, `general`, `slowquery`, and
    /// `iam-db-auth-error`.
    ///
    /// **RDS for PostgreSQL**
    ///
    /// Possible values are `postgresql`, `upgrade`, and `iam-db-auth-error`.
    ///
    /// **Aurora MySQL**
    ///
    /// Possible values are `audit`, `error`, `general`, `instance`, `slowquery`,
    /// and `iam-db-auth-error`.
    ///
    /// **Aurora PostgreSQL**
    ///
    /// Possible value are `instance`, `postgresql`, and `iam-db-auth-error`.
    ///
    /// For more information about exporting CloudWatch Logs for Amazon RDS, see
    /// [Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon RDS User Guide*.
    ///
    /// For more information about exporting CloudWatch Logs for Amazon Aurora, see
    /// [Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon Aurora User Guide*.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    enable_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// Specifies whether to enable mapping of Amazon Web Services Identity and
    /// Access Management (IAM) accounts to database accounts. By default, mapping
    /// isn't enabled.
    ///
    /// For more information, see [ IAM Database
    /// Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon Aurora User Guide* or [ IAM database authentication for MariaDB, MySQL, and PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon RDS User Guide*.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    enable_iam_database_authentication: ?bool = null,

    /// Specifies that the restored DB cluster should use internet-based
    /// connectivity through an internet access gateway. This allows clients to
    /// connect to the cluster over the internet without requiring a VPC.
    ///
    /// This parameter must be used together with `EnableVPCNetworking` set to
    /// `false`. When both parameters are specified, IAM database authentication is
    /// required. You must also specify `EnableIAMDatabaseAuthentication`.
    ///
    /// Valid for Cluster Type: Aurora PostgreSQL clusters
    enable_internet_access_gateway: ?bool = null,

    /// Specifies whether to turn on Performance Insights for the DB cluster.
    enable_performance_insights: ?bool = null,

    /// Specifies whether to enable VPC networking for the restored DB cluster. Set
    /// this parameter to `false` to create a cluster without the VPC network
    /// interface (ENI).
    ///
    /// This parameter must be used together with `EnableInternetAccessGateway`.
    /// When both parameters are specified, IAM database authentication is required.
    /// You must also specify `EnableIAMDatabaseAuthentication`.
    ///
    /// Valid for Cluster Type: Aurora PostgreSQL clusters
    enable_vpc_networking: ?bool = null,

    /// The database engine to use for the new DB cluster.
    ///
    /// Default: The same as source
    ///
    /// Constraint: Must be compatible with the engine of the source
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    engine: []const u8,

    /// The life cycle type for this DB cluster.
    ///
    /// By default, this value is set to `open-source-rds-extended-support`, which
    /// enrolls your DB cluster into Amazon RDS Extended Support. At the end of
    /// standard support, you can avoid charges for Extended Support by setting the
    /// value to `open-source-rds-extended-support-disabled`. In this case, RDS
    /// automatically upgrades your restored DB cluster to a higher engine version,
    /// if the major engine version is past its end of standard support date.
    ///
    /// You can use this setting to enroll your DB cluster into Amazon RDS Extended
    /// Support. With RDS Extended Support, you can run the selected major engine
    /// version on your DB cluster past the end of standard support for that engine
    /// version. For more information, see the following sections:
    ///
    /// * Amazon Aurora - [Amazon RDS Extended Support with Amazon
    ///   Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/extended-support.html) in the *Amazon Aurora User Guide*
    /// * Amazon RDS - [Amazon RDS Extended Support with Amazon
    ///   RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/extended-support.html) in the *Amazon RDS User Guide*
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Valid Values: `open-source-rds-extended-support |
    /// open-source-rds-extended-support-disabled`
    ///
    /// Default: `open-source-rds-extended-support`
    engine_lifecycle_support: ?[]const u8 = null,

    /// The DB engine mode of the DB cluster, either `provisioned` or `serverless`.
    ///
    /// For more information, see [
    /// CreateDBCluster](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBCluster.html).
    ///
    /// Valid for: Aurora DB clusters only
    engine_mode: ?[]const u8 = null,

    /// The version of the database engine to use for the new DB cluster. If you
    /// don't specify an engine version, the default version for the database engine
    /// in the Amazon Web Services Region is used.
    ///
    /// To list all of the available engine versions for Aurora MySQL, use the
    /// following command:
    ///
    /// `aws rds describe-db-engine-versions --engine aurora-mysql --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// To list all of the available engine versions for Aurora PostgreSQL, use the
    /// following command:
    ///
    /// `aws rds describe-db-engine-versions --engine aurora-postgresql --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// To list all of the available engine versions for RDS for MySQL, use the
    /// following command:
    ///
    /// `aws rds describe-db-engine-versions --engine mysql --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// To list all of the available engine versions for RDS for PostgreSQL, use the
    /// following command:
    ///
    /// `aws rds describe-db-engine-versions --engine postgres --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// **Aurora MySQL**
    ///
    /// See [Database engine updates for Amazon Aurora
    /// MySQL](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Updates.html) in the *Amazon Aurora User Guide*.
    ///
    /// **Aurora PostgreSQL**
    ///
    /// See [Amazon Aurora PostgreSQL releases and engine
    /// versions](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Updates.20180305.html) in the *Amazon Aurora User Guide*.
    ///
    /// **MySQL**
    ///
    /// See [Amazon RDS for
    /// MySQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt) in the *Amazon RDS User Guide.*
    ///
    /// **PostgreSQL**
    ///
    /// See [Amazon RDS for PostgreSQL versions and
    /// extensions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts) in the *Amazon RDS User Guide.*
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    engine_version: ?[]const u8 = null,

    /// The amount of Provisioned IOPS (input/output operations per second) to be
    /// initially allocated for each DB instance in the Multi-AZ DB cluster.
    ///
    /// For information about valid IOPS values, see [Amazon RDS Provisioned IOPS
    /// storage](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS) in the *Amazon RDS User Guide*.
    ///
    /// Constraints: Must be a multiple between .5 and 50 of the storage amount for
    /// the DB instance.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    iops: ?i32 = null,

    /// The Amazon Web Services KMS key identifier to use when restoring an
    /// encrypted DB cluster from a DB snapshot or DB cluster snapshot.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
    ///
    /// When you don't specify a value for the `KmsKeyId` parameter, then the
    /// following occurs:
    ///
    /// * If the DB snapshot or DB cluster snapshot in `SnapshotIdentifier` is
    ///   encrypted, then the restored DB cluster is encrypted using the KMS key
    ///   that was used to encrypt the DB snapshot or DB cluster snapshot.
    /// * If the DB snapshot or DB cluster snapshot in `SnapshotIdentifier` isn't
    ///   encrypted, then the restored DB cluster isn't encrypted.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    kms_key_id: ?[]const u8 = null,

    /// The interval, in seconds, between points when Enhanced Monitoring metrics
    /// are collected for the DB cluster. To turn off collecting Enhanced Monitoring
    /// metrics, specify `0`.
    ///
    /// If `MonitoringRoleArn` is specified, also set `MonitoringInterval` to a
    /// value other than `0`.
    ///
    /// Valid Values: `0 | 1 | 5 | 10 | 15 | 30 | 60`
    ///
    /// Default: `0`
    monitoring_interval: ?i32 = null,

    /// The Amazon Resource Name (ARN) for the IAM role that permits RDS to send
    /// Enhanced Monitoring metrics to Amazon CloudWatch Logs. An example is
    /// `arn:aws:iam:123456789012:role/emaccess`.
    ///
    /// If `MonitoringInterval` is set to a value other than `0`, supply a
    /// `MonitoringRoleArn` value.
    monitoring_role_arn: ?[]const u8 = null,

    /// The network type of the DB cluster.
    ///
    /// Valid Values:
    ///
    /// * `IPV4`
    /// * `DUAL`
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for the DB
    /// cluster. A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4
    /// and the IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [ Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon Aurora User Guide.*
    ///
    /// Valid for: Aurora DB clusters only
    network_type: ?[]const u8 = null,

    /// The name of the option group to use for the restored DB cluster.
    ///
    /// DB clusters are associated with a default option group that can't be
    /// modified.
    option_group_name: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier for encryption of Performance
    /// Insights data.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    ///
    /// If you don't specify a value for `PerformanceInsightsKMSKeyId`, then Amazon
    /// RDS uses your default KMS key. There is a default KMS key for your Amazon
    /// Web Services account. Your Amazon Web Services account has a different
    /// default KMS key for each Amazon Web Services Region.
    performance_insights_kms_key_id: ?[]const u8 = null,

    /// The number of days to retain Performance Insights data.
    ///
    /// Valid Values:
    ///
    /// * `7`
    /// * *month* * 31, where *month* is a number of months from 1-23. Examples:
    ///   `93` (3 months * 31), `341` (11 months * 31), `589` (19 months * 31)
    /// * `731`
    ///
    /// Default: `7` days
    ///
    /// If you specify a retention period that isn't valid, such as `94`, Amazon RDS
    /// issues an error.
    performance_insights_retention_period: ?i32 = null,

    /// The port number on which the new DB cluster accepts connections.
    ///
    /// Constraints: This value must be `1150-65535`
    ///
    /// Default: The same port as the original DB cluster.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    port: ?i32 = null,

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled, using the `BackupRetentionPeriod` parameter.
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region. To view the time blocks available,
    /// see [ Backup
    /// window](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.Backups.BackupWindow) in the *Amazon Aurora User Guide*.
    ///
    /// Valid for Cluster Type: Aurora DB clusters and Multi-AZ DB clusters
    ///
    /// Constraints:
    ///
    /// * Must be in the format `hh24:mi-hh24:mi`.
    /// * Must be in Universal Coordinated Time (UTC).
    /// * Must not conflict with the preferred maintenance window.
    /// * Must be at least 30 minutes.
    preferred_backup_window: ?[]const u8 = null,

    /// Specifies whether the DB cluster is publicly accessible.
    ///
    /// When the DB cluster is publicly accessible, its Domain Name System (DNS)
    /// endpoint resolves to the private IP address from within the DB cluster's
    /// virtual private cloud (VPC). It resolves to the public IP address from
    /// outside of the DB cluster's VPC. Access to the DB cluster is ultimately
    /// controlled by the security group it uses. That public access is not
    /// permitted if the security group assigned to the DB cluster doesn't permit
    /// it.
    ///
    /// When the DB cluster isn't publicly accessible, it is an internal DB cluster
    /// with a DNS name that resolves to a private IP address.
    ///
    /// Default: The default behavior varies depending on whether
    /// `DBSubnetGroupName` is specified.
    ///
    /// If `DBSubnetGroupName` isn't specified, and `PubliclyAccessible` isn't
    /// specified, the following applies:
    ///
    /// * If the default VPC in the target Region doesn’t have an internet gateway
    ///   attached to it, the DB cluster is private.
    /// * If the default VPC in the target Region has an internet gateway attached
    ///   to it, the DB cluster is public.
    ///
    /// If `DBSubnetGroupName` is specified, and `PubliclyAccessible` isn't
    /// specified, the following applies:
    ///
    /// * If the subnets are part of a VPC that doesn’t have an internet gateway
    ///   attached to it, the DB cluster is private.
    /// * If the subnets are part of a VPC that has an internet gateway attached to
    ///   it, the DB cluster is public.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    publicly_accessible: ?bool = null,

    /// Reserved for future use.
    rds_custom_cluster_configuration: ?RdsCustomClusterConfiguration = null,

    /// For DB clusters in `serverless` DB engine mode, the scaling properties of
    /// the DB cluster.
    ///
    /// Valid for: Aurora DB clusters only
    scaling_configuration: ?ScalingConfiguration = null,

    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfiguration = null,

    /// The identifier for the DB snapshot or DB cluster snapshot to restore from.
    ///
    /// You can use either the name or the Amazon Resource Name (ARN) to specify a
    /// DB cluster snapshot. However, you can use only the ARN to specify a DB
    /// snapshot.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing Snapshot.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    snapshot_identifier: []const u8,

    /// Specifies the storage type to be associated with the DB cluster.
    ///
    /// When specified for a Multi-AZ DB cluster, a value for the `Iops` parameter
    /// is required.
    ///
    /// Valid Values: `aurora`, `aurora-iopt1` (Aurora DB clusters); `io1` (Multi-AZ
    /// DB clusters)
    ///
    /// Default: `aurora` (Aurora DB clusters); `io1` (Multi-AZ DB clusters)
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    storage_type: ?[]const u8 = null,

    /// The tags to be assigned to the restored DB cluster.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
    tags: ?[]const Tag = null,

    /// Tags to assign to resources associated with the DB cluster.
    ///
    /// Valid Values:
    ///
    /// * `cluster-auto-backup` - The DB cluster's automated backup.
    tag_specifications: ?[]const TagSpecification = null,

    /// A list of VPC security groups that the new DB cluster will belong to.
    ///
    /// Valid for: Aurora DB clusters and Multi-AZ DB clusters
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
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

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
    if (input.backtrack_window) |v| {
        try body_buf.appendSlice(allocator, "&BacktrackWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.backup_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&BackupRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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
    if (input.db_cluster_instance_class) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterInstanceClass=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
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
    if (input.domain) |v| {
        try body_buf.appendSlice(allocator, "&Domain=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.domain_iam_role_name) |v| {
        try body_buf.appendSlice(allocator, "&DomainIAMRoleName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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
    if (input.enable_internet_access_gateway) |v| {
        try body_buf.appendSlice(allocator, "&EnableInternetAccessGateway=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_performance_insights) |v| {
        try body_buf.appendSlice(allocator, "&EnablePerformanceInsights=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_vpc_networking) |v| {
        try body_buf.appendSlice(allocator, "&EnableVPCNetworking=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
    if (input.engine_lifecycle_support) |v| {
        try body_buf.appendSlice(allocator, "&EngineLifecycleSupport=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_mode) |v| {
        try body_buf.appendSlice(allocator, "&EngineMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.iops) |v| {
        try body_buf.appendSlice(allocator, "&Iops=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.monitoring_interval) |v| {
        try body_buf.appendSlice(allocator, "&MonitoringInterval=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.monitoring_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&MonitoringRoleArn=");
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
    if (input.performance_insights_kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&PerformanceInsightsKMSKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.performance_insights_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&PerformanceInsightsRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.port) |v| {
        try body_buf.appendSlice(allocator, "&Port=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.preferred_backup_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredBackupWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.publicly_accessible) |v| {
        try body_buf.appendSlice(allocator, "&PubliclyAccessible=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.rds_custom_cluster_configuration) |v| {
        if (v.interconnect_subnet_id) |sv| {
            try body_buf.appendSlice(allocator, "&RdsCustomClusterConfiguration.InterconnectSubnetId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.replica_mode) |sv| {
            try body_buf.appendSlice(allocator, "&RdsCustomClusterConfiguration.ReplicaMode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.transit_gateway_multicast_domain_id) |sv| {
            try body_buf.appendSlice(allocator, "&RdsCustomClusterConfiguration.TransitGatewayMulticastDomainId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.scaling_configuration) |v| {
        if (v.auto_pause) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.AutoPause=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.max_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.MaxCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.min_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.MinCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.seconds_before_timeout) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.SecondsBeforeTimeout=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.seconds_until_auto_pause) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.SecondsUntilAutoPause=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.timeout_action) |sv| {
            try body_buf.appendSlice(allocator, "&ScalingConfiguration.TimeoutAction=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
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
        if (v.seconds_until_auto_pause) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.SecondsUntilAutoPause=");
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
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
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
