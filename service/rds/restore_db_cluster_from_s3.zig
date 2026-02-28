const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const Tag = @import("tag.zig").Tag;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const RestoreDBClusterFromS3Input = struct {
    /// A list of Availability Zones (AZs) where instances in the restored DB
    /// cluster can be created.
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
    backtrack_window: ?i64 = null,

    /// The number of days for which automated backups of the restored DB cluster
    /// are retained. You must specify a minimum value of 1.
    ///
    /// Default: 1
    ///
    /// Constraints:
    ///
    /// * Must be a value from 1 to 35
    backup_retention_period: ?i32 = null,

    /// A value that indicates that the restored DB cluster should be associated
    /// with the specified CharacterSet.
    character_set_name: ?[]const u8 = null,

    /// Specifies whether to copy all tags from the restored DB cluster to snapshots
    /// of the restored DB cluster. The default is not to copy them.
    copy_tags_to_snapshot: ?bool = null,

    /// The database name for the restored DB cluster.
    database_name: ?[]const u8 = null,

    /// The name of the DB cluster to create from the source data in the Amazon S3
    /// bucket. This parameter isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `my-cluster1`
    db_cluster_identifier: []const u8,

    /// The name of the DB cluster parameter group to associate with the restored DB
    /// cluster. If this argument is omitted, the default parameter group for the
    /// engine version is used.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the name of an existing DBClusterParameterGroup.
    db_cluster_parameter_group_name: ?[]const u8 = null,

    /// A DB subnet group to associate with the restored DB cluster.
    ///
    /// Constraints: If supplied, must match the name of an existing DBSubnetGroup.
    ///
    /// Example: `mydbsubnetgroup`
    db_subnet_group_name: ?[]const u8 = null,

    /// Specifies whether to enable deletion protection for the DB cluster. The
    /// database can't be deleted when deletion protection is enabled. By default,
    /// deletion protection isn't enabled.
    deletion_protection: ?bool = null,

    /// Specify the Active Directory directory ID to restore the DB cluster in. The
    /// domain must be created prior to this operation.
    ///
    /// For Amazon Aurora DB clusters, Amazon RDS can use Kerberos Authentication to
    /// authenticate users that connect to the DB cluster. For more information, see
    /// [Kerberos
    /// Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/kerberos-authentication.html) in the *Amazon Aurora User Guide*.
    domain: ?[]const u8 = null,

    /// Specify the name of the IAM role to be used when making API calls to the
    /// Directory Service.
    domain_iam_role_name: ?[]const u8 = null,

    /// The list of logs that the restored DB cluster is to export to CloudWatch
    /// Logs. The values in the list depend on the DB engine being used.
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
    enable_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// Specifies whether to enable mapping of Amazon Web Services Identity and
    /// Access Management (IAM) accounts to database accounts. By default, mapping
    /// isn't enabled.
    ///
    /// For more information, see [ IAM Database
    /// Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon Aurora User Guide*.
    enable_iam_database_authentication: ?bool = null,

    /// The name of the database engine to be used for this DB cluster.
    ///
    /// Valid Values: `aurora-mysql` (for Aurora MySQL)
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

    /// The version number of the database engine to use.
    ///
    /// To list all of the available engine versions for `aurora-mysql` (Aurora
    /// MySQL), use the following command:
    ///
    /// `aws rds describe-db-engine-versions --engine aurora-mysql --query
    /// "DBEngineVersions[].EngineVersion"`
    ///
    /// **Aurora MySQL**
    ///
    /// Examples: `5.7.mysql_aurora.2.12.0`, `8.0.mysql_aurora.3.04.0`
    engine_version: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier for an encrypted DB cluster.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
    ///
    /// If the StorageEncrypted parameter is enabled, and you do not specify a value
    /// for the `KmsKeyId` parameter, then Amazon RDS will use your default KMS key.
    /// There is a default KMS key for your Amazon Web Services account. Your Amazon
    /// Web Services account has a different default KMS key for each Amazon Web
    /// Services Region.
    kms_key_id: ?[]const u8 = null,

    /// Specifies whether to manage the master user password with Amazon Web
    /// Services Secrets Manager.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide* and [Password management with Amazon Web Services Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/rds-secrets-manager.html) in the *Amazon Aurora User Guide.*
    ///
    /// Constraints:
    ///
    /// * Can't manage the master user password with Amazon Web Services Secrets
    ///   Manager if `MasterUserPassword` is specified.
    manage_master_user_password: ?bool = null,

    /// The name of the master user for the restored DB cluster.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 16 letters or numbers.
    /// * First character must be a letter.
    /// * Can't be a reserved word for the chosen database engine.
    master_username: []const u8,

    /// The password for the master database user. This password can contain any
    /// printable ASCII character except "/", """, or "@".
    ///
    /// Constraints:
    ///
    /// * Must contain from 8 to 41 characters.
    /// * Can't be specified if `ManageMasterUserPassword` is turned on.
    master_user_password: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier to encrypt a secret that is
    /// automatically generated and managed in Amazon Web Services Secrets Manager.
    ///
    /// This setting is valid only if the master user password is managed by RDS in
    /// Amazon Web Services Secrets Manager for the DB cluster.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
    ///
    /// If you don't specify `MasterUserSecretKmsKeyId`, then the
    /// `aws/secretsmanager` KMS key is used to encrypt the secret. If the secret is
    /// in a different Amazon Web Services account, then you can't use the
    /// `aws/secretsmanager` KMS key to encrypt the secret, and you must use a
    /// customer managed KMS key.
    ///
    /// There is a default KMS key for your Amazon Web Services account. Your Amazon
    /// Web Services account has a different default KMS key for each Amazon Web
    /// Services Region.
    master_user_secret_kms_key_id: ?[]const u8 = null,

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
    network_type: ?[]const u8 = null,

    /// A value that indicates that the restored DB cluster should be associated
    /// with the specified option group.
    ///
    /// Permanent options can't be removed from an option group. An option group
    /// can't be removed from a DB cluster once it is associated with a DB cluster.
    option_group_name: ?[]const u8 = null,

    /// The port number on which the instances in the restored DB cluster accept
    /// connections.
    ///
    /// Default: `3306`
    port: ?i32 = null,

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled using the `BackupRetentionPeriod` parameter.
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region. To view the time blocks available,
    /// see [ Backup
    /// window](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.Backups.BackupWindow) in the *Amazon Aurora User Guide*.
    ///
    /// Constraints:
    ///
    /// * Must be in the format `hh24:mi-hh24:mi`.
    /// * Must be in Universal Coordinated Time (UTC).
    /// * Must not conflict with the preferred maintenance window.
    /// * Must be at least 30 minutes.
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur, in
    /// Universal Coordinated Time (UTC).
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region, occurring on a random day of the
    /// week. To see the time blocks available, see [ Adjusting the Preferred
    /// Maintenance
    /// Window](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora) in the *Amazon Aurora User Guide*.
    ///
    /// Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun.
    ///
    /// Constraints: Minimum 30-minute window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// The name of the Amazon S3 bucket that contains the data used to create the
    /// Amazon Aurora DB cluster.
    s3_bucket_name: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Identity and
    /// Access Management (IAM) role that authorizes Amazon RDS to access the Amazon
    /// S3 bucket on your behalf.
    s3_ingestion_role_arn: []const u8,

    /// The prefix for all of the file names that contain the data used to create
    /// the Amazon Aurora DB cluster. If you do not specify a **SourceS3Prefix**
    /// value, then the Amazon Aurora DB cluster is created by using all of the
    /// files in the Amazon S3 bucket.
    s3_prefix: ?[]const u8 = null,

    serverless_v2_scaling_configuration: ?ServerlessV2ScalingConfiguration = null,

    /// The identifier for the database engine that was backed up to create the
    /// files stored in the Amazon S3 bucket.
    ///
    /// Valid Values: `mysql`
    source_engine: []const u8,

    /// The version of the database that the backup files were created from.
    ///
    /// MySQL versions 5.7 and 8.0 are supported.
    ///
    /// Example: `5.7.40`, `8.0.28`
    source_engine_version: []const u8,

    /// Specifies whether the restored DB cluster is encrypted.
    storage_encrypted: ?bool = null,

    /// Specifies the storage type to be associated with the DB cluster.
    ///
    /// Valid Values: `aurora`, `aurora-iopt1`
    ///
    /// Default: `aurora`
    ///
    /// Valid for: Aurora DB clusters only
    storage_type: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    /// Tags to assign to resources associated with the DB cluster.
    ///
    /// Valid Values:
    ///
    /// * `cluster-auto-backup` - The DB cluster's automated backup.
    tag_specifications: ?[]const TagSpecification = null,

    /// A list of EC2 VPC security groups to associate with the restored DB cluster.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const RestoreDBClusterFromS3Output = struct {
    db_cluster: ?DBCluster = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreDBClusterFromS3Input, options: Options) !RestoreDBClusterFromS3Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "rds");

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

fn serializeRequest(alloc: std.mem.Allocator, input: RestoreDBClusterFromS3Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RestoreDBClusterFromS3&Version=2014-10-31");
    if (input.availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZones.AvailabilityZone.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.backtrack_window) |v| {
        try body_buf.appendSlice(alloc, "&BacktrackWindow=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.backup_retention_period) |v| {
        try body_buf.appendSlice(alloc, "&BackupRetentionPeriod=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.character_set_name) |v| {
        try body_buf.appendSlice(alloc, "&CharacterSetName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(alloc, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.database_name) |v| {
        try body_buf.appendSlice(alloc, "&DatabaseName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.db_cluster_identifier);
    if (input.db_cluster_parameter_group_name) |v| {
        try body_buf.appendSlice(alloc, "&DBClusterParameterGroupName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.db_subnet_group_name) |v| {
        try body_buf.appendSlice(alloc, "&DBSubnetGroupName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(alloc, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.domain) |v| {
        try body_buf.appendSlice(alloc, "&Domain=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.domain_iam_role_name) |v| {
        try body_buf.appendSlice(alloc, "&DomainIAMRoleName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.enable_cloudwatch_logs_exports) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EnableCloudwatchLogsExports.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.enable_iam_database_authentication) |v| {
        try body_buf.appendSlice(alloc, "&EnableIAMDatabaseAuthentication=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&Engine=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.engine);
    if (input.engine_lifecycle_support) |v| {
        try body_buf.appendSlice(alloc, "&EngineLifecycleSupport=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(alloc, "&EngineVersion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.manage_master_user_password) |v| {
        try body_buf.appendSlice(alloc, "&ManageMasterUserPassword=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&MasterUsername=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.master_username);
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(alloc, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.master_user_secret_kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&MasterUserSecretKmsKeyId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.network_type) |v| {
        try body_buf.appendSlice(alloc, "&NetworkType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.option_group_name) |v| {
        try body_buf.appendSlice(alloc, "&OptionGroupName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.port) |v| {
        try body_buf.appendSlice(alloc, "&Port=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.preferred_backup_window) |v| {
        try body_buf.appendSlice(alloc, "&PreferredBackupWindow=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(alloc, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&S3BucketName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.s3_bucket_name);
    try body_buf.appendSlice(alloc, "&S3IngestionRoleArn=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.s3_ingestion_role_arn);
    if (input.s3_prefix) |v| {
        try body_buf.appendSlice(alloc, "&S3Prefix=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.serverless_v2_scaling_configuration) |v| {
        if (v.max_capacity) |sv| {
            try body_buf.appendSlice(alloc, "&ServerlessV2ScalingConfiguration.MaxCapacity=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.min_capacity) |sv| {
            try body_buf.appendSlice(alloc, "&ServerlessV2ScalingConfiguration.MinCapacity=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.seconds_until_auto_pause) |sv| {
            try body_buf.appendSlice(alloc, "&ServerlessV2ScalingConfiguration.SecondsUntilAutoPause=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    try body_buf.appendSlice(alloc, "&SourceEngine=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.source_engine);
    try body_buf.appendSlice(alloc, "&SourceEngineVersion=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.source_engine_version);
    if (input.storage_encrypted) |v| {
        try body_buf.appendSlice(alloc, "&StorageEncrypted=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.storage_type) |v| {
        try body_buf.appendSlice(alloc, "&StorageType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.Tag.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.Tag.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
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
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RestoreDBClusterFromS3Output {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RestoreDBClusterFromS3Result")) break;
            },
            else => {},
        }
    }

    var result: RestoreDBClusterFromS3Output = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBCluster")) {
                    result.db_cluster = try serde.deserializeDBCluster(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AuthorizationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackupPolicyNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .backup_policy_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BlueGreenDeploymentAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .blue_green_deployment_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BlueGreenDeploymentNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .blue_green_deployment_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "CreateCustomDBEngineVersionFault")) {
        return .{ .arena = arena, .kind = .{ .create_custom_db_engine_version_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomAvailabilityZoneNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .custom_availability_zone_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomDBEngineVersionAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .custom_db_engine_version_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomDBEngineVersionNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .custom_db_engine_version_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomDBEngineVersionQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .custom_db_engine_version_quota_exceeded_fault = .{
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
    if (std.mem.eql(u8, error_code, "DBClusterAutomatedBackupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_automated_backup_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterAutomatedBackupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_automated_backup_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterBacktrackNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_backtrack_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterEndpointAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_endpoint_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterEndpointNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_endpoint_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterEndpointQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_endpoint_quota_exceeded_fault = .{
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
    if (std.mem.eql(u8, error_code, "DBClusterRoleAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_role_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterRoleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_role_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBClusterRoleQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_cluster_role_quota_exceeded_fault = .{
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
    if (std.mem.eql(u8, error_code, "DBInstanceAutomatedBackupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_automated_backup_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceAutomatedBackupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_automated_backup_quota_exceeded_fault = .{
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
    if (std.mem.eql(u8, error_code, "DBInstanceNotReadyFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_not_ready_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceRoleAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_role_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceRoleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_role_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBInstanceRoleQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_instance_role_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBLogFileNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_log_file_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "DBProxyAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyEndpointAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_endpoint_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyEndpointNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_endpoint_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyEndpointQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_endpoint_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyTargetAlreadyRegisteredFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_target_already_registered_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyTargetGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_target_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBProxyTargetNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_proxy_target_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSecurityGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_security_group_already_exists_fault = .{
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
    if (std.mem.eql(u8, error_code, "DBSecurityGroupNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .db_security_group_not_supported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBSecurityGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .db_security_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBShardGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .db_shard_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DBShardGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_shard_group_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "DBSnapshotTenantDatabaseNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .db_snapshot_tenant_database_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "DBSubnetGroupNotAllowedFault")) {
        return .{ .arena = arena, .kind = .{ .db_subnet_group_not_allowed_fault = .{
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
    if (std.mem.eql(u8, error_code, "DomainNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .domain_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "Ec2ImagePropertiesNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .ec_2_image_properties_not_supported_fault = .{
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
    if (std.mem.eql(u8, error_code, "ExportTaskAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .export_task_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExportTaskNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .export_task_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "IamRoleMissingPermissionsFault")) {
        return .{ .arena = arena, .kind = .{ .iam_role_missing_permissions_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IamRoleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .iam_role_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "InsufficientAvailableIPsInSubnetFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_available_i_ps_in_subnet_fault = .{
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
    if (std.mem.eql(u8, error_code, "IntegrationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .integration_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictOperationFault")) {
        return .{ .arena = arena, .kind = .{ .integration_conflict_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .integration_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBlueGreenDeploymentStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_blue_green_deployment_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCustomDBEngineVersionStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_custom_db_engine_version_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterAutomatedBackupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_automated_backup_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBClusterEndpointStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_cluster_endpoint_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidDBInstanceAutomatedBackupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_instance_automated_backup_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidDBProxyEndpointStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_proxy_endpoint_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDBProxyStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_proxy_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidDBShardGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_shard_group_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidDBSubnetGroupFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_db_subnet_group_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidExportOnlyFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_only_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportSourceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_source_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportTaskStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_task_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidIntegrationStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_integration_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOptionGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_option_group_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRestoreFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_restore_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_fault = .{
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
    if (std.mem.eql(u8, error_code, "MaxDBShardGroupLimitReached")) {
        return .{ .arena = arena, .kind = .{ .max_db_shard_group_limit_reached = .{
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
    if (std.mem.eql(u8, error_code, "OptionGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .option_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptionGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .option_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptionGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .option_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PointInTimeRestoreNotEnabledFault")) {
        return .{ .arena = arena, .kind = .{ .point_in_time_restore_not_enabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedIopsNotAvailableInAZFault")) {
        return .{ .arena = arena, .kind = .{ .provisioned_iops_not_available_in_az_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedDBInstanceAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_db_instance_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedDBInstanceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_db_instance_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedDBInstanceQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_db_instance_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedDBInstancesOfferingNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_db_instances_offering_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "SourceClusterNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .source_cluster_not_supported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceDatabaseNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .source_database_not_supported_fault = .{
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
    if (std.mem.eql(u8, error_code, "StorageTypeNotAvailableFault")) {
        return .{ .arena = arena, .kind = .{ .storage_type_not_available_fault = .{
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
    if (std.mem.eql(u8, error_code, "TenantDatabaseAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .tenant_database_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TenantDatabaseNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .tenant_database_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TenantDatabaseQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .tenant_database_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedDBEngineVersionFault")) {
        return .{ .arena = arena, .kind = .{ .unsupported_db_engine_version_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VpcEncryptionControlViolationException")) {
        return .{ .arena = arena, .kind = .{ .vpc_encryption_control_violation_exception = .{
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
