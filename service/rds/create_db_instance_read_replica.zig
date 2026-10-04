const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdditionalStorageVolume = @import("additional_storage_volume.zig").AdditionalStorageVolume;
const DatabaseInsightsMode = @import("database_insights_mode.zig").DatabaseInsightsMode;
const ProcessorFeature = @import("processor_feature.zig").ProcessorFeature;
const ReplicaMode = @import("replica_mode.zig").ReplicaMode;
const Tag = @import("tag.zig").Tag;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const DBInstance = @import("db_instance.zig").DBInstance;
const serde = @import("serde.zig");

pub const CreateDBInstanceReadReplicaInput = struct {
    /// A list of additional storage volumes to create for the DB instance. You can
    /// create up to three additional storage volumes using the names `rdsdbdata2`,
    /// `rdsdbdata3`, and `rdsdbdata4`. Additional storage volumes are supported for
    /// RDS for Oracle and RDS for SQL Server DB instances only.
    additional_storage_volumes: ?[]const AdditionalStorageVolume = null,

    /// The amount of storage (in gibibytes) to allocate initially for the read
    /// replica. Follow the allocation rules specified in `CreateDBInstance`.
    ///
    /// This setting isn't valid for RDS for SQL Server.
    ///
    /// Be sure to allocate enough storage for your read replica so that the create
    /// operation can succeed. You can also allocate additional storage for future
    /// growth.
    allocated_storage: ?i32 = null,

    /// Specifies whether to automatically apply minor engine upgrades to the read
    /// replica during the maintenance window.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Default: Inherits the value from the source DB instance.
    ///
    /// For more information about automatic minor version upgrades, see
    /// [Automatically upgrading the minor engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades).
    auto_minor_version_upgrade: ?bool = null,

    /// The Availability Zone (AZ) where the read replica will be created.
    ///
    /// Default: A random, system-chosen Availability Zone in the endpoint's Amazon
    /// Web Services Region.
    ///
    /// Example: `us-east-1d`
    availability_zone: ?[]const u8 = null,

    /// The location where RDS stores automated backups and manual snapshots.
    ///
    /// Valid Values:
    ///
    /// * `local` for Dedicated Local Zones
    /// * `region` for Amazon Web Services Region
    backup_target: ?[]const u8 = null,

    /// The CA certificate identifier to use for the read replica's server
    /// certificate.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// For more information, see [Using SSL/TLS to encrypt a connection to a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
    ca_certificate_identifier: ?[]const u8 = null,

    /// Specifies whether to copy all tags from the read replica to snapshots of the
    /// read replica. By default, tags aren't copied.
    copy_tags_to_snapshot: ?bool = null,

    /// The instance profile associated with the underlying Amazon EC2 instance of
    /// an RDS Custom DB instance. The instance profile must meet the following
    /// requirements:
    ///
    /// * The profile must exist in your account.
    /// * The profile must have an IAM role that Amazon EC2 has permissions to
    ///   assume.
    /// * The instance profile name and the associated IAM role name must start with
    ///   the prefix `AWSRDSCustom`.
    ///
    /// For the list of permissions required for the IAM role, see [ Configure IAM
    /// and your
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-setup-orcl.html#custom-setup-orcl.iam-vpc) in the *Amazon RDS User Guide*.
    ///
    /// This setting is required for RDS Custom DB instances.
    custom_iam_instance_profile: ?[]const u8 = null,

    /// The mode of Database Insights to enable for the read replica.
    ///
    /// This setting isn't supported.
    database_insights_mode: ?DatabaseInsightsMode = null,

    /// The compute and memory capacity of the read replica, for example
    /// db.m4.large. Not all DB instance classes are available in all Amazon Web
    /// Services Regions, or for all database engines. For the full list of DB
    /// instance classes, and availability for your engine, see [DB Instance
    /// Class](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the *Amazon RDS User Guide*.
    ///
    /// Default: Inherits the value from the source DB instance.
    db_instance_class: ?[]const u8 = null,

    /// The DB instance identifier of the read replica. This identifier is the
    /// unique key that identifies a DB instance. This parameter is stored as a
    /// lowercase string.
    db_instance_identifier: []const u8,

    /// The name of the DB parameter group to associate with this read replica DB
    /// instance.
    ///
    /// For the Db2 DB engine, if your source DB instance uses the bring your own
    /// license (BYOL) model, then a custom parameter group must be associated with
    /// the replica. For a same Amazon Web Services Region replica, if you don't
    /// specify a custom parameter group, Amazon RDS associates the custom parameter
    /// group associated with the source DB instance. For a cross-Region replica,
    /// you must specify a custom parameter group. This custom parameter group must
    /// include your IBM Site ID and IBM Customer ID. For more information, see [IBM
    /// IDs for bring your own license (BYOL) for
    /// Db2](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/db2-licensing.html#db2-prereqs-ibm-info).
    ///
    /// For Single-AZ or Multi-AZ DB instance read replica instances, if you don't
    /// specify a value for `DBParameterGroupName`, then Amazon RDS uses the
    /// `DBParameterGroup` of the source DB instance for a same Region read replica,
    /// or the default `DBParameterGroup` for the specified DB engine for a
    /// cross-Region read replica.
    ///
    /// For Multi-AZ DB cluster same Region read replica instances, if you don't
    /// specify a value for `DBParameterGroupName`, then Amazon RDS uses the default
    /// `DBParameterGroup`.
    ///
    /// Specifying a parameter group for this operation is only supported for MySQL
    /// DB instances for cross-Region read replicas, for Multi-AZ DB cluster read
    /// replica instances, for Db2 DB instances, and for Oracle DB instances. It
    /// isn't supported for MySQL DB instances for same Region read replicas or for
    /// RDS Custom.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 letters, numbers, or hyphens.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    db_parameter_group_name: ?[]const u8 = null,

    /// A DB subnet group for the DB instance. The new DB instance is created in the
    /// VPC associated with the DB subnet group. If no DB subnet group is specified,
    /// then the new DB instance isn't created in a VPC.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the name of an existing DB subnet group.
    /// * The specified DB subnet group must be in the same Amazon Web Services
    ///   Region in which the operation is running.
    /// * All read replicas in one Amazon Web Services Region that are created from
    ///   the same source DB instance must either:
    ///
    /// * Specify DB subnet groups from the same VPC. All these read replicas are
    ///   created in the same VPC.
    /// * Not specify a DB subnet group. All these read replicas are created outside
    ///   of any VPC.
    ///
    /// Example: `mydbsubnetgroup`
    db_subnet_group_name: ?[]const u8 = null,

    /// Indicates whether the DB instance has a dedicated log volume (DLV) enabled.
    dedicated_log_volume: ?bool = null,

    /// Specifies whether to enable deletion protection for the DB instance. The
    /// database can't be deleted when deletion protection is enabled. By default,
    /// deletion protection isn't enabled. For more information, see [ Deleting a DB
    /// Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html).
    deletion_protection: ?bool = null,

    /// The Active Directory directory ID to create the DB instance in. Currently,
    /// only MySQL, Microsoft SQL Server, Oracle, and PostgreSQL DB instances can be
    /// created in an Active Directory Domain.
    ///
    /// For more information, see [ Kerberos
    /// Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/kerberos-authentication.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    domain: ?[]const u8 = null,

    /// The ARN for the Secrets Manager secret with the credentials for the user
    /// joining the domain.
    ///
    /// Example:
    /// `arn:aws:secretsmanager:region:account-number:secret:myselfmanagedADtestsecret-123456`
    domain_auth_secret_arn: ?[]const u8 = null,

    /// The IPv4 DNS IP addresses of your primary and secondary Active Directory
    /// domain controllers.
    ///
    /// Constraints:
    ///
    /// * Two IP addresses must be provided. If there isn't a secondary domain
    ///   controller, use the IP address of the primary domain controller for both
    ///   entries in the list.
    ///
    /// Example: `123.124.125.126,234.235.236.237`
    domain_dns_ips: ?[]const []const u8 = null,

    /// The fully qualified domain name (FQDN) of an Active Directory domain.
    ///
    /// Constraints:
    ///
    /// * Can't be longer than 64 characters.
    ///
    /// Example: `mymanagedADtest.mymanagedAD.mydomain`
    domain_fqdn: ?[]const u8 = null,

    /// The name of the IAM role to use when making API calls to the Directory
    /// Service.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    domain_iam_role_name: ?[]const u8 = null,

    /// The Active Directory organizational unit for your DB instance to join.
    ///
    /// Constraints:
    ///
    /// * Must be in the distinguished name format.
    /// * Can't be longer than 64 characters.
    ///
    /// Example:
    /// `OU=mymanagedADtestOU,DC=mymanagedADtest,DC=mymanagedAD,DC=mydomain`
    domain_ou: ?[]const u8 = null,

    /// The list of logs that the new DB instance is to export to CloudWatch Logs.
    /// The values in the list depend on the DB engine being used. For more
    /// information, see [Publishing Database Logs to Amazon CloudWatch Logs
    /// ](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    enable_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// Specifies whether to enable a customer-owned IP address (CoIP) for an RDS on
    /// Outposts read replica.
    ///
    /// A *CoIP* provides local or external connectivity to resources in your
    /// Outpost subnets through your on-premises network. For some use cases, a CoIP
    /// can provide lower latency for connections to the read replica from outside
    /// of its virtual private cloud (VPC) on your local network.
    ///
    /// For more information about RDS on Outposts, see [Working with Amazon RDS on
    /// Amazon Web Services
    /// Outposts](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the *Amazon RDS User Guide*.
    ///
    /// For more information about CoIPs, see [Customer-owned IP
    /// addresses](https://docs.aws.amazon.com/outposts/latest/userguide/routing.html#ip-addressing) in the *Amazon Web Services Outposts User Guide*.
    enable_customer_owned_ip: ?bool = null,

    /// Specifies whether to enable mapping of Amazon Web Services Identity and
    /// Access Management (IAM) accounts to database accounts. By default, mapping
    /// isn't enabled.
    ///
    /// For more information about IAM database authentication, see [ IAM Database
    /// Authentication for MySQL and
    /// PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    enable_iam_database_authentication: ?bool = null,

    /// Specifies whether to enable Performance Insights for the read replica.
    ///
    /// For more information, see [Using Amazon Performance
    /// Insights](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    enable_performance_insights: ?bool = null,

    /// The amount of Provisioned IOPS (input/output operations per second) to
    /// initially allocate for the DB instance.
    iops: ?i32 = null,

    /// The Amazon Web Services KMS key identifier for an encrypted read replica.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    ///
    /// If you create an encrypted read replica in the same Amazon Web Services
    /// Region as the source DB instance or Multi-AZ DB cluster, don't specify a
    /// value for this parameter. A read replica in the same Amazon Web Services
    /// Region is always encrypted with the same KMS key as the source DB instance
    /// or cluster.
    ///
    /// If you create an encrypted read replica in a different Amazon Web Services
    /// Region, then you must specify a KMS key identifier for the destination
    /// Amazon Web Services Region. KMS keys are specific to the Amazon Web Services
    /// Region that they are created in, and you can't use KMS keys from one Amazon
    /// Web Services Region in another Amazon Web Services Region.
    ///
    /// You can't create an encrypted read replica from an unencrypted DB instance
    /// or Multi-AZ DB cluster.
    ///
    /// This setting doesn't apply to RDS Custom, which uses the same KMS key as the
    /// primary replica.
    kms_key_id: ?[]const u8 = null,

    /// The upper limit in gibibytes (GiB) to which Amazon RDS can automatically
    /// scale the storage of the DB instance.
    ///
    /// For more information about this setting, including limitations that apply to
    /// it, see [ Managing capacity automatically with Amazon RDS storage
    /// autoscaling](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PIOPS.StorageTypes.html#USER_PIOPS.Autoscaling) in the *Amazon RDS User Guide*.
    max_allocated_storage: ?i32 = null,

    /// The interval, in seconds, between points when Enhanced Monitoring metrics
    /// are collected for the read replica. To disable collection of Enhanced
    /// Monitoring metrics, specify `0`. The default is `0`.
    ///
    /// If `MonitoringRoleArn` is specified, then you must set `MonitoringInterval`
    /// to a value other than `0`.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Valid Values: `0, 1, 5, 10, 15, 30, 60`
    ///
    /// Default: `0`
    monitoring_interval: ?i32 = null,

    /// The ARN for the IAM role that permits RDS to send enhanced monitoring
    /// metrics to Amazon CloudWatch Logs. For example,
    /// `arn:aws:iam:123456789012:role/emaccess`. For information on creating a
    /// monitoring role, go to [To create an IAM role for Amazon RDS Enhanced
    /// Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.html#USER_Monitoring.OS.IAMRole) in the *Amazon RDS User Guide*.
    ///
    /// If `MonitoringInterval` is set to a value other than 0, then you must supply
    /// a `MonitoringRoleArn` value.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    monitoring_role_arn: ?[]const u8 = null,

    /// Specifies whether the read replica is in a Multi-AZ deployment.
    ///
    /// You can create a read replica as a Multi-AZ DB instance. RDS creates a
    /// standby of your replica in another Availability Zone for failover support
    /// for the replica. Creating your read replica as a Multi-AZ DB instance is
    /// independent of whether the source is a Multi-AZ DB instance or a Multi-AZ DB
    /// cluster.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    multi_az: ?bool = null,

    /// The network type of the DB instance.
    ///
    /// Valid Values:
    ///
    /// * `IPV4`
    /// * `DUAL`
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for read
    /// replica. A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4
    /// and the IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [ Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon RDS User Guide.*
    network_type: ?[]const u8 = null,

    /// The option group to associate the DB instance with. If not specified, RDS
    /// uses the option group associated with the source DB instance or cluster.
    ///
    /// For SQL Server, you must use the option group associated with the source.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    option_group_name: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier for encryption of Performance
    /// Insights data.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    ///
    /// If you do not specify a value for `PerformanceInsightsKMSKeyId`, then Amazon
    /// RDS uses your default KMS key. There is a default KMS key for your Amazon
    /// Web Services account. Your Amazon Web Services account has a different
    /// default KMS key for each Amazon Web Services Region.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    performance_insights_kms_key_id: ?[]const u8 = null,

    /// The number of days to retain Performance Insights data.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
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
    /// returns an error.
    performance_insights_retention_period: ?i32 = null,

    /// The port number that the DB instance uses for connections.
    ///
    /// Valid Values: `1150-65535`
    ///
    /// Default: Inherits the value from the source DB instance.
    port: ?i32 = null,

    /// When you are creating a read replica from one Amazon Web Services GovCloud
    /// (US) Region to another or from one China Amazon Web Services Region to
    /// another, the URL that contains a Signature Version 4 signed request for the
    /// `CreateDBInstanceReadReplica` API operation in the source Amazon Web
    /// Services Region that contains the source DB instance.
    ///
    /// This setting applies only to Amazon Web Services GovCloud (US) Regions and
    /// China Amazon Web Services Regions. It's ignored in other Amazon Web Services
    /// Regions.
    ///
    /// This setting applies only when replicating from a source DB *instance*.
    /// Source DB clusters aren't supported in Amazon Web Services GovCloud (US)
    /// Regions and China Amazon Web Services Regions.
    ///
    /// You must specify this parameter when you create an encrypted read replica
    /// from another Amazon Web Services Region by using the Amazon RDS API. Don't
    /// specify `PreSignedUrl` when you are creating an encrypted read replica in
    /// the same Amazon Web Services Region.
    ///
    /// The presigned URL must be a valid request for the
    /// `CreateDBInstanceReadReplica` API operation that can run in the source
    /// Amazon Web Services Region that contains the encrypted source DB instance.
    /// The presigned URL request must contain the following parameter values:
    ///
    /// * `DestinationRegion` - The Amazon Web Services Region that the encrypted
    ///   read replica is created in. This Amazon Web Services Region is the same
    ///   one where the `CreateDBInstanceReadReplica` operation is called that
    ///   contains this presigned URL.
    ///
    /// For example, if you create an encrypted DB instance in the us-west-1 Amazon
    /// Web Services Region, from a source DB instance in the us-east-2 Amazon Web
    /// Services Region, then you call the `CreateDBInstanceReadReplica` operation
    /// in the us-east-1 Amazon Web Services Region and provide a presigned URL that
    /// contains a call to the `CreateDBInstanceReadReplica` operation in the
    /// us-west-2 Amazon Web Services Region. For this example, the
    /// `DestinationRegion` in the presigned URL must be set to the us-east-1 Amazon
    /// Web Services Region.
    /// * `KmsKeyId` - The KMS key identifier for the key to use to encrypt the read
    ///   replica in the destination Amazon Web Services Region. This is the same
    ///   identifier for both the `CreateDBInstanceReadReplica` operation that is
    ///   called in the destination Amazon Web Services Region, and the operation
    ///   contained in the presigned URL.
    /// * `SourceDBInstanceIdentifier` - The DB instance identifier for the
    ///   encrypted DB instance to be replicated. This identifier must be in the
    ///   Amazon Resource Name (ARN) format for the source Amazon Web Services
    ///   Region. For example, if you are creating an encrypted read replica from a
    ///   DB instance in the us-west-2 Amazon Web Services Region, then your
    ///   `SourceDBInstanceIdentifier` looks like the following example:
    ///   `arn:aws:rds:us-west-2:123456789012:instance:mysql-instance1-20161115`.
    ///
    /// To learn how to generate a Signature Version 4 signed request, see
    /// [Authenticating Requests: Using Query Parameters (Amazon Web Services
    /// Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html) and [Signature Version 4 Signing Process](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    ///
    /// If you are using an Amazon Web Services SDK tool or the CLI, you can specify
    /// `SourceRegion` (or `--source-region` for the CLI) instead of specifying
    /// `PreSignedUrl` manually. Specifying `SourceRegion` autogenerates a presigned
    /// URL that is a valid request for the operation that can run in the source
    /// Amazon Web Services Region.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    pre_signed_url: ?[]const u8 = null,

    /// The number of CPU cores and the number of threads per core for the DB
    /// instance class of the DB instance.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    processor_features: ?[]const ProcessorFeature = null,

    /// Specifies whether the DB instance is publicly accessible.
    ///
    /// When the DB cluster is publicly accessible, its Domain Name System (DNS)
    /// endpoint resolves to the private IP address from within the DB cluster's
    /// virtual private cloud (VPC). It resolves to the public IP address from
    /// outside of the DB cluster's VPC. Access to the DB cluster is ultimately
    /// controlled by the security group it uses. That public access isn't permitted
    /// if the security group assigned to the DB cluster doesn't permit it.
    ///
    /// When the DB instance isn't publicly accessible, it is an internal DB
    /// instance with a DNS name that resolves to a private IP address.
    ///
    /// For more information, see CreateDBInstance.
    publicly_accessible: ?bool = null,

    /// The open mode of the replica database.
    ///
    /// This parameter is only supported for Db2 DB instances and Oracle DB
    /// instances.
    ///
    /// **Db2**
    ///
    /// Standby DB replicas are included in Db2 Advanced Edition (AE) and Db2
    /// Standard Edition (SE). The main use case for standby replicas is
    /// cross-Region disaster recovery. Because it doesn't accept user connections,
    /// a standby replica can't serve a read-only workload.
    ///
    /// You can create a combination of standby and read-only DB replicas for the
    /// same primary DB instance. For more information, see [Working with replicas
    /// for Amazon RDS for
    /// Db2](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/db2-replication.html) in the *Amazon RDS User Guide*.
    ///
    /// To create standby DB replicas for RDS for Db2, set this parameter to
    /// `mounted`.
    ///
    /// **Oracle**
    ///
    /// Mounted DB replicas are included in Oracle Database Enterprise Edition. The
    /// main use case for mounted replicas is cross-Region disaster recovery. The
    /// primary database doesn't use Active Data Guard to transmit information to
    /// the mounted replica. Because it doesn't accept user connections, a mounted
    /// replica can't serve a read-only workload.
    ///
    /// You can create a combination of mounted and read-only DB replicas for the
    /// same primary DB instance. For more information, see [Working with read
    /// replicas for Amazon RDS for
    /// Oracle](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-read-replicas.html) in the *Amazon RDS User Guide*.
    ///
    /// For RDS Custom, you must specify this parameter and set it to `mounted`. The
    /// value won't be set by default. After replica creation, you can manage the
    /// open mode manually.
    replica_mode: ?ReplicaMode = null,

    /// The identifier of the Multi-AZ DB cluster that will act as the source for
    /// the read replica. Each DB cluster can have up to 15 read replicas.
    ///
    /// Constraints:
    ///
    /// * Must be the identifier of an existing Multi-AZ DB cluster.
    /// * Can't be specified if the `SourceDBInstanceIdentifier` parameter is also
    ///   specified.
    /// * The specified DB cluster must have automatic backups enabled, that is, its
    ///   backup retention period must be greater than 0.
    /// * The source DB cluster must be in the same Amazon Web Services Region as
    ///   the read replica. Cross-Region replication isn't supported.
    source_db_cluster_identifier: ?[]const u8 = null,

    /// The identifier of the DB instance that will act as the source for the read
    /// replica. Each DB instance can have up to 15 read replicas, except for the
    /// following engines:
    ///
    /// * Db2 - Can have up to three replicas.
    /// * Oracle - Can have up to five read replicas.
    /// * SQL Server - Can have up to five read replicas.
    ///
    /// Constraints:
    ///
    /// * Must be the identifier of an existing Db2, MariaDB, MySQL, Oracle,
    ///   PostgreSQL, or SQL Server DB instance.
    /// * Can't be specified if the `SourceDBClusterIdentifier` parameter is also
    ///   specified.
    /// * For the limitations of Oracle read replicas, see [Version and licensing
    ///   considerations for RDS for Oracle
    ///   replicas](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-read-replicas.limitations.html#oracle-read-replicas.limitations.versions-and-licenses) in the *Amazon RDS User Guide*.
    /// * For the limitations of SQL Server read replicas, see [Read replica
    ///   limitations with SQL
    ///   Server](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/SQLServer.ReadReplicas.html#SQLServer.ReadReplicas.Limitations) in the *Amazon RDS User Guide*.
    /// * The specified DB instance must have automatic backups enabled, that is,
    ///   its backup retention period must be greater than 0.
    /// * If the source DB instance is in the same Amazon Web Services Region as the
    ///   read replica, specify a valid DB instance identifier.
    /// * If the source DB instance is in a different Amazon Web Services Region
    ///   from the read replica, specify a valid DB instance ARN. For more
    ///   information, see [Constructing an ARN for Amazon
    ///   RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing) in the *Amazon RDS User Guide*. This doesn't apply to SQL Server or RDS Custom, which don't support cross-Region replicas.
    source_db_instance_identifier: ?[]const u8 = null,

    /// Specifies the storage throughput value for the read replica.
    ///
    /// This setting doesn't apply to RDS Custom or Amazon Aurora DB instances.
    storage_throughput: ?i32 = null,

    /// The storage type to associate with the read replica.
    ///
    /// If you specify `io1`, `io2`, or `gp3`, you must also include a value for the
    /// `Iops` parameter.
    ///
    /// Valid Values: `gp2 | gp3 | io1 | io2 | standard`
    ///
    /// Default: `io1` if the `Iops` parameter is specified. Otherwise, `gp3`.
    storage_type: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    /// Tags to assign to resources associated with the DB instance.
    ///
    /// Valid Values:
    ///
    /// * `auto-backup` - The DB instance's automated backup.
    tag_specifications: ?[]const TagSpecification = null,

    /// Whether to upgrade the storage file system configuration on the read
    /// replica. This option migrates the read replica from the old storage file
    /// system layout to the preferred layout.
    upgrade_storage_config: ?bool = null,

    /// Specifies whether the DB instance class of the DB instance uses its default
    /// processor features.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    use_default_processor_features: ?bool = null,

    /// A list of Amazon EC2 VPC security groups to associate with the read replica.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Default: The default EC2 VPC security group for the DB subnet group's VPC.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const CreateDBInstanceReadReplicaOutput = struct {
    db_instance: ?DBInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBInstanceReadReplicaInput, options: CallOptions) !CreateDBInstanceReadReplicaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBInstanceReadReplicaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDBInstanceReadReplica&Version=2014-10-31");
    if (input.additional_storage_volumes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.allocated_storage) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.AllocatedStorage=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.iops) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.IOPS=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.max_allocated_storage) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.MaxAllocatedStorage=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.storage_throughput) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.StorageThroughput=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.storage_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.StorageType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.VolumeName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.volume_name);
            }
        }
    }
    if (input.allocated_storage) |v| {
        try body_buf.appendSlice(allocator, "&AllocatedStorage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.auto_minor_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AutoMinorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.backup_target) |v| {
        try body_buf.appendSlice(allocator, "&BackupTarget=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ca_certificate_identifier) |v| {
        try body_buf.appendSlice(allocator, "&CACertificateIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.custom_iam_instance_profile) |v| {
        try body_buf.appendSlice(allocator, "&CustomIamInstanceProfile=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.database_insights_mode) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseInsightsMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.db_instance_class) |v| {
        try body_buf.appendSlice(allocator, "&DBInstanceClass=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    if (input.db_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_subnet_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBSubnetGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dedicated_log_volume) |v| {
        try body_buf.appendSlice(allocator, "&DedicatedLogVolume=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(allocator, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.domain) |v| {
        try body_buf.appendSlice(allocator, "&Domain=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.domain_auth_secret_arn) |v| {
        try body_buf.appendSlice(allocator, "&DomainAuthSecretArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.domain_dns_ips) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DomainDnsIps.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.domain_fqdn) |v| {
        try body_buf.appendSlice(allocator, "&DomainFqdn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.domain_iam_role_name) |v| {
        try body_buf.appendSlice(allocator, "&DomainIAMRoleName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.domain_ou) |v| {
        try body_buf.appendSlice(allocator, "&DomainOu=");
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
    if (input.enable_customer_owned_ip) |v| {
        try body_buf.appendSlice(allocator, "&EnableCustomerOwnedIp=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_iam_database_authentication) |v| {
        try body_buf.appendSlice(allocator, "&EnableIAMDatabaseAuthentication=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_performance_insights) |v| {
        try body_buf.appendSlice(allocator, "&EnablePerformanceInsights=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.iops) |v| {
        try body_buf.appendSlice(allocator, "&Iops=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_allocated_storage) |v| {
        try body_buf.appendSlice(allocator, "&MaxAllocatedStorage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.monitoring_interval) |v| {
        try body_buf.appendSlice(allocator, "&MonitoringInterval=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.monitoring_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&MonitoringRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.multi_az) |v| {
        try body_buf.appendSlice(allocator, "&MultiAZ=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
    if (input.pre_signed_url) |v| {
        try body_buf.appendSlice(allocator, "&PreSignedUrl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.processor_features) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProcessorFeatures.ProcessorFeature.{d}.Name=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProcessorFeatures.ProcessorFeature.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.publicly_accessible) |v| {
        try body_buf.appendSlice(allocator, "&PubliclyAccessible=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.replica_mode) |v| {
        try body_buf.appendSlice(allocator, "&ReplicaMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.source_db_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SourceDBClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_db_instance_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SourceDBInstanceIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.storage_throughput) |v| {
        try body_buf.appendSlice(allocator, "&StorageThroughput=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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
    if (input.upgrade_storage_config) |v| {
        try body_buf.appendSlice(allocator, "&UpgradeStorageConfig=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.use_default_processor_features) |v| {
        try body_buf.appendSlice(allocator, "&UseDefaultProcessorFeatures=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBInstanceReadReplicaOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBInstanceReadReplicaResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBInstanceReadReplicaOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBInstance")) {
                    result.db_instance = try serde.deserializeDBInstance(allocator, &reader);
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
