const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdminPasswordSource = @import("admin_password_source.zig").AdminPasswordSource;
const AdminPasswordSourceConfigurationInput = @import("admin_password_source_configuration_input.zig").AdminPasswordSourceConfigurationInput;
const AutonomousMaintenanceScheduleType = @import("autonomous_maintenance_schedule_type.zig").AutonomousMaintenanceScheduleType;
const CustomerContact = @import("customer_contact.zig").CustomerContact;
const DatabaseEdition = @import("database_edition.zig").DatabaseEdition;
const DatabaseTool = @import("database_tool.zig").DatabaseTool;
const DbWorkload = @import("db_workload.zig").DbWorkload;
const EncryptionKeyConfigurationInput = @import("encryption_key_configuration_input.zig").EncryptionKeyConfigurationInput;
const EncryptionKeyProviderInput = @import("encryption_key_provider_input.zig").EncryptionKeyProviderInput;
const LicenseModel = @import("license_model.zig").LicenseModel;
const LongTermBackupSchedule = @import("long_term_backup_schedule.zig").LongTermBackupSchedule;
const OpenMode = @import("open_mode.zig").OpenMode;
const PermissionLevel = @import("permission_level.zig").PermissionLevel;
const RefreshableMode = @import("refreshable_mode.zig").RefreshableMode;
const ResourcePoolSummary = @import("resource_pool_summary.zig").ResourcePoolSummary;
const ScheduledOperationDetails = @import("scheduled_operation_details.zig").ScheduledOperationDetails;
const StandbyAllowlistedIpsSource = @import("standby_allowlisted_ips_source.zig").StandbyAllowlistedIpsSource;
const AutonomousDatabaseResourceStatus = @import("autonomous_database_resource_status.zig").AutonomousDatabaseResourceStatus;

pub const UpdateAutonomousDatabaseInput = struct {
    /// The new password for the `ADMIN` user of the Autonomous Database.
    admin_password: ?[]const u8 = null,

    /// The source of the admin password for the Autonomous Database. When set to
    /// `CUSTOMER_MANAGED_AWS_SECRET`, the admin password is retrieved from an
    /// Amazon Web Services Secrets Manager secret.
    admin_password_source: ?AdminPasswordSource = null,

    /// The configuration of the admin password source for the Autonomous Database.
    admin_password_source_configuration: ?AdminPasswordSourceConfigurationInput = null,

    /// The list of IP addresses that are allowed to access the Autonomous Database.
    allowlisted_ips: ?[]const []const u8 = null,

    /// The unique identifier of the Autonomous Database to update.
    autonomous_database_id: []const u8,

    /// The maintenance schedule type for the Autonomous Database.
    autonomous_maintenance_schedule_type: ?AutonomousMaintenanceScheduleType = null,

    /// The frequency, in seconds, at which the refreshable clone Autonomous
    /// Database is automatically refreshed.
    auto_refresh_frequency_in_seconds: ?i32 = null,

    /// The time lag, in seconds, between the refreshable clone and its source
    /// Autonomous Database.
    auto_refresh_point_lag_in_seconds: ?i32 = null,

    /// The retention period, in days, for automatic backups of the Autonomous
    /// Database.
    backup_retention_period_in_days: ?i32 = null,

    /// The maximum number of compute resources that you can allocate to the
    /// Autonomous Database under the bring-your-own-license (BYOL) model.
    byol_compute_count_limit: ?f64 = null,

    /// The compute capacity, in number of ECPUs or OCPUs, to assign to the
    /// Autonomous Database.
    compute_count: ?f64 = null,

    /// The number of CPU cores to allocate to the Autonomous Database.
    cpu_core_count: ?i32 = null,

    /// The list of customer contacts to receive operational notifications from OCI
    /// for the Autonomous Database.
    customer_contacts_to_send_to_oci: ?[]const CustomerContact = null,

    /// The Oracle Database edition to apply to the Autonomous Database.
    database_edition: ?DatabaseEdition = null,

    /// The size, in gigabytes (GB), of the data volume to allocate for the
    /// Autonomous Database.
    data_storage_size_in_g_bs: ?i32 = null,

    /// The size, in terabytes (TB), of the data volume to allocate for the
    /// Autonomous Database.
    data_storage_size_in_t_bs: ?i32 = null,

    /// The new name of the Autonomous Database.
    db_name: ?[]const u8 = null,

    /// The list of database management tools to enable for the Autonomous Database.
    db_tools_details: ?[]const DatabaseTool = null,

    /// The Oracle Database software version to use for the Autonomous Database.
    db_version: ?[]const u8 = null,

    /// The intended use of the Autonomous Database, such as transaction processing,
    /// data warehouse, JSON database, or APEX.
    db_workload: ?DbWorkload = null,

    /// The new user-friendly name for the Autonomous Database.
    display_name: ?[]const u8 = null,

    /// The configuration of the encryption key to use for the Autonomous Database.
    encryption_key_configuration: ?EncryptionKeyConfigurationInput = null,

    /// The provider of the encryption key to use for the Autonomous Database.
    encryption_key_provider: ?EncryptionKeyProviderInput = null,

    /// Specifies whether to enable automatic scaling of the compute resources for
    /// the Autonomous Database.
    is_auto_scaling_enabled: ?bool = null,

    /// Specifies whether to enable automatic scaling of the storage for the
    /// Autonomous Database.
    is_auto_scaling_for_storage_enabled: ?bool = null,

    /// Specifies whether to lock the backup retention period of the Autonomous
    /// Database to prevent it from being shortened.
    is_backup_retention_locked: ?bool = null,

    /// Specifies whether to disconnect the Autonomous Database from its peer
    /// database.
    is_disconnect_peer: ?bool = null,

    /// Specifies whether to enable local Oracle Data Guard for the Autonomous
    /// Database.
    is_local_data_guard_enabled: ?bool = null,

    /// Specifies whether mutual TLS (mTLS) authentication is required to connect to
    /// the Autonomous Database.
    is_mtls_connection_required: ?bool = null,

    /// Specifies whether the Autonomous Database is a refreshable clone.
    is_refreshable_clone: ?bool = null,

    /// The Oracle license model to apply to the Autonomous Database.
    license_model: ?LicenseModel = null,

    /// The maximum data loss limit, in seconds, for automatic failover to the local
    /// Oracle Data Guard standby database.
    local_adg_auto_failover_max_data_loss_limit: ?i32 = null,

    /// The long-term backup schedule for the Autonomous Database.
    long_term_backup_schedule: ?LongTermBackupSchedule = null,

    /// The mode in which to open the Autonomous Database, either read-only or
    /// read/write.
    open_mode: ?OpenMode = null,

    /// The unique identifier of the peer Autonomous Database.
    peer_db_id: ?[]const u8 = null,

    /// The permission level of the Autonomous Database.
    permission_level: ?PermissionLevel = null,

    /// The private endpoint IP address for the Autonomous Database.
    private_endpoint_ip: ?[]const u8 = null,

    /// The private endpoint label for the Autonomous Database.
    private_endpoint_label: ?[]const u8 = null,

    /// The refresh mode of the refreshable clone Autonomous Database.
    refreshable_mode: ?RefreshableMode = null,

    /// The unique identifier of the resource pool leader Autonomous Database.
    resource_pool_leader_id: ?[]const u8 = null,

    /// The configuration of the resource pool for the Autonomous Database.
    resource_pool_summary: ?ResourcePoolSummary = null,

    /// The list of scheduled start and stop times for the Autonomous Database.
    scheduled_operations: ?[]const ScheduledOperationDetails = null,

    /// The list of IP addresses that are allowed to access the standby Autonomous
    /// Database.
    standby_allowlisted_ips: ?[]const []const u8 = null,

    /// The source of the allowlisted IP addresses for the standby Autonomous
    /// Database.
    standby_allowlisted_ips_source: ?StandbyAllowlistedIpsSource = null,

    /// The date and time at which the automatic refresh of the refreshable clone
    /// Autonomous Database starts.
    time_of_auto_refresh_start: ?i64 = null,

    pub const json_field_names = .{
        .admin_password = "adminPassword",
        .admin_password_source = "adminPasswordSource",
        .admin_password_source_configuration = "adminPasswordSourceConfiguration",
        .allowlisted_ips = "allowlistedIps",
        .autonomous_database_id = "autonomousDatabaseId",
        .autonomous_maintenance_schedule_type = "autonomousMaintenanceScheduleType",
        .auto_refresh_frequency_in_seconds = "autoRefreshFrequencyInSeconds",
        .auto_refresh_point_lag_in_seconds = "autoRefreshPointLagInSeconds",
        .backup_retention_period_in_days = "backupRetentionPeriodInDays",
        .byol_compute_count_limit = "byolComputeCountLimit",
        .compute_count = "computeCount",
        .cpu_core_count = "cpuCoreCount",
        .customer_contacts_to_send_to_oci = "customerContactsToSendToOCI",
        .database_edition = "databaseEdition",
        .data_storage_size_in_g_bs = "dataStorageSizeInGBs",
        .data_storage_size_in_t_bs = "dataStorageSizeInTBs",
        .db_name = "dbName",
        .db_tools_details = "dbToolsDetails",
        .db_version = "dbVersion",
        .db_workload = "dbWorkload",
        .display_name = "displayName",
        .encryption_key_configuration = "encryptionKeyConfiguration",
        .encryption_key_provider = "encryptionKeyProvider",
        .is_auto_scaling_enabled = "isAutoScalingEnabled",
        .is_auto_scaling_for_storage_enabled = "isAutoScalingForStorageEnabled",
        .is_backup_retention_locked = "isBackupRetentionLocked",
        .is_disconnect_peer = "isDisconnectPeer",
        .is_local_data_guard_enabled = "isLocalDataGuardEnabled",
        .is_mtls_connection_required = "isMtlsConnectionRequired",
        .is_refreshable_clone = "isRefreshableClone",
        .license_model = "licenseModel",
        .local_adg_auto_failover_max_data_loss_limit = "localAdgAutoFailoverMaxDataLossLimit",
        .long_term_backup_schedule = "longTermBackupSchedule",
        .open_mode = "openMode",
        .peer_db_id = "peerDbId",
        .permission_level = "permissionLevel",
        .private_endpoint_ip = "privateEndpointIp",
        .private_endpoint_label = "privateEndpointLabel",
        .refreshable_mode = "refreshableMode",
        .resource_pool_leader_id = "resourcePoolLeaderId",
        .resource_pool_summary = "resourcePoolSummary",
        .scheduled_operations = "scheduledOperations",
        .standby_allowlisted_ips = "standbyAllowlistedIps",
        .standby_allowlisted_ips_source = "standbyAllowlistedIpsSource",
        .time_of_auto_refresh_start = "timeOfAutoRefreshStart",
    };
};

pub const UpdateAutonomousDatabaseOutput = struct {
    /// The unique identifier of the Autonomous Database that was updated.
    autonomous_database_id: []const u8,

    /// The user-friendly name of the Autonomous Database that was updated.
    display_name: ?[]const u8 = null,

    /// The current status of the Autonomous Database.
    status: ?AutonomousDatabaseResourceStatus = null,

    /// Additional information about the current status of the Autonomous Database,
    /// if applicable.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .autonomous_database_id = "autonomousDatabaseId",
        .display_name = "displayName",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAutonomousDatabaseInput, options: CallOptions) !UpdateAutonomousDatabaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAutonomousDatabaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.UpdateAutonomousDatabase");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAutonomousDatabaseOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateAutonomousDatabaseOutput, body, allocator);
}
