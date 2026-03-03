const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ModifyAdditionalStorageVolume = @import("modify_additional_storage_volume.zig").ModifyAdditionalStorageVolume;
const AutomationMode = @import("automation_mode.zig").AutomationMode;
const CloudwatchLogsExportConfiguration = @import("cloudwatch_logs_export_configuration.zig").CloudwatchLogsExportConfiguration;
const DatabaseInsightsMode = @import("database_insights_mode.zig").DatabaseInsightsMode;
const MasterUserAuthenticationType = @import("master_user_authentication_type.zig").MasterUserAuthenticationType;
const ProcessorFeature = @import("processor_feature.zig").ProcessorFeature;
const ReplicaMode = @import("replica_mode.zig").ReplicaMode;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const DBInstance = @import("db_instance.zig").DBInstance;
const serde = @import("serde.zig");

pub const ModifyDBInstanceInput = struct {
    /// A list of additional storage volumes to modify or delete for the DB
    /// instance. You can create up to 3 additional storage volumes. Additional
    /// storage volumes are supported for RDS for Oracle and RDS for SQL Server DB
    /// instances only.
    additional_storage_volumes: ?[]const ModifyAdditionalStorageVolume = null,

    /// The new amount of storage in gibibytes (GiB) to allocate for the DB
    /// instance.
    ///
    /// For RDS for Db2, MariaDB, RDS for MySQL, RDS for Oracle, and RDS for
    /// PostgreSQL, the value supplied must be at least 10% greater than the current
    /// value. Values that are not at least 10% greater than the existing value are
    /// rounded up so that they are 10% greater than the current value.
    ///
    /// For the valid values for allocated storage for each engine, see
    /// `CreateDBInstance`.
    ///
    /// Constraints:
    ///
    /// * When you increase the allocated storage for a DB instance that uses
    ///   Provisioned IOPS (`gp3`, `io1`, or `io2` storage type), you must also
    ///   specify the `Iops` parameter. You can use the current value for `Iops`.
    allocated_storage: ?i32 = null,

    /// Specifies whether major version upgrades are allowed. Changing this
    /// parameter doesn't result in an outage and the change is asynchronously
    /// applied as soon as possible.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Constraints:
    ///
    /// * Major version upgrades must be allowed when specifying a value for the
    ///   `EngineVersion` parameter that's a different major version than the DB
    ///   instance's current version.
    allow_major_version_upgrade: ?bool = null,

    /// Specifies whether the modifications in this request and any pending
    /// modifications are asynchronously applied as soon as possible, regardless of
    /// the `PreferredMaintenanceWindow` setting for the DB instance. By default,
    /// this parameter is disabled.
    ///
    /// If this parameter is disabled, changes to the DB instance are applied during
    /// the next maintenance window. Some parameter changes can cause an outage and
    /// are applied on the next call to RebootDBInstance, or the next failure
    /// reboot. Review the table of parameters in [Modifying a DB
    /// Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.Modifying.html) in the *Amazon RDS User Guide* to see the impact of enabling or disabling `ApplyImmediately` for each modified parameter and to determine when the changes are applied.
    apply_immediately: ?bool = null,

    /// The automation mode of the RDS Custom DB instance. If `full`, the DB
    /// instance automates monitoring and instance recovery. If `all paused`, the
    /// instance pauses automation for the duration set by
    /// `ResumeFullAutomationModeMinutes`.
    automation_mode: ?AutomationMode = null,

    /// Specifies whether minor version upgrades are applied automatically to the DB
    /// instance during the maintenance window. An outage occurs when all the
    /// following conditions are met:
    ///
    /// * The automatic upgrade is enabled for the maintenance window.
    /// * A newer minor version is available.
    /// * RDS has enabled automatic patching for the engine version.
    ///
    /// If any of the preceding conditions isn't met, Amazon RDS applies the change
    /// as soon as possible and doesn't cause an outage.
    ///
    /// For an RDS Custom DB instance, don't enable this setting. Otherwise, the
    /// operation returns an error.
    ///
    /// For more information about automatic minor version upgrades, see
    /// [Automatically upgrading the minor engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades).
    auto_minor_version_upgrade: ?bool = null,

    /// The Amazon Resource Name (ARN) of the recovery point in Amazon Web Services
    /// Backup.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    aws_backup_recovery_point_arn: ?[]const u8 = null,

    /// The number of days to retain automated backups. Setting this parameter to a
    /// positive number enables backups. Setting this parameter to 0 disables
    /// automated backups.
    ///
    /// Enabling and disabling backups can result in a brief I/O suspension that
    /// lasts from a few seconds to a few minutes, depending on the size and class
    /// of your DB instance.
    ///
    /// These changes are applied during the next maintenance window unless the
    /// `ApplyImmediately` parameter is enabled for this request. If you change the
    /// parameter from one non-zero value to another non-zero value, the change is
    /// asynchronously applied as soon as possible.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The retention
    /// period for automated backups is managed by the DB cluster. For more
    /// information, see `ModifyDBCluster`.
    ///
    /// Default: Uses existing setting
    ///
    /// Constraints:
    ///
    /// * Must be a value from 0 to 35.
    /// * Can't be set to 0 if the DB instance is a source to read replicas.
    /// * Can't be set to 0 for an RDS Custom for Oracle DB instance.
    backup_retention_period: ?i32 = null,

    /// The CA certificate identifier to use for the DB instance's server
    /// certificate.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// For more information, see [Using SSL/TLS to encrypt a connection to a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
    ca_certificate_identifier: ?[]const u8 = null,

    /// Specifies whether the DB instance is restarted when you rotate your SSL/TLS
    /// certificate.
    ///
    /// By default, the DB instance is restarted when you rotate your SSL/TLS
    /// certificate. The certificate is not updated until the DB instance is
    /// restarted.
    ///
    /// Set this parameter only if you are *not* using SSL/TLS to connect to the DB
    /// instance.
    ///
    /// If you are using SSL/TLS to connect to the DB instance, follow the
    /// appropriate instructions for your DB engine to rotate your SSL/TLS
    /// certificate:
    ///
    /// * For more information about rotating your SSL/TLS certificate for RDS DB
    ///   engines, see [ Rotating Your SSL/TLS
    ///   Certificate.](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL-certificate-rotation.html) in the *Amazon RDS User Guide.*
    /// * For more information about rotating your SSL/TLS certificate for Aurora DB
    ///   engines, see [ Rotating Your SSL/TLS
    ///   Certificate](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL-certificate-rotation.html) in the *Amazon Aurora User Guide*.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    certificate_rotation_restart: ?bool = null,

    /// The log types to be enabled for export to CloudWatch Logs for a specific DB
    /// instance.
    ///
    /// A change to the `CloudwatchLogsExportConfiguration` parameter is always
    /// applied to the DB instance immediately. Therefore, the `ApplyImmediately`
    /// parameter has no effect.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// The following values are valid for each DB engine:
    ///
    /// * Aurora MySQL - `audit | error | general | slowquery | iam-db-auth-error`
    /// * Aurora PostgreSQL - `postgresql | iam-db-auth-error`
    /// * RDS for MySQL - `error | general | slowquery | iam-db-auth-error`
    /// * RDS for PostgreSQL - `postgresql | upgrade | iam-db-auth-error`
    ///
    /// For more information about exporting CloudWatch Logs for Amazon RDS, see [
    /// Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon RDS User Guide*.
    ///
    /// For more information about exporting CloudWatch Logs for Amazon Aurora, see
    /// [Publishing Database Logs to Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon Aurora User Guide*.
    cloudwatch_logs_export_configuration: ?CloudwatchLogsExportConfiguration = null,

    /// Specifies whether to copy all tags from the DB instance to snapshots of the
    /// DB instance. By default, tags aren't copied.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. Copying tags to
    /// snapshots is managed by the DB cluster. Setting this value for an Aurora DB
    /// instance has no effect on the DB cluster setting. For more information, see
    /// `ModifyDBCluster`.
    copy_tags_to_snapshot: ?bool = null,

    /// Specifies the mode of Database Insights to enable for the DB instance.
    ///
    /// Aurora DB instances inherit this value from the DB cluster, so you can't
    /// change this value.
    database_insights_mode: ?DatabaseInsightsMode = null,

    /// The new compute and memory capacity of the DB instance, for example
    /// `db.m4.large`. Not all DB instance classes are available in all Amazon Web
    /// Services Regions, or for all database engines. For the full list of DB
    /// instance classes, and availability for your engine, see [DB Instance
    /// Class](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the *Amazon RDS User Guide* or [Aurora DB instance classes](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html) in the *Amazon Aurora User Guide*. For RDS Custom, see [DB instance class support for RDS Custom for Oracle](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-reqs-limits.html#custom-reqs-limits.instances) and [ DB instance class support for RDS Custom for SQL Server](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-reqs-limits-MS.html#custom-reqs-limits.instancesMS).
    ///
    /// If you modify the DB instance class, an outage occurs during the change. The
    /// change is applied during the next maintenance window, unless you specify
    /// `ApplyImmediately` in your request.
    ///
    /// Default: Uses existing setting
    ///
    /// Constraints:
    ///
    /// * If you are modifying the DB instance class and upgrading the engine
    ///   version at the same time, the currently running engine version must be
    ///   supported on the specified DB instance class. Otherwise, the operation
    ///   returns an error. In this case, first run the operation to upgrade the
    ///   engine version, and then run it again to modify the DB instance class.
    db_instance_class: ?[]const u8 = null,

    /// The identifier of DB instance to modify. This value is stored as a lowercase
    /// string.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing DB instance.
    db_instance_identifier: []const u8,

    /// The name of the DB parameter group to apply to the DB instance.
    ///
    /// Changing this setting doesn't result in an outage. The parameter group name
    /// itself is changed immediately, but the actual parameter changes are not
    /// applied until you reboot the instance without failover. In this case, the DB
    /// instance isn't rebooted automatically, and the parameter changes aren't
    /// applied during the next maintenance window. However, if you modify dynamic
    /// parameters in the newly associated DB parameter group, these changes are
    /// applied immediately without a reboot.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Default: Uses existing setting
    ///
    /// Constraints:
    ///
    /// * Must be in the same DB parameter group family as the DB instance.
    db_parameter_group_name: ?[]const u8 = null,

    /// The port number on which the database accepts connections.
    ///
    /// The value of the `DBPortNumber` parameter must not match any of the port
    /// values specified for options in the option group for the DB instance.
    ///
    /// If you change the `DBPortNumber` value, your database restarts regardless of
    /// the value of the `ApplyImmediately` parameter.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Valid Values: `1150-65535`
    ///
    /// Default:
    ///
    /// * Amazon Aurora - `3306`
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
    db_port_number: ?i32 = null,

    /// A list of DB security groups to authorize on this DB instance. Changing this
    /// setting doesn't result in an outage and the change is asynchronously applied
    /// as soon as possible.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match existing DB security groups.
    db_security_groups: ?[]const []const u8 = null,

    /// The new DB subnet group for the DB instance. You can use this parameter to
    /// move your DB instance to a different VPC. If your DB instance isn't in a
    /// VPC, you can also use this parameter to move your DB instance into a VPC.
    /// For more information, see [Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Non-VPC2VPC) in the *Amazon RDS User Guide*.
    ///
    /// Changing the subnet group causes an outage during the change. The change is
    /// applied during the next maintenance window, unless you enable
    /// `ApplyImmediately`.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match existing DB subnet group.
    ///
    /// Example: `mydbsubnetgroup`
    db_subnet_group_name: ?[]const u8 = null,

    /// Indicates whether the DB instance has a dedicated log volume (DLV) enabled.
    dedicated_log_volume: ?bool = null,

    /// Specifies whether the DB instance has deletion protection enabled. The
    /// database can't be deleted when deletion protection is enabled. By default,
    /// deletion protection isn't enabled. For more information, see [ Deleting a DB
    /// Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html).
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. You can enable or
    /// disable deletion protection for the DB cluster. For more information, see
    /// `ModifyDBCluster`. DB instances in a DB cluster can be deleted even when
    /// deletion protection is enabled for the DB cluster.
    deletion_protection: ?bool = null,

    /// Specifies whether to remove the DB instance from the Active Directory
    /// domain.
    disable_domain: ?bool = null,

    /// The Active Directory directory ID to move the DB instance to. Specify `none`
    /// to remove the instance from its current domain. You must create the domain
    /// before this operation. Currently, you can create only Db2, MySQL, Microsoft
    /// SQL Server, Oracle, and PostgreSQL DB instances in an Active Directory
    /// Domain.
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
    ///
    /// Example:
    /// `OU=mymanagedADtestOU,DC=mymanagedADtest,DC=mymanagedAD,DC=mydomain`
    domain_ou: ?[]const u8 = null,

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
    /// This setting doesn't apply to Amazon Aurora. Mapping Amazon Web Services IAM
    /// accounts to database accounts is managed by the DB cluster.
    ///
    /// For more information about IAM database authentication, see [ IAM Database
    /// Authentication for MySQL and
    /// PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon RDS User Guide.*
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    enable_iam_database_authentication: ?bool = null,

    /// Specifies whether to enable Performance Insights for the DB instance.
    ///
    /// For more information, see [Using Amazon Performance
    /// Insights](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    enable_performance_insights: ?bool = null,

    /// The target Oracle DB engine when you convert a non-CDB to a CDB. This
    /// intermediate step is necessary to upgrade an Oracle Database 19c non-CDB to
    /// an Oracle Database 21c CDB.
    ///
    /// Note the following requirements:
    ///
    /// * Make sure that you specify `oracle-ee-cdb` or `oracle-se2-cdb`.
    /// * Make sure that your DB engine runs Oracle Database 19c with an April 2021
    ///   or later RU.
    ///
    /// Note the following limitations:
    ///
    /// * You can't convert a CDB to a non-CDB.
    /// * You can't convert a replica database.
    /// * You can't convert a non-CDB to a CDB and upgrade the engine version in the
    ///   same command.
    /// * You can't convert the existing custom parameter or option group when it
    ///   has options or parameters that are permanent or persistent. In this
    ///   situation, the DB instance reverts to the default option and parameter
    ///   group. To avoid reverting to the default, specify a new parameter group
    ///   with `--db-parameter-group-name` and a new option group with
    ///   `--option-group-name`.
    engine: ?[]const u8 = null,

    /// The version number of the database engine to upgrade to. Changing this
    /// parameter results in an outage and the change is applied during the next
    /// maintenance window unless the `ApplyImmediately` parameter is enabled for
    /// this request.
    ///
    /// For major version upgrades, if a nondefault DB parameter group is currently
    /// in use, a new DB parameter group in the DB parameter group family for the
    /// new engine version must be specified. The new DB parameter group can be the
    /// default for that DB parameter group family.
    ///
    /// If you specify only a major version, Amazon RDS updates the DB instance to
    /// the default minor version if the current minor version is lower. For
    /// information about valid engine versions, see `CreateDBInstance`, or call
    /// `DescribeDBEngineVersions`.
    ///
    /// If the instance that you're modifying is acting as a read replica, the
    /// engine version that you specify must be the same or higher than the version
    /// that the source DB instance or cluster is running.
    ///
    /// In RDS Custom for Oracle, this parameter is supported for read replicas only
    /// if they are in the `PATCH_DB_FAILURE` lifecycle.
    ///
    /// Constraints:
    ///
    /// * If you are upgrading the engine version and modifying the DB instance
    ///   class at the same time, the currently running engine version must be
    ///   supported on the specified DB instance class. Otherwise, the operation
    ///   returns an error. In this case, first run the operation to upgrade the
    ///   engine version, and then run it again to modify the DB instance class.
    engine_version: ?[]const u8 = null,

    /// The new Provisioned IOPS (I/O operations per second) value for the RDS
    /// instance.
    ///
    /// Changing this setting doesn't result in an outage and the change is applied
    /// during the next maintenance window unless the `ApplyImmediately` parameter
    /// is enabled for this request. If you are migrating from Provisioned IOPS to
    /// standard storage, set this value to 0. The DB instance will require a reboot
    /// for the change in storage type to take effect.
    ///
    /// If you choose to migrate your DB instance from using standard storage to
    /// Provisioned IOPS (io1), or from Provisioned IOPS to standard storage, the
    /// process can take time. The duration of the migration depends on several
    /// factors such as database load, storage size, storage type (standard or
    /// Provisioned IOPS), amount of IOPS provisioned (if any), and the number of
    /// prior scale storage operations. Typical migration times are under 24 hours,
    /// but the process can take up to several days in some cases. During the
    /// migration, the DB instance is available for use, but might experience
    /// performance degradation. While the migration takes place, nightly backups
    /// for the instance are suspended. No other Amazon RDS operations can take
    /// place for the instance, including modifying the instance, rebooting the
    /// instance, deleting the instance, creating a read replica for the instance,
    /// and creating a DB snapshot of the instance.
    ///
    /// Constraints:
    ///
    /// * For RDS for MariaDB, RDS for MySQL, RDS for Oracle, and RDS for PostgreSQL
    ///   - The value supplied must be at least 10% greater than the current value.
    ///   Values that are not at least 10% greater than the existing value are
    ///   rounded up so that they are 10% greater than the current value.
    /// * When you increase the Provisioned IOPS, you must also specify the
    ///   `AllocatedStorage` parameter. You can use the current value for
    ///   `AllocatedStorage`.
    ///
    /// Default: Uses existing setting
    iops: ?i32 = null,

    /// The license model for the DB instance.
    ///
    /// This setting doesn't apply to Amazon Aurora or RDS Custom DB instances.
    ///
    /// Valid Values:
    ///
    /// * RDS for Db2 - `bring-your-own-license`
    /// * RDS for MariaDB - `general-public-license`
    /// * RDS for Microsoft SQL Server - `license-included`
    /// * RDS for MySQL - `general-public-license`
    /// * RDS for Oracle - `bring-your-own-license | license-included`
    /// * RDS for PostgreSQL - `postgresql-license`
    license_model: ?[]const u8 = null,

    /// Specifies whether to manage the master user password with Amazon Web
    /// Services Secrets Manager.
    ///
    /// If the DB instance doesn't manage the master user password with Amazon Web
    /// Services Secrets Manager, you can turn on this management. In this case, you
    /// can't specify `MasterUserPassword`.
    ///
    /// If the DB instance already manages the master user password with Amazon Web
    /// Services Secrets Manager, and you specify that the master user password is
    /// not managed with Amazon Web Services Secrets Manager, then you must specify
    /// `MasterUserPassword`. In this case, Amazon RDS deletes the secret and uses
    /// the new password for the master user specified by `MasterUserPassword`.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide.*
    ///
    /// Constraints:
    ///
    /// * Can't manage the master user password with Amazon Web Services Secrets
    ///   Manager if `MasterUserPassword` is specified.
    /// * Can't specify for RDS for Oracle CDB instances in the multi-tenant
    ///   configuration. Use `ModifyTenantDatabase` instead.
    /// * Can't specify the parameters `ManageMasterUserPassword` and `MultiTenant`
    ///   in the same operation.
    manage_master_user_password: ?bool = null,

    /// Specifies the authentication type for the master user. With IAM master user
    /// authentication, you can change the master DB user to use IAM database
    /// authentication.
    ///
    /// You can specify one of the following values:
    ///
    /// * `password` - Use standard database authentication with a password.
    /// * `iam-db-auth` - Use IAM database authentication for the master user.
    ///
    /// This option is only valid for RDS for PostgreSQL and Aurora PostgreSQL
    /// engines.
    master_user_authentication_type: ?MasterUserAuthenticationType = null,

    /// The new password for the master user.
    ///
    /// Changing this parameter doesn't result in an outage and the change is
    /// asynchronously applied as soon as possible. Between the time of the request
    /// and the completion of the request, the `MasterUserPassword` element exists
    /// in the `PendingModifiedValues` element of the operation response.
    ///
    /// Amazon RDS API operations never return the password, so this operation
    /// provides a way to regain access to a primary instance user if the password
    /// is lost. This includes restoring privileges that might have been
    /// accidentally revoked.
    ///
    /// This setting doesn't apply to the following DB instances:
    ///
    /// * Amazon Aurora
    ///
    /// The password for the master user is managed by the DB cluster. For more
    /// information, see `ModifyDBCluster`.
    /// * RDS Custom
    /// * RDS for Oracle CDBs in the multi-tenant configuration
    ///
    /// Specify the master password in `ModifyTenantDatabase` instead.
    ///
    /// Default: Uses existing setting
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
    /// This setting is valid only if both of the following conditions are met:
    ///
    /// * The DB instance doesn't manage the master user password in Amazon Web
    ///   Services Secrets Manager.
    ///
    /// If the DB instance already manages the master user password in Amazon Web
    /// Services Secrets Manager, you can't change the KMS key used to encrypt the
    /// secret.
    /// * You are turning on `ManageMasterUserPassword` to manage the master user
    ///   password in Amazon Web Services Secrets Manager.
    ///
    /// If you are turning on `ManageMasterUserPassword` and don't specify
    /// `MasterUserSecretKmsKeyId`, then the `aws/secretsmanager` KMS key is used to
    /// encrypt the secret. If the secret is in a different Amazon Web Services
    /// account, then you can't use the `aws/secretsmanager` KMS key to encrypt the
    /// secret, and you must use a customer managed KMS key.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
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
    /// This setting doesn't apply to RDS Custom DB instances.
    max_allocated_storage: ?i32 = null,

    /// The interval, in seconds, between points when Enhanced Monitoring metrics
    /// are collected for the DB instance. To disable collection of Enhanced
    /// Monitoring metrics, specify `0`.
    ///
    /// If `MonitoringRoleArn` is specified, set `MonitoringInterval` to a value
    /// other than `0`.
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
    /// monitoring role, see [To create an IAM role for Amazon RDS Enhanced
    /// Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.html#USER_Monitoring.OS.IAMRole) in the *Amazon RDS User Guide.*
    ///
    /// If `MonitoringInterval` is set to a value other than `0`, supply a
    /// `MonitoringRoleArn` value.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    monitoring_role_arn: ?[]const u8 = null,

    /// Specifies whether the DB instance is a Multi-AZ deployment. Changing this
    /// parameter doesn't result in an outage. The change is applied during the next
    /// maintenance window unless the `ApplyImmediately` parameter is enabled for
    /// this request.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    multi_az: ?bool = null,

    /// Specifies whether the to convert your DB instance from the single-tenant
    /// conﬁguration to the multi-tenant conﬁguration. This parameter is supported
    /// only for RDS for Oracle CDB instances.
    ///
    /// During the conversion, RDS creates an initial tenant database and associates
    /// the DB name, master user name, character set, and national character set
    /// metadata with this database. The tags associated with the instance also
    /// propagate to the initial tenant database. You can add more tenant databases
    /// to your DB instance by using the `CreateTenantDatabase` operation.
    ///
    /// The conversion to the multi-tenant configuration is permanent and
    /// irreversible, so you can't later convert back to the single-tenant
    /// configuration. When you specify this parameter, you must also specify
    /// `ApplyImmediately`.
    multi_tenant: ?bool = null,

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

    /// The new identifier for the DB instance when renaming a DB instance. When you
    /// change the DB instance identifier, an instance reboot occurs immediately if
    /// you enable `ApplyImmediately`, or will occur during the next maintenance
    /// window if you disable `ApplyImmediately`. This value is stored as a
    /// lowercase string.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    /// * The first character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `mydbinstance`
    new_db_instance_identifier: ?[]const u8 = null,

    /// The option group to associate the DB instance with.
    ///
    /// Changing this parameter doesn't result in an outage, with one exception. If
    /// the parameter change results in an option group that enables OEM, it can
    /// cause a brief period, lasting less than a second, during which new
    /// connections are rejected but existing connections aren't interrupted.
    ///
    /// The change is applied during the next maintenance window unless the
    /// `ApplyImmediately` parameter is enabled for this request.
    ///
    /// Permanent options, such as the TDE option for Oracle Advanced Security TDE,
    /// can't be removed from an option group, and that option group can't be
    /// removed from a DB instance after it is associated with a DB instance.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
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

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled, as determined by the `BackupRetentionPeriod` parameter.
    /// Changing this parameter doesn't result in an outage and the change is
    /// asynchronously applied as soon as possible. The default is a 30-minute
    /// window selected at random from an 8-hour block of time for each Amazon Web
    /// Services Region. For more information, see [Backup
    /// window](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to Amazon Aurora DB instances. The daily time
    /// range for creating automated backups is managed by the DB cluster. For more
    /// information, see `ModifyDBCluster`.
    ///
    /// Constraints:
    ///
    /// * Must be in the format `hh24:mi-hh24:mi`.
    /// * Must be in Universal Coordinated Time (UTC).
    /// * Must not conflict with the preferred maintenance window.
    /// * Must be at least 30 minutes.
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur, which might
    /// result in an outage. Changing this parameter doesn't result in an outage,
    /// except in the following situation, and the change is asynchronously applied
    /// as soon as possible. If there are pending actions that cause a reboot, and
    /// the maintenance window is changed to include the current time, then changing
    /// this parameter causes a reboot of the DB instance. If you change this window
    /// to the current time, there must be at least 30 minutes between the current
    /// time and end of the window to ensure pending changes are applied.
    ///
    /// For more information, see [Amazon RDS Maintenance
    /// Window](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#Concepts.DBMaintenance) in the *Amazon RDS User Guide.*
    ///
    /// Default: Uses existing setting
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
    /// This setting doesn't apply to RDS Custom DB instances.
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
    /// the DB instance's virtual private cloud (VPC), its Domain Name System (DNS)
    /// endpoint resolves to the public IP address. When you connect from within the
    /// same VPC as the DB instance, the endpoint resolves to the private IP
    /// address. Access to the DB instance is ultimately controlled by the security
    /// group it uses. That public access isn't permitted if the security group
    /// assigned to the DB instance doesn't permit it.
    ///
    /// When the DB instance isn't publicly accessible, it is an internal DB
    /// instance with a DNS name that resolves to a private IP address.
    ///
    /// `PubliclyAccessible` only applies to DB instances in a VPC. The DB instance
    /// must be part of a public subnet and `PubliclyAccessible` must be enabled for
    /// it to be publicly accessible.
    ///
    /// Changes to the `PubliclyAccessible` parameter are applied immediately
    /// regardless of the value of the `ApplyImmediately` parameter.
    publicly_accessible: ?bool = null,

    /// The open mode of a replica database.
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

    /// The number of minutes to pause the automation. When the time period ends,
    /// RDS Custom resumes full automation.
    ///
    /// Default: `60`
    ///
    /// Constraints:
    ///
    /// * Must be at least 60.
    /// * Must be no more than 1,440.
    resume_full_automation_mode_minutes: ?i32 = null,

    /// Specifies whether to rotate the secret managed by Amazon Web Services
    /// Secrets Manager for the master user password.
    ///
    /// This setting is valid only if the master user password is managed by RDS in
    /// Amazon Web Services Secrets Manager for the DB instance. The secret value
    /// contains the updated password.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide.*
    ///
    /// Constraints:
    ///
    /// * You must apply the change immediately when rotating the master user
    ///   password.
    rotate_master_user_password: ?bool = null,

    /// The storage throughput value for the DB instance.
    ///
    /// This setting applies only to the `gp3` storage type.
    ///
    /// This setting doesn't apply to Amazon Aurora or RDS Custom DB instances.
    storage_throughput: ?i32 = null,

    /// The storage type to associate with the DB instance.
    ///
    /// If you specify `io1`, `io2`, or `gp3` you must also include a value for the
    /// `Iops` parameter.
    ///
    /// If you choose to migrate your DB instance from using standard storage to gp2
    /// (General Purpose SSD), gp3, or Provisioned IOPS (io1), or from these storage
    /// types to standard storage, the process can take time. The duration of the
    /// migration depends on several factors such as database load, storage size,
    /// storage type (standard or Provisioned IOPS), amount of IOPS provisioned (if
    /// any), and the number of prior scale storage operations. Typical migration
    /// times are under 24 hours, but the process can take up to several days in
    /// some cases. During the migration, the DB instance is available for use, but
    /// might experience performance degradation. While the migration takes place,
    /// nightly backups for the instance are suspended. No other Amazon RDS
    /// operations can take place for the instance, including modifying the
    /// instance, rebooting the instance, deleting the instance, creating a read
    /// replica for the instance, and creating a DB snapshot of the instance.
    ///
    /// Valid Values: `gp2 | gp3 | io1 | io2 | standard`
    ///
    /// Default: `io1`, if the `Iops` parameter is specified. Otherwise, `gp2`.
    storage_type: ?[]const u8 = null,

    /// Tags to assign to resources associated with the DB instance.
    ///
    /// Valid Values:
    ///
    /// * `auto-backup` - The DB instance's automated backup.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ARN from the key store with which to associate the instance for TDE
    /// encryption.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    tde_credential_arn: ?[]const u8 = null,

    /// The password for the given ARN from the key store in order to access the
    /// device.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    tde_credential_password: ?[]const u8 = null,

    /// Specifies whether the DB instance class of the DB instance uses its default
    /// processor features.
    ///
    /// This setting doesn't apply to RDS Custom DB instances.
    use_default_processor_features: ?bool = null,

    /// A list of Amazon EC2 VPC security groups to associate with this DB instance.
    /// This change is asynchronously applied as soon as possible.
    ///
    /// This setting doesn't apply to the following DB instances:
    ///
    /// * Amazon Aurora (The associated list of EC2 VPC security groups is managed
    ///   by the DB cluster. For more information, see `ModifyDBCluster`.)
    /// * RDS Custom
    ///
    /// Constraints:
    ///
    /// * If supplied, must match existing VPC security group IDs.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const ModifyDBInstanceOutput = struct {
    db_instance: ?DBInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBInstanceInput, options: CallOptions) !ModifyDBInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyDBInstance&Version=2014-10-31");
    if (input.additional_storage_volumes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.AllocatedStorage=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.allocated_storage) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.IOPS=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.iops) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.MaxAllocatedStorage=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.max_allocated_storage) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.SetForDelete=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.set_for_delete) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.StorageThroughput=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.storage_throughput) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalStorageVolumes.member.{d}.StorageType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.storage_type) |fv_1| {
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
    if (input.allow_major_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AllowMajorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.apply_immediately) |v| {
        try body_buf.appendSlice(allocator, "&ApplyImmediately=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.automation_mode) |v| {
        try body_buf.appendSlice(allocator, "&AutomationMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.auto_minor_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AutoMinorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.aws_backup_recovery_point_arn) |v| {
        try body_buf.appendSlice(allocator, "&AwsBackupRecoveryPointArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.backup_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&BackupRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ca_certificate_identifier) |v| {
        try body_buf.appendSlice(allocator, "&CACertificateIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.certificate_rotation_restart) |v| {
        try body_buf.appendSlice(allocator, "&CertificateRotationRestart=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
    if (input.database_insights_mode) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseInsightsMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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
    if (input.db_port_number) |v| {
        try body_buf.appendSlice(allocator, "&DBPortNumber=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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
    if (input.dedicated_log_volume) |v| {
        try body_buf.appendSlice(allocator, "&DedicatedLogVolume=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(allocator, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.disable_domain) |v| {
        try body_buf.appendSlice(allocator, "&DisableDomain=");
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
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
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
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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
    if (input.network_type) |v| {
        try body_buf.appendSlice(allocator, "&NetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.new_db_instance_identifier) |v| {
        try body_buf.appendSlice(allocator, "&NewDBInstanceIdentifier=");
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
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProcessorFeatures.ProcessorFeature.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProcessorFeatures.ProcessorFeature.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
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
    if (input.replica_mode) |v| {
        try body_buf.appendSlice(allocator, "&ReplicaMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.resume_full_automation_mode_minutes) |v| {
        try body_buf.appendSlice(allocator, "&ResumeFullAutomationModeMinutes=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.rotate_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&RotateMasterUserPassword=");
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
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.Tag.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.Tag.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBInstanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBInstanceResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBInstanceOutput = .{};
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
