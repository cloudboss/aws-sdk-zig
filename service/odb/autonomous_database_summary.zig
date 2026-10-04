const AdminPasswordSourceSummary = @import("admin_password_source_summary.zig").AdminPasswordSourceSummary;
const AutonomousDatabaseApex = @import("autonomous_database_apex.zig").AutonomousDatabaseApex;
const AutonomousMaintenanceScheduleType = @import("autonomous_maintenance_schedule_type.zig").AutonomousMaintenanceScheduleType;
const ComputeModel = @import("compute_model.zig").ComputeModel;
const AutonomousDatabaseConnectionStrings = @import("autonomous_database_connection_strings.zig").AutonomousDatabaseConnectionStrings;
const AutonomousDatabaseConnectionUrls = @import("autonomous_database_connection_urls.zig").AutonomousDatabaseConnectionUrls;
const CustomerContact = @import("customer_contact.zig").CustomerContact;
const DatabaseEdition = @import("database_edition.zig").DatabaseEdition;
const DatabaseManagementStatus = @import("database_management_status.zig").DatabaseManagementStatus;
const DatabaseType = @import("database_type.zig").DatabaseType;
const DataSafeStatus = @import("data_safe_status.zig").DataSafeStatus;
const DatabaseTool = @import("database_tool.zig").DatabaseTool;
const DbWorkload = @import("db_workload.zig").DbWorkload;
const EncryptionSummary = @import("encryption_summary.zig").EncryptionSummary;
const LicenseModel = @import("license_model.zig").LicenseModel;
const DisasterRecoveryType = @import("disaster_recovery_type.zig").DisasterRecoveryType;
const DatabaseStandbySummary = @import("database_standby_summary.zig").DatabaseStandbySummary;
const LongTermBackupSchedule = @import("long_term_backup_schedule.zig").LongTermBackupSchedule;
const NetServicesArchitecture = @import("net_services_architecture.zig").NetServicesArchitecture;
const OpenMode = @import("open_mode.zig").OpenMode;
const OperationsInsightsStatus = @import("operations_insights_status.zig").OperationsInsightsStatus;
const PermissionLevel = @import("permission_level.zig").PermissionLevel;
const RefreshableMode = @import("refreshable_mode.zig").RefreshableMode;
const RefreshableStatus = @import("refreshable_status.zig").RefreshableStatus;
const DisasterRecoveryConfiguration = @import("disaster_recovery_configuration.zig").DisasterRecoveryConfiguration;
const ResourcePoolSummary = @import("resource_pool_summary.zig").ResourcePoolSummary;
const DataGuardRole = @import("data_guard_role.zig").DataGuardRole;
const ScheduledOperationDetails = @import("scheduled_operation_details.zig").ScheduledOperationDetails;
const StandbyAllowlistedIpsSource = @import("standby_allowlisted_ips_source.zig").StandbyAllowlistedIpsSource;
const AutonomousDatabaseResourceStatus = @import("autonomous_database_resource_status.zig").AutonomousDatabaseResourceStatus;

/// A summary of an Autonomous Database.
pub const AutonomousDatabaseSummary = struct {
    /// The actual amount of data storage currently in use by the Autonomous
    /// Database, in TB.
    actual_used_data_storage_size_in_t_bs: ?f64 = null,

    /// The summary of the admin password source configuration for the Autonomous
    /// Database.
    admin_password_source_summary: ?AdminPasswordSourceSummary = null,

    /// The amount of storage currently allocated to the Autonomous Database, in TB.
    allocated_storage_size_in_t_bs: ?f64 = null,

    /// The list of IP addresses that are allowed to access the Autonomous Database.
    allowlisted_ips: ?[]const []const u8 = null,

    /// The Oracle Application Express (APEX) details for the Autonomous Database.
    apex_details: ?AutonomousDatabaseApex = null,

    /// The Amazon Resource Name (ARN) of the Autonomous Database.
    autonomous_database_arn: ?[]const u8 = null,

    /// The unique identifier of the Autonomous Database.
    autonomous_database_id: ?[]const u8 = null,

    /// The maintenance schedule type for the Autonomous Database.
    autonomous_maintenance_schedule_type: ?AutonomousMaintenanceScheduleType = null,

    /// The frequency, in seconds, at which the refreshable clone Autonomous
    /// Database is automatically refreshed.
    auto_refresh_frequency_in_seconds: ?i32 = null,

    /// The time lag, in seconds, between the refreshable clone and its source
    /// Autonomous Database.
    auto_refresh_point_lag_in_seconds: ?i32 = null,

    /// The Availability Zone where the Autonomous Database is located.
    availability_zone: ?[]const u8 = null,

    /// The unique identifier of the Availability Zone where the Autonomous Database
    /// is located.
    availability_zone_id: ?[]const u8 = null,

    /// The list of Oracle Database software versions to which the Autonomous
    /// Database can be upgraded.
    available_upgrade_versions: ?[]const []const u8 = null,

    /// The retention period, in days, for automatic backups of the Autonomous
    /// Database.
    backup_retention_period_in_days: ?i32 = null,

    /// The maximum number of compute resources that you can allocate to the
    /// Autonomous Database under the bring-your-own-license (BYOL) model.
    byol_compute_count_limit: ?i32 = null,

    /// The character set of the Autonomous Database.
    character_set: ?[]const u8 = null,

    /// The list of tablespace identifiers to clone for the Autonomous Database.
    clone_table_space_list: ?[]const i32 = null,

    /// The compute capacity, in number of Elastic CPUs (ECPUs) or Oracle CPUs
    /// (OCPUs), assigned to the Autonomous Database.
    compute_count: ?f32 = null,

    /// The compute model of the Autonomous Database, either ECPU or OCPU.
    compute_model: ?ComputeModel = null,

    /// The connection string details for the Autonomous Database.
    connection_string_details: ?AutonomousDatabaseConnectionStrings = null,

    /// The connection URLs for accessing tools and services for the Autonomous
    /// Database.
    connection_urls: ?AutonomousDatabaseConnectionUrls = null,

    /// The number of CPU cores allocated to the Autonomous Database.
    cpu_core_count: ?i32 = null,

    /// The date and time when the Autonomous Database was created.
    created_at: ?i64 = null,

    /// The list of customer contacts that receive operational notifications from
    /// Oracle for the Autonomous Database.
    customer_contacts: ?[]const CustomerContact = null,

    /// The Oracle Database edition of the Autonomous Database.
    database_edition: ?DatabaseEdition = null,

    /// The status of Oracle Database Management for the Autonomous Database.
    database_management_status: ?DatabaseManagementStatus = null,

    /// The type of the Autonomous Database, either a regular database or a clone.
    database_type: ?DatabaseType = null,

    /// The status of the Oracle Data Safe registration for the Autonomous Database.
    data_safe_status: ?DataSafeStatus = null,

    /// The size, in gigabytes (GB), of the data volume allocated for the Autonomous
    /// Database.
    data_storage_size_in_g_bs: ?i32 = null,

    /// The size, in terabytes (TB), of the data volume allocated for the Autonomous
    /// Database.
    data_storage_size_in_t_bs: ?f64 = null,

    /// The name of the Autonomous Database.
    db_name: ?[]const u8 = null,

    /// The list of database management tools enabled for the Autonomous Database.
    db_tools_details: ?[]const DatabaseTool = null,

    /// The Oracle Database software version of the Autonomous Database.
    db_version: ?[]const u8 = null,

    /// The intended use of the Autonomous Database, such as transaction processing,
    /// data warehouse, JSON database, or APEX.
    db_workload: ?DbWorkload = null,

    /// The user-friendly name of the Autonomous Database.
    display_name: ?[]const u8 = null,

    /// The encryption configuration for the Autonomous Database.
    encryption_summary: ?EncryptionSummary = null,

    /// The amount of time, in seconds, that the data in the Autonomous Database is
    /// behind the data in the primary database.
    failed_data_recovery_in_seconds: ?i32 = null,

    /// The size of the in-memory area of the Autonomous Database, in GB.
    in_memory_area_in_g_bs: ?i32 = null,

    /// Indicates whether automatic scaling of the compute resources is enabled for
    /// the Autonomous Database.
    is_auto_scaling_enabled: ?bool = null,

    /// Indicates whether automatic scaling of the storage is enabled for the
    /// Autonomous Database.
    is_auto_scaling_for_storage_enabled: ?bool = null,

    /// Indicates whether the backup retention period of the Autonomous Database is
    /// locked.
    is_backup_retention_locked: ?bool = null,

    /// Indicates whether local Oracle Data Guard is enabled for the Autonomous
    /// Database.
    is_local_data_guard_enabled: ?bool = null,

    /// Indicates whether mutual TLS (mTLS) authentication is required to connect to
    /// the Autonomous Database.
    is_mtls_connection_required: ?bool = null,

    /// Indicates whether reconnecting the refreshable clone to its source
    /// Autonomous Database is enabled.
    is_reconnect_clone_enabled: ?bool = null,

    /// Indicates whether the Autonomous Database is a refreshable clone.
    is_refreshable_clone: ?bool = null,

    /// Indicates whether remote Oracle Data Guard is enabled for the Autonomous
    /// Database.
    is_remote_data_guard_enabled: ?bool = null,

    /// The Oracle license model that applies to the Autonomous Database.
    license_model: ?LicenseModel = null,

    /// The maximum data loss limit, in seconds, for automatic failover to the local
    /// Oracle Data Guard standby database.
    local_adg_auto_failover_max_data_loss_limit: ?i32 = null,

    /// The type of local disaster recovery configured for the Autonomous Database.
    local_disaster_recovery_type: ?DisasterRecoveryType = null,

    /// The details of the local standby Autonomous Database in an Oracle Data Guard
    /// configuration.
    local_standby_db: ?DatabaseStandbySummary = null,

    /// The long-term backup schedule for the Autonomous Database.
    long_term_backup_schedule: ?LongTermBackupSchedule = null,

    /// The component on the Autonomous Database that the current maintenance is
    /// being applied to.
    maintenance_target_component: ?[]const u8 = null,

    /// The amount of memory allocated per Oracle Compute Unit, in GB.
    memory_per_oracle_compute_unit_in_g_bs: ?i32 = null,

    /// The national character set of the Autonomous Database.
    ncharacter_set: ?[]const u8 = null,

    /// The Oracle Net Services architecture of the Autonomous Database, either
    /// dedicated or shared.
    net_services_architecture: ?NetServicesArchitecture = null,

    /// The date and time of the next scheduled long-term backup of the Autonomous
    /// Database.
    next_long_term_backup_time_stamp: ?i64 = null,

    /// The Oracle Cloud Identifier (OCID) of the Autonomous Database.
    ocid: ?[]const u8 = null,

    /// The name of the Oracle Cloud Infrastructure (OCI) resource anchor associated
    /// with the Autonomous Database.
    oci_resource_anchor_name: ?[]const u8 = null,

    /// The URL for accessing the OCI console page for the Autonomous Database.
    oci_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the ODB network associated with the
    /// Autonomous Database.
    odb_network_arn: ?[]const u8 = null,

    /// The unique identifier of the ODB network associated with the Autonomous
    /// Database.
    odb_network_id: ?[]const u8 = null,

    /// The mode in which the Autonomous Database is open, either read-only or
    /// read/write.
    open_mode: ?OpenMode = null,

    /// The status of Oracle Operations Insights for the Autonomous Database.
    operations_insights_status: ?OperationsInsightsStatus = null,

    /// The list of unique identifiers of the peer Autonomous Databases.
    peer_db_ids: ?[]const []const u8 = null,

    /// The progress of the current operation on the Autonomous Database, as a
    /// percentage.
    percent_progress: ?f32 = null,

    /// The permission level of the Autonomous Database.
    permission_level: ?PermissionLevel = null,

    /// The private endpoint for the Autonomous Database.
    private_endpoint: ?[]const u8 = null,

    /// The private endpoint IP address for the Autonomous Database.
    private_endpoint_ip: ?[]const u8 = null,

    /// The private endpoint label for the Autonomous Database.
    private_endpoint_label: ?[]const u8 = null,

    /// The list of CPU core counts that you can provision for the Autonomous
    /// Database.
    provisionable_cpus: ?[]const i32 = null,

    /// The refresh mode of the refreshable clone Autonomous Database.
    refreshable_mode: ?RefreshableMode = null,

    /// The refresh status of the refreshable clone Autonomous Database.
    refreshable_status: ?RefreshableStatus = null,

    /// The configuration of the remote disaster recovery for the Autonomous
    /// Database.
    remote_disaster_recovery_configuration: ?DisasterRecoveryConfiguration = null,

    /// The unique identifier of the resource pool leader Autonomous Database.
    resource_pool_leader_id: ?[]const u8 = null,

    /// The configuration of the resource pool for the Autonomous Database.
    resource_pool_summary: ?ResourcePoolSummary = null,

    /// The Oracle Data Guard role of the Autonomous Database.
    role: ?DataGuardRole = null,

    /// The list of scheduled start and stop times for the Autonomous Database.
    scheduled_operations: ?[]const ScheduledOperationDetails = null,

    /// The URL for accessing the Oracle service console for the Autonomous
    /// Database.
    service_console_url: ?[]const u8 = null,

    /// The unique identifier of the source from which the Autonomous Database was
    /// created.
    source_id: ?[]const u8 = null,

    /// The URL for accessing Oracle SQL Developer Web for the Autonomous Database.
    sql_web_developer_url: ?[]const u8 = null,

    /// The list of IP addresses that are allowed to access the standby Autonomous
    /// Database.
    standby_allowlisted_ips: ?[]const []const u8 = null,

    /// The source of the allowlisted IP addresses for the standby Autonomous
    /// Database.
    standby_allowlisted_ips_source: ?StandbyAllowlistedIpsSource = null,

    /// The details of the standby Autonomous Database in a cross-Region Oracle Data
    /// Guard configuration.
    standby_db: ?DatabaseStandbySummary = null,

    /// The current status of the Autonomous Database.
    status: ?AutonomousDatabaseResourceStatus = null,

    /// Additional information about the current status of the Autonomous Database,
    /// if applicable.
    status_reason: ?[]const u8 = null,

    /// The date and time when the Oracle Data Guard role of the Autonomous Database
    /// last changed.
    time_data_guard_role_changed: ?i64 = null,

    /// The date and time when the inactive Always Free Autonomous Database is
    /// scheduled to be automatically deleted.
    time_deletion_of_free_autonomous_database: ?i64 = null,

    /// The date and time when the disaster recovery role of the Autonomous Database
    /// last changed.
    time_disaster_recovery_role_changed: ?i64 = null,

    /// The date and time when local Oracle Data Guard was enabled for the
    /// Autonomous Database.
    time_local_data_guard_enabled: ?i64 = null,

    /// The date and time when the next maintenance of the Autonomous Database
    /// begins.
    time_maintenance_begin: ?i64 = null,

    /// The date and time when the next maintenance of the Autonomous Database ends.
    time_maintenance_end: ?i64 = null,

    /// The date and time at which the automatic refresh of the refreshable clone
    /// Autonomous Database starts.
    time_of_auto_refresh_start: ?i64 = null,

    /// The date and time of the last backup of the Autonomous Database.
    time_of_last_backup: ?i64 = null,

    /// The date and time of the last failover operation for the Autonomous
    /// Database.
    time_of_last_failover: ?i64 = null,

    /// The date and time of the last refresh of the refreshable clone Autonomous
    /// Database.
    time_of_last_refresh: ?i64 = null,

    /// The date and time as of which the data in the refreshable clone Autonomous
    /// Database is current.
    time_of_last_refresh_point: ?i64 = null,

    /// The date and time of the last switchover operation for the Autonomous
    /// Database.
    time_of_last_switchover: ?i64 = null,

    /// The date and time of the next scheduled refresh of the refreshable clone
    /// Autonomous Database.
    time_of_next_refresh: ?i64 = null,

    /// The date and time when the Always Free Autonomous Database is scheduled to
    /// be stopped because of inactivity.
    time_reclamation_of_free_autonomous_database: ?i64 = null,

    /// The date and time when the Autonomous Database was restored after deletion.
    time_undeleted: ?i64 = null,

    /// The date and time until which reconnecting the refreshable clone to its
    /// source Autonomous Database is allowed.
    time_until_reconnect_clone_enabled: ?i64 = null,

    /// The total amount of backup storage used by the Autonomous Database, in GB.
    total_backup_storage_size_in_g_bs: ?f64 = null,

    /// The amount of data storage currently in use by the Autonomous Database, in
    /// GB.
    used_data_storage_size_in_g_bs: ?i32 = null,

    /// The amount of data storage currently in use by the Autonomous Database, in
    /// TB.
    used_data_storage_size_in_t_bs: ?f64 = null,

    pub const json_field_names = .{
        .actual_used_data_storage_size_in_t_bs = "actualUsedDataStorageSizeInTBs",
        .admin_password_source_summary = "adminPasswordSourceSummary",
        .allocated_storage_size_in_t_bs = "allocatedStorageSizeInTBs",
        .allowlisted_ips = "allowlistedIps",
        .apex_details = "apexDetails",
        .autonomous_database_arn = "autonomousDatabaseArn",
        .autonomous_database_id = "autonomousDatabaseId",
        .autonomous_maintenance_schedule_type = "autonomousMaintenanceScheduleType",
        .auto_refresh_frequency_in_seconds = "autoRefreshFrequencyInSeconds",
        .auto_refresh_point_lag_in_seconds = "autoRefreshPointLagInSeconds",
        .availability_zone = "availabilityZone",
        .availability_zone_id = "availabilityZoneId",
        .available_upgrade_versions = "availableUpgradeVersions",
        .backup_retention_period_in_days = "backupRetentionPeriodInDays",
        .byol_compute_count_limit = "byolComputeCountLimit",
        .character_set = "characterSet",
        .clone_table_space_list = "cloneTableSpaceList",
        .compute_count = "computeCount",
        .compute_model = "computeModel",
        .connection_string_details = "connectionStringDetails",
        .connection_urls = "connectionUrls",
        .cpu_core_count = "cpuCoreCount",
        .created_at = "createdAt",
        .customer_contacts = "customerContacts",
        .database_edition = "databaseEdition",
        .database_management_status = "databaseManagementStatus",
        .database_type = "databaseType",
        .data_safe_status = "dataSafeStatus",
        .data_storage_size_in_g_bs = "dataStorageSizeInGBs",
        .data_storage_size_in_t_bs = "dataStorageSizeInTBs",
        .db_name = "dbName",
        .db_tools_details = "dbToolsDetails",
        .db_version = "dbVersion",
        .db_workload = "dbWorkload",
        .display_name = "displayName",
        .encryption_summary = "encryptionSummary",
        .failed_data_recovery_in_seconds = "failedDataRecoveryInSeconds",
        .in_memory_area_in_g_bs = "inMemoryAreaInGBs",
        .is_auto_scaling_enabled = "isAutoScalingEnabled",
        .is_auto_scaling_for_storage_enabled = "isAutoScalingForStorageEnabled",
        .is_backup_retention_locked = "isBackupRetentionLocked",
        .is_local_data_guard_enabled = "isLocalDataGuardEnabled",
        .is_mtls_connection_required = "isMtlsConnectionRequired",
        .is_reconnect_clone_enabled = "isReconnectCloneEnabled",
        .is_refreshable_clone = "isRefreshableClone",
        .is_remote_data_guard_enabled = "isRemoteDataGuardEnabled",
        .license_model = "licenseModel",
        .local_adg_auto_failover_max_data_loss_limit = "localAdgAutoFailoverMaxDataLossLimit",
        .local_disaster_recovery_type = "localDisasterRecoveryType",
        .local_standby_db = "localStandbyDb",
        .long_term_backup_schedule = "longTermBackupSchedule",
        .maintenance_target_component = "maintenanceTargetComponent",
        .memory_per_oracle_compute_unit_in_g_bs = "memoryPerOracleComputeUnitInGBs",
        .ncharacter_set = "ncharacterSet",
        .net_services_architecture = "netServicesArchitecture",
        .next_long_term_backup_time_stamp = "nextLongTermBackupTimeStamp",
        .ocid = "ocid",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .oci_url = "ociUrl",
        .odb_network_arn = "odbNetworkArn",
        .odb_network_id = "odbNetworkId",
        .open_mode = "openMode",
        .operations_insights_status = "operationsInsightsStatus",
        .peer_db_ids = "peerDbIds",
        .percent_progress = "percentProgress",
        .permission_level = "permissionLevel",
        .private_endpoint = "privateEndpoint",
        .private_endpoint_ip = "privateEndpointIp",
        .private_endpoint_label = "privateEndpointLabel",
        .provisionable_cpus = "provisionableCpus",
        .refreshable_mode = "refreshableMode",
        .refreshable_status = "refreshableStatus",
        .remote_disaster_recovery_configuration = "remoteDisasterRecoveryConfiguration",
        .resource_pool_leader_id = "resourcePoolLeaderId",
        .resource_pool_summary = "resourcePoolSummary",
        .role = "role",
        .scheduled_operations = "scheduledOperations",
        .service_console_url = "serviceConsoleUrl",
        .source_id = "sourceId",
        .sql_web_developer_url = "sqlWebDeveloperUrl",
        .standby_allowlisted_ips = "standbyAllowlistedIps",
        .standby_allowlisted_ips_source = "standbyAllowlistedIpsSource",
        .standby_db = "standbyDb",
        .status = "status",
        .status_reason = "statusReason",
        .time_data_guard_role_changed = "timeDataGuardRoleChanged",
        .time_deletion_of_free_autonomous_database = "timeDeletionOfFreeAutonomousDatabase",
        .time_disaster_recovery_role_changed = "timeDisasterRecoveryRoleChanged",
        .time_local_data_guard_enabled = "timeLocalDataGuardEnabled",
        .time_maintenance_begin = "timeMaintenanceBegin",
        .time_maintenance_end = "timeMaintenanceEnd",
        .time_of_auto_refresh_start = "timeOfAutoRefreshStart",
        .time_of_last_backup = "timeOfLastBackup",
        .time_of_last_failover = "timeOfLastFailover",
        .time_of_last_refresh = "timeOfLastRefresh",
        .time_of_last_refresh_point = "timeOfLastRefreshPoint",
        .time_of_last_switchover = "timeOfLastSwitchover",
        .time_of_next_refresh = "timeOfNextRefresh",
        .time_reclamation_of_free_autonomous_database = "timeReclamationOfFreeAutonomousDatabase",
        .time_undeleted = "timeUndeleted",
        .time_until_reconnect_clone_enabled = "timeUntilReconnectCloneEnabled",
        .total_backup_storage_size_in_g_bs = "totalBackupStorageSizeInGBs",
        .used_data_storage_size_in_g_bs = "usedDataStorageSizeInGBs",
        .used_data_storage_size_in_t_bs = "usedDataStorageSizeInTBs",
    };
};
