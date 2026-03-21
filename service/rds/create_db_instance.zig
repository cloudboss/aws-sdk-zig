const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AdditionalStorageVolume = @import("additional_storage_volume.zig").AdditionalStorageVolume;
const DatabaseInsightsMode = @import("database_insights_mode.zig").DatabaseInsightsMode;
const MasterUserAuthenticationType = @import("master_user_authentication_type.zig").MasterUserAuthenticationType;
const ProcessorFeature = @import("processor_feature.zig").ProcessorFeature;
const Tag = @import("tag.zig").Tag;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const DBInstance = @import("db_instance.zig").DBInstance;
const serde = @import("serde.zig");

pub const CreateDBInstanceInput = struct {
    /// A list of additional storage volumes to create for the DB instance. You can
    /// create up to three additional storage volumes using the names `rdsdbdata2`,
    /// `rdsdbdata3`, and `rdsdbdata4`. Additional storage volumes are supported for
    /// RDS for Oracle and RDS for SQL Server DB instances only.
    additional_storage_volumes: ?[]const AdditionalStorageVolume = null,

    /// The amount of storage in gibibytes (GiB) to allocate for the DB instance.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. Aurora cluster
    /// volumes automatically grow as the amount of data in your database increases,
    /// though you are only charged for the space that you use in an Aurora cluster
    /// volume.
    ///
    /// **Amazon RDS Custom**
    ///
    /// Constraints to the amount of storage for each storage type are the
    /// following:
    ///
    /// * General Purpose (SSD) storage (gp2, gp3): Must be an integer from 40 to
    ///   65536 for RDS Custom for Oracle, 16384 for RDS Custom for SQL Server.
    /// * Provisioned IOPS storage (io1, io2): Must be an integer from 40 to 65536
    ///   for RDS Custom for Oracle, 16384 for RDS Custom for SQL Server.
    ///
    /// **RDS for Db2**
    ///
    /// Constraints to the amount of storage for each storage type are the
    /// following:
    ///
    /// * General Purpose (SSD) storage (gp3): Must be an integer from 20 to 65536.
    /// * Provisioned IOPS storage (io1, io2): Must be an integer from 100 to 65536.
    ///
    /// **RDS for MariaDB**
    ///
    /// Constraints to the amount of storage for each storage type are the
    /// following:
    ///
    /// * General Purpose (SSD) storage (gp2, gp3): Must be an integer from 20 to
    ///   65536.
    /// * Provisioned IOPS storage (io1, io2): Must be an integer from 100 to 65536.
    /// * Magnetic storage (standard): Must be an integer from 5 to 3072.
    ///
    /// **RDS for MySQL**
    ///
    /// Constraints to the amount of storage for each storage type are the
    /// following:
    ///
    /// * General Purpose (SSD) storage (gp2, gp3): Must be an integer from 20 to
    ///   65536.
    /// * Provisioned IOPS storage (io1, io2): Must be an integer from 100 to 65536.
    /// * Magnetic storage (standard): Must be an integer from 5 to 3072.
    ///
    /// **RDS for Oracle**
    ///
    /// Constraints to the amount of storage for each storage type are the
    /// following:
    ///
    /// * General Purpose (SSD) storage (gp2, gp3): Must be an integer from 20 to
    ///   65536.
    /// * Provisioned IOPS storage (io1, io2): Must be an integer from 100 to 65536.
    /// * Magnetic storage (standard): Must be an integer from 10 to 3072.
    ///
    /// **RDS for PostgreSQL**
    ///
    /// Constraints to the amount of storage for each storage type are the
    /// following:
    ///
    /// * General Purpose (SSD) storage (gp2, gp3): Must be an integer from 20 to
    ///   65536.
    /// * Provisioned IOPS storage (io1, io2): Must be an integer from 100 to 65536.
    /// * Magnetic storage (standard): Must be an integer from 5 to 3072.
    ///
    /// **RDS for SQL Server**
    ///
    /// Constraints to the amount of storage for each storage type are the
    /// following:
    ///
    /// * General Purpose (SSD) storage (gp2, gp3):
    ///
    /// * Enterprise and Standard editions: Must be an integer from 20 to 16384.
    /// * Web and Express editions: Must be an integer from 20 to 16384.
    ///
    /// * Provisioned IOPS storage (io1, io2):
    ///
    /// * Enterprise and Standard editions: Must be an integer from 100 to 16384.
    /// * Web and Express editions: Must be an integer from 100 to 16384.
    ///
    /// * Magnetic storage (standard):
    ///
    /// * Enterprise and Standard editions: Must be an integer from 20 to 1024.
    /// * Web and Express editions: Must be an integer from 20 to 1024.
    allocated_storage: ?i32 = null,

    /// Specifies whether minor engine upgrades are applied automatically to the DB
    /// instance during the maintenance window. By default, minor engine upgrades
    /// are applied automatically.
    ///
    /// If you create an RDS Custom DB instance, you must set
    /// `AutoMinorVersionUpgrade` to `false`.
    ///
    /// For more information about automatic minor version upgrades, see
    /// [Automatically upgrading the minor engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades).
    auto_minor_version_upgrade: ?bool = null,

    /// The Availability Zone (AZ) where the database will be created. For
    /// information on Amazon Web Services Regions and Availability Zones, see
    /// [Regions and Availability
    /// Zones](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html).
    ///
    /// For Amazon Aurora, each Aurora DB cluster hosts copies of its storage in
    /// three separate Availability Zones. Specify one of these Availability Zones.
    /// Aurora automatically chooses an appropriate Availability Zone if you don't
    /// specify one.
    ///
    /// Default: A random, system-chosen Availability Zone in the endpoint's Amazon
    /// Web Services Region.
    ///
    /// Constraints:
    ///
    /// * The `AvailabilityZone` parameter can't be specified if the DB instance is
    ///   a Multi-AZ deployment.
    /// * The specified Availability Zone must be in the same Amazon Web Services
    ///   Region as the current endpoint.
    ///
    /// Example: `us-east-1d`
    availability_zone: ?[]const u8 = null,

    /// The number of days for which automated backups are retained. Setting this
    /// parameter to a positive number enables backups. Setting this parameter to
    /// `0` disables automated backups.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The retention
    /// period for automated backups is managed by the DB cluster.
    ///
    /// Default: `1`
    ///
    /// Constraints:
    ///
    /// * Must be a value from 0 to 35.
    /// * Can't be set to 0 if the DB instance is a source to read replicas.
    /// * Can't be set to 0 for an RDS Custom for Oracle DB instance.
    backup_retention_period: ?i32 = null,

    /// The location for storing automated backups and manual snapshots.
    ///
    /// Valid Values:
    ///
    /// * `local` (Dedicated Local Zone)
    /// * `outposts` (Amazon Web Services Outposts)
    /// * `region` (Amazon Web Services Region)
    ///
    /// Default: `region`
    ///
    /// For more information, see [Working with Amazon RDS on Amazon Web Services
    /// Outposts](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the *Amazon RDS User Guide*.
    backup_target: ?[]const u8 = null,

    /// The CA certificate identifier to use for the DB instance's server
    /// certificate.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// For more information, see [Using SSL/TLS to encrypt a connection to a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
    ca_certificate_identifier: ?[]const u8 = null,

    /// For supported engines, the character set (`CharacterSet`) to associate the
    /// DB instance with.
    ///
    /// This setting doesn't apply to the following DB instances:
    ///
    /// * Amazon Aurora - The character set is managed by the DB cluster. For more
    ///   information, see `CreateDBCluster`.
    /// * RDS Custom - However, if you need to change the character set, you can
    ///   change it on the database itself.
    character_set_name: ?[]const u8 = null,

    /// Specifies whether to copy tags from the DB instance to snapshots of the DB
    /// instance. By default, tags are not copied.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. Copying tags to
    /// snapshots is managed by the DB cluster. Setting this value for an Aurora DB
    /// instance has no effect on the DB cluster setting.
    copy_tags_to_snapshot: ?bool = null,

    /// The instance profile associated with the underlying Amazon EC2 instance of
    /// an RDS Custom DB instance.
    ///
    /// This setting is required for RDS Custom.
    ///
    /// Constraints:
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
    custom_iam_instance_profile: ?[]const u8 = null,

    /// The mode of Database Insights to enable for the DB instance.
    ///
    /// Aurora DB instances inherit this value from the DB cluster, so you can't
    /// change this value.
    database_insights_mode: ?DatabaseInsightsMode = null,

    /// The identifier of the DB cluster that this DB instance will belong to.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    db_cluster_identifier: ?[]const u8 = null,

    /// The compute and memory capacity of the DB instance, for example
    /// `db.m5.large`. Not all DB instance classes are available in all Amazon Web
    /// Services Regions, or for all database engines. For the full list of DB
    /// instance classes, and availability for your engine, see [DB instance
    /// classes](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the *Amazon RDS User Guide* or [Aurora DB instance classes](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html) in the *Amazon Aurora User Guide*.
    db_instance_class: []const u8,

    /// The identifier for this DB instance. This parameter is stored as a lowercase
    /// string.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `mydbinstance`
    db_instance_identifier: []const u8,

    /// The meaning of this parameter differs according to the database engine you
    /// use.
    ///
    /// **Amazon Aurora MySQL**
    ///
    /// The name of the database to create when the primary DB instance of the
    /// Aurora MySQL DB cluster is created. If this parameter isn't specified for an
    /// Aurora MySQL DB cluster, no database is created in the DB cluster.
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 64 alphanumeric characters.
    /// * Must begin with a letter. Subsequent characters can be letters,
    ///   underscores, or digits (0-9).
    /// * Can't be a word reserved by the database engine.
    ///
    /// **Amazon Aurora PostgreSQL**
    ///
    /// The name of the database to create when the primary DB instance of the
    /// Aurora PostgreSQL DB cluster is created. A database named `postgres` is
    /// always created. If this parameter is specified, an additional database with
    /// this name is created.
    ///
    /// Constraints:
    ///
    /// * It must contain 1 to 63 alphanumeric characters.
    /// * Must begin with a letter. Subsequent characters can be letters,
    ///   underscores, or digits (0 to 9).
    /// * Can't be a word reserved by the database engine.
    ///
    /// **Amazon RDS Custom for Oracle**
    ///
    /// The Oracle System ID (SID) of the created RDS Custom DB instance. If you
    /// don't specify a value, the default value is `ORCL` for non-CDBs and `RDSCDB`
    /// for CDBs.
    ///
    /// Default: `ORCL`
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 8 alphanumeric characters.
    /// * Must contain a letter.
    /// * Can't be a word reserved by the database engine.
    ///
    /// **Amazon RDS Custom for SQL Server**
    ///
    /// Not applicable. Must be null.
    ///
    /// **RDS for Db2**
    ///
    /// The name of the database to create when the DB instance is created. If this
    /// parameter isn't specified, no database is created in the DB instance. In
    /// some cases, we recommend that you don't add a database name. For more
    /// information, see [Additional
    /// considerations](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/db2-db-instance-prereqs.html#db2-prereqs-additional-considerations) in the *Amazon RDS User Guide*.
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 64 letters or numbers.
    /// * Must begin with a letter. Subsequent characters can be letters,
    ///   underscores, or digits (0-9).
    /// * Can't be a word reserved by the specified database engine.
    ///
    /// **RDS for MariaDB**
    ///
    /// The name of the database to create when the DB instance is created. If this
    /// parameter isn't specified, no database is created in the DB instance.
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 64 letters or numbers.
    /// * Must begin with a letter. Subsequent characters can be letters,
    ///   underscores, or digits (0-9).
    /// * Can't be a word reserved by the specified database engine.
    ///
    /// **RDS for MySQL**
    ///
    /// The name of the database to create when the DB instance is created. If this
    /// parameter isn't specified, no database is created in the DB instance.
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 64 letters or numbers.
    /// * Must begin with a letter. Subsequent characters can be letters,
    ///   underscores, or digits (0-9).
    /// * Can't be a word reserved by the specified database engine.
    ///
    /// **RDS for Oracle**
    ///
    /// The Oracle System ID (SID) of the created DB instance. If you don't specify
    /// a value, the default value is `ORCL`. You can't specify the string `null`,
    /// or any other reserved word, for `DBName`.
    ///
    /// Default: `ORCL`
    ///
    /// Constraints:
    ///
    /// * Can't be longer than 8 characters.
    ///
    /// **RDS for PostgreSQL**
    ///
    /// The name of the database to create when the DB instance is created. A
    /// database named `postgres` is always created. If this parameter is specified,
    /// an additional database with this name is created.
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 63 letters, numbers, or underscores.
    /// * Must begin with a letter. Subsequent characters can be letters,
    ///   underscores, or digits (0-9).
    /// * Can't be a word reserved by the specified database engine.
    ///
    /// **RDS for SQL Server**
    ///
    /// Not applicable. Must be null.
    db_name: ?[]const u8 = null,

    /// The name of the DB parameter group to associate with this DB instance. If
    /// you don't specify a value, then Amazon RDS uses the default DB parameter
    /// group for the specified DB engine and version.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 letters, numbers, or hyphens.
    /// * The first character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    db_parameter_group_name: ?[]const u8 = null,

    /// A list of DB security groups to associate with this DB instance.
    ///
    /// This setting applies to the legacy EC2-Classic platform, which is no longer
    /// used to create new DB instances. Use the `VpcSecurityGroupIds` setting
    /// instead.
    db_security_groups: ?[]const []const u8 = null,

    /// A DB subnet group to associate with this DB instance.
    ///
    /// Constraints:
    ///
    /// * Must match the name of an existing DB subnet group.
    ///
    /// Example: `mydbsubnetgroup`
    db_subnet_group_name: ?[]const u8 = null,

    /// The Oracle system identifier (SID), which is the name of the Oracle database
    /// instance that manages your database files. In this context, the term "Oracle
    /// database instance" refers exclusively to the system global area (SGA) and
    /// Oracle background processes. If you don't specify a SID, the value defaults
    /// to `RDSCDB`. The Oracle SID is also the name of your CDB.
    db_system_id: ?[]const u8 = null,

    /// Indicates whether the DB instance has a dedicated log volume (DLV) enabled.
    dedicated_log_volume: ?bool = null,

    /// Specifies whether the DB instance has deletion protection enabled. The
    /// database can't be deleted when deletion protection is enabled. By default,
    /// deletion protection isn't enabled. For more information, see [ Deleting a DB
    /// Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html).
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. You can enable or
    /// disable deletion protection for the DB cluster. For more information, see
    /// `CreateDBCluster`. DB instances in a DB cluster can be deleted even when
    /// deletion protection is enabled for the DB cluster.
    deletion_protection: ?bool = null,

    /// The Active Directory directory ID to create the DB instance in. Currently,
    /// you can create only Db2, MySQL, Microsoft SQL Server, Oracle, and PostgreSQL
    /// DB instances in an Active Directory Domain.
    ///
    /// For more information, see [ Kerberos
    /// Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/kerberos-authentication.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to the following DB instances:
    ///
    /// * Amazon Aurora (The domain is managed by the DB cluster.)
    /// * RDS Custom
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
    /// This setting doesn't apply to the following DB instances:
    ///
    /// * Amazon Aurora (The domain is managed by the DB cluster.)
    /// * RDS Custom
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

    /// The list of log types to enable for exporting to CloudWatch Logs. For more
    /// information, see [ Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to the following DB instances:
    ///
    /// * Amazon Aurora (CloudWatch Logs exports are managed by the DB cluster.)
    /// * RDS Custom
    ///
    /// The following values are valid for each DB engine:
    ///
    /// * RDS for Db2 - `diag.log | notify.log | iam-db-auth-error`
    /// * RDS for MariaDB - `audit | error | general | slowquery |
    ///   iam-db-auth-error`
    /// * RDS for Microsoft SQL Server - `agent | error`
    /// * RDS for MySQL - `audit | error | general | slowquery | iam-db-auth-error`
    /// * RDS for Oracle - `alert | audit | listener | trace | oemagent`
    /// * RDS for PostgreSQL - `postgresql | upgrade | iam-db-auth-error`
    enable_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// Specifies whether to enable a customer-owned IP address (CoIP) for an RDS on
    /// Outposts DB instance.
    ///
    /// A *CoIP* provides local or external connectivity to resources in your
    /// Outpost subnets through your on-premises network. For some use cases, a CoIP
    /// can provide lower latency for connections to the DB instance from outside of
    /// its virtual private cloud (VPC) on your local network.
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
    /// For more information, see [ IAM Database Authentication for MySQL and
    /// PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to the following DB instances:
    ///
    /// * Amazon Aurora (Mapping Amazon Web Services IAM accounts to database
    ///   accounts is managed by the DB cluster.)
    /// * RDS Custom
    enable_iam_database_authentication: ?bool = null,

    /// Specifies whether to enable Performance Insights for the DB instance. For
    /// more information, see [Using Amazon Performance
    /// Insights](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    enable_performance_insights: ?bool = null,

    /// The database engine to use for this DB instance.
    ///
    /// Not every database engine is available in every Amazon Web Services Region.
    ///
    /// Valid Values:
    ///
    /// * `aurora-mysql` (for Aurora MySQL DB instances)
    /// * `aurora-postgresql` (for Aurora PostgreSQL DB instances)
    /// * `custom-oracle-ee` (for RDS Custom for Oracle DB instances)
    /// * `custom-oracle-ee-cdb` (for RDS Custom for Oracle DB instances)
    /// * `custom-oracle-se2` (for RDS Custom for Oracle DB instances)
    /// * `custom-oracle-se2-cdb` (for RDS Custom for Oracle DB instances)
    /// * `custom-sqlserver-ee` (for RDS Custom for SQL Server DB instances)
    /// * `custom-sqlserver-se` (for RDS Custom for SQL Server DB instances)
    /// * `custom-sqlserver-web` (for RDS Custom for SQL Server DB instances)
    /// * `custom-sqlserver-dev` (for RDS Custom for SQL Server DB instances)
    /// * `db2-ae`
    /// * `db2-se`
    /// * `mariadb`
    /// * `mysql`
    /// * `oracle-ee`
    /// * `oracle-ee-cdb`
    /// * `oracle-se2`
    /// * `oracle-se2-cdb`
    /// * `postgres`
    /// * `sqlserver-dev-ee`
    /// * `sqlserver-ee`
    /// * `sqlserver-se`
    /// * `sqlserver-ex`
    /// * `sqlserver-web`
    engine: []const u8,

    /// The life cycle type for this DB instance.
    ///
    /// By default, this value is set to `open-source-rds-extended-support`, which
    /// enrolls your DB instance into Amazon RDS Extended Support. At the end of
    /// standard support, you can avoid charges for Extended Support by setting the
    /// value to `open-source-rds-extended-support-disabled`. In this case, creating
    /// the DB instance will fail if the DB major version is past its end of
    /// standard support date.
    ///
    /// This setting applies only to RDS for MySQL and RDS for PostgreSQL. For
    /// Amazon Aurora DB instances, the life cycle type is managed by the DB
    /// cluster.
    ///
    /// You can use this setting to enroll your DB instance into Amazon RDS Extended
    /// Support. With RDS Extended Support, you can run the selected major engine
    /// version on your DB instance past the end of standard support for that engine
    /// version. For more information, see [Amazon RDS Extended Support with Amazon
    /// RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/extended-support.html) in the *Amazon RDS User Guide*.
    ///
    /// Valid Values: `open-source-rds-extended-support |
    /// open-source-rds-extended-support-disabled`
    ///
    /// Default: `open-source-rds-extended-support`
    engine_lifecycle_support: ?[]const u8 = null,

    /// The version number of the database engine to use.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The version number
    /// of the database engine the DB instance uses is managed by the DB cluster.
    ///
    /// For a list of valid engine versions, use the `DescribeDBEngineVersions`
    /// operation.
    ///
    /// The following are the database engines and links to information about the
    /// major and minor versions that are available with Amazon RDS. Not every
    /// database engine is available for every Amazon Web Services Region.
    ///
    /// **Amazon RDS Custom for Oracle**
    ///
    /// A custom engine version (CEV) that you have previously created. This setting
    /// is required for RDS Custom for Oracle. The CEV name has the following
    /// format: 19.*customized_string*. A valid CEV name is `19.my_cev1`. For more
    /// information, see [ Creating an RDS Custom for Oracle DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-creating.html#custom-creating.create) in the *Amazon RDS User Guide*.
    ///
    /// **Amazon RDS Custom for SQL Server**
    ///
    /// See [RDS Custom for SQL Server general
    /// requirements](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-reqs-limits-MS.html) in the *Amazon RDS User Guide*.
    ///
    /// **RDS for Db2**
    ///
    /// For information, see [Db2 on Amazon RDS
    /// versions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Db2.html#Db2.Concepts.VersionMgmt) in the *Amazon RDS User Guide*.
    ///
    /// **RDS for MariaDB**
    ///
    /// For information, see [MariaDB on Amazon RDS
    /// versions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MariaDB.html#MariaDB.Concepts.VersionMgmt) in the *Amazon RDS User Guide*.
    ///
    /// **RDS for Microsoft SQL Server**
    ///
    /// For information, see [Microsoft SQL Server versions on Amazon
    /// RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.VersionSupport) in the *Amazon RDS User Guide*.
    ///
    /// **RDS for MySQL**
    ///
    /// For information, see [MySQL on Amazon RDS
    /// versions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt) in the *Amazon RDS User Guide*.
    ///
    /// **RDS for Oracle**
    ///
    /// For information, see [Oracle Database Engine release
    /// notes](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.Oracle.PatchComposition.html) in the *Amazon RDS User Guide*.
    ///
    /// **RDS for PostgreSQL**
    ///
    /// For information, see [Amazon RDS for PostgreSQL versions and
    /// extensions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts) in the *Amazon RDS User Guide*.
    engine_version: ?[]const u8 = null,

    /// The amount of Provisioned IOPS (input/output operations per second) to
    /// initially allocate for the DB instance. For information about valid IOPS
    /// values, see [Amazon RDS DB instance
    /// storage](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. Storage is managed
    /// by the DB cluster.
    ///
    /// Constraints:
    ///
    /// * For RDS for Db2, MariaDB, MySQL, Oracle, and PostgreSQL - Must be a
    ///   multiple between .5 and 50 of the storage amount for the DB instance.
    /// * For RDS for SQL Server - Must be a multiple between 1 and 50 of the
    ///   storage amount for the DB instance.
    iops: ?i32 = null,

    /// The Amazon Web Services KMS key identifier for an encrypted DB instance.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The Amazon Web
    /// Services KMS key identifier is managed by the DB cluster. For more
    /// information, see `CreateDBCluster`.
    ///
    /// If `StorageEncrypted` is enabled, and you do not specify a value for the
    /// `KmsKeyId` parameter, then Amazon RDS uses your default KMS key. There is a
    /// default KMS key for your Amazon Web Services account. Your Amazon Web
    /// Services account has a different default KMS key for each Amazon Web
    /// Services Region.
    ///
    /// For Amazon RDS Custom, a KMS key is required for DB instances. For most RDS
    /// engines, if you leave this parameter empty while enabling
    /// `StorageEncrypted`, the engine uses the default KMS key. However, RDS Custom
    /// doesn't use the default key when this parameter is empty. You must
    /// explicitly specify a key.
    kms_key_id: ?[]const u8 = null,

    /// The license model information for this DB instance.
    ///
    /// License models for RDS for Db2 require additional configuration. The bring
    /// your own license (BYOL) model requires a custom parameter group and an
    /// Amazon Web Services License Manager self-managed license. The Db2 license
    /// through Amazon Web Services Marketplace model requires an Amazon Web
    /// Services Marketplace subscription. For more information, see [Amazon RDS for
    /// Db2 licensing
    /// options](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/db2-licensing.html) in the *Amazon RDS User Guide*.
    ///
    /// The default for RDS for Db2 is `bring-your-own-license`.
    ///
    /// This setting doesn't apply to Amazon Aurora or RDS Custom DB instances.
    ///
    /// Valid Values:
    ///
    /// * RDS for Db2 - `bring-your-own-license | marketplace-license`
    /// * RDS for MariaDB - `general-public-license`
    /// * RDS for Microsoft SQL Server - `license-included`
    /// * RDS for MySQL - `general-public-license`
    /// * RDS for Oracle - `bring-your-own-license | license-included`
    /// * RDS for PostgreSQL - `postgresql-license`
    license_model: ?[]const u8 = null,

    /// Specifies whether to manage the master user password with Amazon Web
    /// Services Secrets Manager.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide.*
    ///
    /// Constraints:
    ///
    /// * Can't manage the master user password with Amazon Web Services Secrets
    ///   Manager if `MasterUserPassword` is specified.
    manage_master_user_password: ?bool = null,

    /// Specifies the authentication type for the master user. With IAM master user
    /// authentication, you can configure the master DB user with IAM database
    /// authentication when you create a DB instance.
    ///
    /// You can specify one of the following values:
    ///
    /// * `password` - Use standard database authentication with a password.
    /// * `iam-db-auth` - Use IAM database authentication for the master user.
    ///
    /// This option is only valid for RDS for PostgreSQL and Aurora PostgreSQL
    /// engines.
    master_user_authentication_type: ?MasterUserAuthenticationType = null,

    /// The name for the master user.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The name for the
    /// master user is managed by the DB cluster.
    ///
    /// This setting is required for RDS DB instances.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 16 letters, numbers, or underscores.
    /// * First character must be a letter.
    /// * Can't be a reserved word for the chosen database engine.
    master_username: ?[]const u8 = null,

    /// The password for the master user.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The password for
    /// the master user is managed by the DB cluster.
    ///
    /// Constraints:
    ///
    /// * Can't be specified if `ManageMasterUserPassword` is turned on.
    /// * Can include any printable ASCII character except "/", """, or "@". For RDS
    ///   for Oracle, can't include the "&" (ampersand) or the "'" (single quotes)
    ///   character.
    ///
    /// Length Constraints:
    ///
    /// * RDS for Db2 - Must contain from 8 to 255 characters.
    /// * RDS for MariaDB - Must contain from 8 to 41 characters.
    /// * RDS for Microsoft SQL Server - Must contain from 8 to 128 characters.
    /// * RDS for MySQL - Must contain from 8 to 41 characters.
    /// * RDS for Oracle - Must contain from 8 to 30 characters.
    /// * RDS for PostgreSQL - Must contain from 8 to 128 characters.
    master_user_password: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier to encrypt a secret that is
    /// automatically generated and managed in Amazon Web Services Secrets Manager.
    ///
    /// This setting is valid only if the master user password is managed by RDS in
    /// Amazon Web Services Secrets Manager for the DB instance.
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

    /// The upper limit in gibibytes (GiB) to which Amazon RDS can automatically
    /// scale the storage of the DB instance.
    ///
    /// For more information about this setting, including limitations that apply to
    /// it, see [ Managing capacity automatically with Amazon RDS storage
    /// autoscaling](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PIOPS.StorageTypes.html#USER_PIOPS.Autoscaling) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to the following DB instances:
    ///
    /// * Amazon Aurora (Storage is managed by the DB cluster.)
    /// * RDS Custom
    max_allocated_storage: ?i32 = null,

    /// The interval, in seconds, between points when Enhanced Monitoring metrics
    /// are collected for the DB instance. To disable collection of Enhanced
    /// Monitoring metrics, specify `0`.
    ///
    /// If `MonitoringRoleArn` is specified, then you must set `MonitoringInterval`
    /// to a value other than `0`.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Valid Values: `0 | 1 | 5 | 10 | 15 | 30 | 60`
    ///
    /// Default: `0`
    monitoring_interval: ?i32 = null,

    /// The ARN for the IAM role that permits RDS to send enhanced monitoring
    /// metrics to Amazon CloudWatch Logs. For example,
    /// `arn:aws:iam:123456789012:role/emaccess`. For information on creating a
    /// monitoring role, see [Setting Up and Enabling Enhanced
    /// Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling) in the *Amazon RDS User Guide*.
    ///
    /// If `MonitoringInterval` is set to a value other than `0`, then you must
    /// supply a `MonitoringRoleArn` value.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    monitoring_role_arn: ?[]const u8 = null,

    /// Specifies whether the DB instance is a Multi-AZ deployment. You can't set
    /// the `AvailabilityZone` parameter if the DB instance is a Multi-AZ
    /// deployment.
    ///
    /// This setting doesn't apply to Amazon Aurora because the DB instance
    /// Availability Zones (AZs) are managed by the DB cluster.
    multi_az: ?bool = null,

    /// Specifies whether to use the multi-tenant configuration or the single-tenant
    /// configuration (default). This parameter only applies to RDS for Oracle
    /// container database (CDB) engines.
    ///
    /// Note the following restrictions:
    ///
    /// * The DB engine that you specify in the request must support the
    ///   multi-tenant configuration. If you attempt to enable the multi-tenant
    ///   configuration on a DB engine that doesn't support it, the request fails.
    /// * If you specify the multi-tenant configuration when you create your DB
    ///   instance, you can't later modify this DB instance to use the single-tenant
    ///   configuration.
    multi_tenant: ?bool = null,

    /// The name of the NCHAR character set for the Oracle DB instance.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    nchar_character_set_name: ?[]const u8 = null,

    /// The network type of the DB instance.
    ///
    /// The network type is determined by the `DBSubnetGroup` specified for the DB
    /// instance. A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4
    /// and the IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [ Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon RDS User Guide.*
    ///
    /// Valid Values: `IPV4 | DUAL`
    network_type: ?[]const u8 = null,

    /// The option group to associate the DB instance with.
    ///
    /// Permanent options, such as the TDE option for Oracle Advanced Security TDE,
    /// can't be removed from an option group. Also, that option group can't be
    /// removed from a DB instance after it is associated with a DB instance.
    ///
    /// This setting doesn't apply to Amazon Aurora or RDS Custom DB instances.
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

    /// The port number on which the database accepts connections.
    ///
    /// This setting doesn't apply to Aurora DB instances. The port number is
    /// managed by the cluster.
    ///
    /// Valid Values: `1150-65535`
    ///
    /// Default:
    ///
    /// * RDS for Db2 - `50000`
    /// * RDS for MariaDB - `3306`
    /// * RDS for Microsoft SQL Server - `1433`
    /// * RDS for MySQL - `3306`
    /// * RDS for Oracle - `1521`
    /// * RDS for PostgreSQL - `5432`
    ///
    /// Constraints:
    ///
    /// * For RDS for Microsoft SQL Server, the value can't be `1234`, `1434`,
    ///   `3260`, `3343`, `3389`, `47001`, or `49152-49156`.
    port: ?i32 = null,

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled, using the `BackupRetentionPeriod` parameter. The
    /// default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region. For more information, see [Backup
    /// window](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The daily time
    /// range for creating automated backups is managed by the DB cluster.
    ///
    /// Constraints:
    ///
    /// * Must be in the format `hh24:mi-hh24:mi`.
    /// * Must be in Universal Coordinated Time (UTC).
    /// * Must not conflict with the preferred maintenance window.
    /// * Must be at least 30 minutes.
    preferred_backup_window: ?[]const u8 = null,

    /// The time range each week during which system maintenance can occur. For more
    /// information, see [Amazon RDS Maintenance
    /// Window](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#Concepts.DBMaintenance) in the *Amazon RDS User Guide.*
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each Amazon Web Services Region, occurring on a random day of the
    /// week.
    ///
    /// Constraints:
    ///
    /// * Must be in the format `ddd:hh24:mi-ddd:hh24:mi`.
    /// * The day values must be `mon | tue | wed | thu | fri | sat | sun`.
    /// * Must be in Universal Coordinated Time (UTC).
    /// * Must not conflict with the preferred backup window.
    /// * Must be at least 30 minutes.
    preferred_maintenance_window: ?[]const u8 = null,

    /// The number of CPU cores and the number of threads per core for the DB
    /// instance class of the DB instance.
    ///
    /// This setting doesn't apply to Amazon Aurora or RDS Custom DB instances.
    processor_features: ?[]const ProcessorFeature = null,

    /// The order of priority in which an Aurora Replica is promoted to the primary
    /// instance after a failure of the existing primary instance. For more
    /// information, see [ Fault Tolerance for an Aurora DB
    /// Cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.AuroraHighAvailability.html#Aurora.Managing.FaultTolerance) in the *Amazon Aurora User Guide*.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Default: `1`
    ///
    /// Valid Values: `0 - 15`
    promotion_tier: ?i32 = null,

    /// Specifies whether the DB instance is publicly accessible.
    ///
    /// When the DB instance is publicly accessible and you connect from outside of
    /// the DB instance's virtual private cloud (VPC), its domain name system (DNS)
    /// endpoint resolves to the public IP address. When you connect from within the
    /// same VPC as the DB instance, the endpoint resolves to the private IP
    /// address. Access to the DB instance is controlled by its security group
    /// settings.
    ///
    /// When the DB instance isn't publicly accessible, it is an internal DB
    /// instance with a DNS name that resolves to a private IP address.
    ///
    /// The default behavior when `PubliclyAccessible` is not specified depends on
    /// whether a `DBSubnetGroup` is specified.
    ///
    /// If `DBSubnetGroup` isn't specified, `PubliclyAccessible` defaults to `false`
    /// for Aurora instances and `true` for non-Aurora instances.
    ///
    /// If `DBSubnetGroup` is specified, `PubliclyAccessible` defaults to `false`
    /// unless the value of `DBSubnetGroup` is `default`, in which case
    /// `PubliclyAccessible` defaults to `true`.
    ///
    /// If `PubliclyAccessible` is true and the VPC that the `DBSubnetGroup` is in
    /// doesn't have an internet gateway attached to it, Amazon RDS returns an
    /// error.
    publicly_accessible: ?bool = null,

    /// Specifes whether the DB instance is encrypted. By default, it isn't
    /// encrypted.
    ///
    /// For RDS Custom DB instances, either enable this setting or leave it unset.
    /// Otherwise, Amazon RDS reports an error.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The encryption for
    /// DB instances is managed by the DB cluster.
    storage_encrypted: ?bool = null,

    /// The storage throughput value, in mebibyte per second (MiBps), for the DB
    /// instance.
    ///
    /// This setting applies only to the `gp3` storage type.
    ///
    /// This setting doesn't apply to Amazon Aurora or RDS Custom DB instances.
    storage_throughput: ?i32 = null,

    /// The storage type to associate with the DB instance.
    ///
    /// If you specify `io1`, `io2`, or `gp3`, you must also include a value for the
    /// `Iops` parameter.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. Storage is managed
    /// by the DB cluster.
    ///
    /// Valid Values: `gp2 | gp3 | io1 | io2 | standard`
    ///
    /// Default: `io1`, if the `Iops` parameter is specified. Otherwise, `gp3`.
    storage_type: ?[]const u8 = null,

    /// Tags to assign to the DB instance.
    tags: ?[]const Tag = null,

    /// Tags to assign to resources associated with the DB instance.
    ///
    /// Valid Values:
    ///
    /// * `auto-backup` - The DB instance's automated backup.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ARN from the key store with which to associate the instance for TDE
    /// encryption.
    ///
    /// This setting doesn't apply to Amazon Aurora or RDS Custom DB instances.
    tde_credential_arn: ?[]const u8 = null,

    /// The password for the given ARN from the key store in order to access the
    /// device.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    tde_credential_password: ?[]const u8 = null,

    /// The time zone of the DB instance. The time zone parameter is currently
    /// supported only by [RDS for
    /// Db2](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/db2-time-zone)
    /// and [RDS for SQL
    /// Server](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.TimeZone).
    timezone: ?[]const u8 = null,

    /// A list of Amazon EC2 VPC security groups to associate with this DB instance.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The associated
    /// list of EC2 VPC security groups is managed by the DB cluster.
    ///
    /// Default: The default EC2 VPC security group for the DB subnet group's VPC.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const CreateDBInstanceOutput = struct {
    db_instance: ?DBInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBInstanceInput, options: CallOptions) !CreateDBInstanceOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateDBInstance&Version=2014-10-31");
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
    if (input.backup_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&BackupRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.backup_target) |v| {
        try body_buf.appendSlice(allocator, "&BackupTarget=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ca_certificate_identifier) |v| {
        try body_buf.appendSlice(allocator, "&CACertificateIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.character_set_name) |v| {
        try body_buf.appendSlice(allocator, "&CharacterSetName=");
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
    if (input.db_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DBInstanceClass=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_class);
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    if (input.db_name) |v| {
        try body_buf.appendSlice(allocator, "&DBName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DBSecurityGroups.DBSecurityGroupName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.db_subnet_group_name) |v| {
        try body_buf.appendSlice(allocator, "&DBSubnetGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_system_id) |v| {
        try body_buf.appendSlice(allocator, "&DBSystemId=");
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
    if (input.iops) |v| {
        try body_buf.appendSlice(allocator, "&Iops=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.license_model) |v| {
        try body_buf.appendSlice(allocator, "&LicenseModel=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.manage_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&ManageMasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.master_user_authentication_type) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserAuthenticationType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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
    if (input.multi_tenant) |v| {
        try body_buf.appendSlice(allocator, "&MultiTenant=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.nchar_character_set_name) |v| {
        try body_buf.appendSlice(allocator, "&NcharCharacterSetName=");
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
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
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
    if (input.promotion_tier) |v| {
        try body_buf.appendSlice(allocator, "&PromotionTier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.publicly_accessible) |v| {
        try body_buf.appendSlice(allocator, "&PubliclyAccessible=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.storage_encrypted) |v| {
        try body_buf.appendSlice(allocator, "&StorageEncrypted=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
    if (input.tde_credential_arn) |v| {
        try body_buf.appendSlice(allocator, "&TdeCredentialArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tde_credential_password) |v| {
        try body_buf.appendSlice(allocator, "&TdeCredentialPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.timezone) |v| {
        try body_buf.appendSlice(allocator, "&Timezone=");
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBInstanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBInstanceResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBInstanceOutput = .{};
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
