const ComputeModel = @import("compute_model.zig").ComputeModel;
const IamRole = @import("iam_role.zig").IamRole;
const LicenseModel = @import("license_model.zig").LicenseModel;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// A summary of an Autonomous VM cluster.
pub const CloudAutonomousVmClusterSummary = struct {
    /// The percentage of data storage currently in use for Autonomous Databases in
    /// the Autonomous VM cluster.
    autonomous_data_storage_percentage: ?f32,

    /// The total data storage allocated for Autonomous Databases in the Autonomous
    /// VM cluster, in TB.
    autonomous_data_storage_size_in_t_bs: ?f64,

    /// The available data storage for Autonomous Databases in the Autonomous VM
    /// cluster, in TB.
    available_autonomous_data_storage_size_in_t_bs: ?f64,

    /// The number of Autonomous Container Databases that you can create with the
    /// currently available storage.
    available_container_databases: ?i32,

    /// The number of CPU cores available for allocation to Autonomous Databases.
    available_cpus: ?f32,

    /// The Amazon Resource Name (ARN) for the Autonomous VM cluster.
    cloud_autonomous_vm_cluster_arn: ?[]const u8,

    /// The unique identifier of the Autonomous VM cluster.
    cloud_autonomous_vm_cluster_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Exadata infrastructure containing this
    /// Autonomous VM cluster.
    cloud_exadata_infrastructure_arn: ?[]const u8,

    /// The unique identifier of the Exadata infrastructure containing this
    /// Autonomous VM cluster.
    cloud_exadata_infrastructure_id: ?[]const u8,

    /// The compute model of the Autonomous VM cluster: ECPU or OCPU.
    compute_model: ?ComputeModel,

    /// The total number of CPU cores in the Autonomous VM cluster.
    cpu_core_count: ?i32,

    /// The number of CPU cores per node in the Autonomous VM cluster.
    cpu_core_count_per_node: ?i32,

    /// The percentage of total CPU cores currently in use in the Autonomous VM
    /// cluster.
    cpu_percentage: ?f32,

    /// The date and time when the Autonomous VM cluster was created.
    created_at: ?i64,

    /// The total data storage allocated to the Autonomous VM cluster, in GB.
    data_storage_size_in_g_bs: ?f64,

    /// The total data storage allocated to the Autonomous VM cluster, in TB.
    data_storage_size_in_t_bs: ?f64,

    /// The local node storage allocated to the Autonomous VM cluster, in GB.
    db_node_storage_size_in_g_bs: ?i32,

    /// The list of database servers associated with the Autonomous VM cluster.
    db_servers: ?[]const []const u8,

    /// The user-provided description of the Autonomous VM cluster.
    description: ?[]const u8,

    /// The user-friendly name for the Autonomous VM cluster.
    display_name: ?[]const u8,

    /// The domain name for the Autonomous VM cluster.
    domain: ?[]const u8,

    /// The lowest value to which Exadata storage can be scaled down, in TB.
    exadata_storage_in_t_bs_lowest_scaled_value: ?f64,

    /// The host name for the Autonomous VM cluster.
    hostname: ?[]const u8,

    /// The Amazon Web Services Identity and Access Management (IAM) service roles
    /// associated with the Autonomous VM cluster in the summary information.
    iam_roles: ?[]const IamRole,

    /// Indicates if mutual TLS (mTLS) authentication is enabled for the Autonomous
    /// VM cluster.
    is_mtls_enabled_vm_cluster: ?bool,

    /// The Oracle license model that applies to the Autonomous VM cluster.
    license_model: ?LicenseModel,

    /// The scheduling details for the maintenance window. Patching and system
    /// updates take place during the maintenance window.
    maintenance_window: ?MaintenanceWindow,

    /// The lowest value to which you can scale down the maximum number of
    /// Autonomous CDBs.
    max_acds_lowest_scaled_value: ?i32,

    /// The amount of memory allocated per Oracle Compute Unit (OCU), in GB.
    memory_per_oracle_compute_unit_in_g_bs: ?i32,

    /// The total amount of memory allocated to the Autonomous VM cluster, in GB.
    memory_size_in_g_bs: ?i32,

    /// The number of database server nodes in the Autonomous VM cluster.
    node_count: ?i32,

    /// The number of Autonomous CDBs that can't be provisioned because of resource
    /// constraints.
    non_provisionable_autonomous_container_databases: ?i32,

    /// The Oracle Cloud Identifier (OCID) of the Autonomous VM cluster.
    ocid: ?[]const u8,

    /// The name of the OCI resource anchor associated with this Autonomous VM
    /// cluster.
    oci_resource_anchor_name: ?[]const u8,

    /// The URL for accessing the OCI console page for this Autonomous VM cluster.
    oci_url: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the ODB network associated with this
    /// Autonomous VM cluster.
    odb_network_arn: ?[]const u8,

    /// The unique identifier of the ODB network associated with this Autonomous VM
    /// cluster.
    odb_network_id: ?[]const u8,

    /// The progress of the current operation on the Autonomous VM cluster, as a
    /// percentage.
    percent_progress: ?f32,

    /// The number of Autonomous CDBs that you can provision in the Autonomous VM
    /// cluster.
    provisionable_autonomous_container_databases: ?i32,

    /// The number of Autonomous Container Databases currently provisioned in the
    /// Autonomous VM cluster.
    provisioned_autonomous_container_databases: ?i32,

    /// The number of CPUs currently provisioned in the Autonomous VM cluster.
    provisioned_cpus: ?f32,

    /// The number of CPUs that can be reclaimed from terminated or scaled-down
    /// Autonomous Databases.
    reclaimable_cpus: ?f32,

    /// The number of CPUs reserved for system operations and redundancy.
    reserved_cpus: ?f32,

    /// The SCAN listener port for non-TLS (TCP) protocol.
    scan_listener_port_non_tls: ?i32,

    /// The SCAN listener port for TLS (TCP) protocol.
    scan_listener_port_tls: ?i32,

    /// The shape of the Exadata infrastructure for the Autonomous VM cluster.
    shape: ?[]const u8,

    /// The current status of the Autonomous VM cluster.
    status: ?ResourceStatus,

    /// Additional information about the current status of the Autonomous VM
    /// cluster, if applicable.
    status_reason: ?[]const u8,

    /// The expiration date and time of the database SSL certificate.
    time_database_ssl_certificate_expires: ?i64,

    /// The expiration date and time of the Oracle REST Data Services (ORDS)
    /// certificate.
    time_ords_certificate_expires: ?i64,

    /// The time zone of the Autonomous VM cluster.
    time_zone: ?[]const u8,

    /// The total number of Autonomous Container Databases that can be created in
    /// the Autonomous VM cluster.
    total_container_databases: ?i32,

    pub const json_field_names = .{
        .autonomous_data_storage_percentage = "autonomousDataStoragePercentage",
        .autonomous_data_storage_size_in_t_bs = "autonomousDataStorageSizeInTBs",
        .available_autonomous_data_storage_size_in_t_bs = "availableAutonomousDataStorageSizeInTBs",
        .available_container_databases = "availableContainerDatabases",
        .available_cpus = "availableCpus",
        .cloud_autonomous_vm_cluster_arn = "cloudAutonomousVmClusterArn",
        .cloud_autonomous_vm_cluster_id = "cloudAutonomousVmClusterId",
        .cloud_exadata_infrastructure_arn = "cloudExadataInfrastructureArn",
        .cloud_exadata_infrastructure_id = "cloudExadataInfrastructureId",
        .compute_model = "computeModel",
        .cpu_core_count = "cpuCoreCount",
        .cpu_core_count_per_node = "cpuCoreCountPerNode",
        .cpu_percentage = "cpuPercentage",
        .created_at = "createdAt",
        .data_storage_size_in_g_bs = "dataStorageSizeInGBs",
        .data_storage_size_in_t_bs = "dataStorageSizeInTBs",
        .db_node_storage_size_in_g_bs = "dbNodeStorageSizeInGBs",
        .db_servers = "dbServers",
        .description = "description",
        .display_name = "displayName",
        .domain = "domain",
        .exadata_storage_in_t_bs_lowest_scaled_value = "exadataStorageInTBsLowestScaledValue",
        .hostname = "hostname",
        .iam_roles = "iamRoles",
        .is_mtls_enabled_vm_cluster = "isMtlsEnabledVmCluster",
        .license_model = "licenseModel",
        .maintenance_window = "maintenanceWindow",
        .max_acds_lowest_scaled_value = "maxAcdsLowestScaledValue",
        .memory_per_oracle_compute_unit_in_g_bs = "memoryPerOracleComputeUnitInGBs",
        .memory_size_in_g_bs = "memorySizeInGBs",
        .node_count = "nodeCount",
        .non_provisionable_autonomous_container_databases = "nonProvisionableAutonomousContainerDatabases",
        .ocid = "ocid",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .oci_url = "ociUrl",
        .odb_network_arn = "odbNetworkArn",
        .odb_network_id = "odbNetworkId",
        .percent_progress = "percentProgress",
        .provisionable_autonomous_container_databases = "provisionableAutonomousContainerDatabases",
        .provisioned_autonomous_container_databases = "provisionedAutonomousContainerDatabases",
        .provisioned_cpus = "provisionedCpus",
        .reclaimable_cpus = "reclaimableCpus",
        .reserved_cpus = "reservedCpus",
        .scan_listener_port_non_tls = "scanListenerPortNonTls",
        .scan_listener_port_tls = "scanListenerPortTls",
        .shape = "shape",
        .status = "status",
        .status_reason = "statusReason",
        .time_database_ssl_certificate_expires = "timeDatabaseSslCertificateExpires",
        .time_ords_certificate_expires = "timeOrdsCertificateExpires",
        .time_zone = "timeZone",
        .total_container_databases = "totalContainerDatabases",
    };
};
