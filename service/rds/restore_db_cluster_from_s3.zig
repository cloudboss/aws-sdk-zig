const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBClusterAssociatedRole = @import("db_cluster_associated_role.zig").DBClusterAssociatedRole;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const Tag = @import("tag.zig").Tag;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const RestoreDBClusterFromS3Input = struct {
    /// A list of Amazon Web Services Identity and Access Management (IAM) roles to
    /// associate with the DB cluster when it's restored from Amazon S3. Each role
    /// grants the DB cluster permission to access other Amazon Web Services on your
    /// behalf. For each role, specify a role ARN and, optionally, the feature name
    /// (such as `s3Import`, `s3Export`, or `Lambda`).
    associated_roles: ?[]const DBClusterAssociatedRole = null,

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

    /// The lifecycle type for this DB cluster.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreDBClusterFromS3Input, options: CallOptions) !RestoreDBClusterFromS3Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreDBClusterFromS3Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RestoreDBClusterFromS3&Version=2014-10-31");
    if (input.associated_roles) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.feature_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AssociatedRoles.DBClusterAssociatedRole.{d}.FeatureName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AssociatedRoles.DBClusterAssociatedRole.{d}.RoleArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.role_arn);
            }
        }
    }
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
    if (input.character_set_name) |v| {
        try body_buf.appendSlice(allocator, "&CharacterSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
    if (input.engine_lifecycle_support) |v| {
        try body_buf.appendSlice(allocator, "&EngineLifecycleSupport=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
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
    try body_buf.appendSlice(allocator, "&MasterUsername=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.master_username);
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
    try body_buf.appendSlice(allocator, "&S3BucketName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.s3_bucket_name);
    try body_buf.appendSlice(allocator, "&S3IngestionRoleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.s3_ingestion_role_arn);
    if (input.s3_prefix) |v| {
        try body_buf.appendSlice(allocator, "&S3Prefix=");
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
        if (v.seconds_until_auto_pause) |sv| {
            try body_buf.appendSlice(allocator, "&ServerlessV2ScalingConfiguration.SecondsUntilAutoPause=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    try body_buf.appendSlice(allocator, "&SourceEngine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_engine);
    try body_buf.appendSlice(allocator, "&SourceEngineVersion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_engine_version);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreDBClusterFromS3Output {
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
