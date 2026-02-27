const ComputeModel = @import("compute_model.zig").ComputeModel;
const CustomerContact = @import("customer_contact.zig").CustomerContact;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Information about an Exadata infrastructure.
pub const CloudExadataInfrastructure = struct {
    /// The number of storage servers requested for the Exadata infrastructure.
    activated_storage_count: ?i32,

    /// The number of storage servers requested for the Exadata infrastructure.
    additional_storage_count: ?i32,

    /// The name of the Availability Zone (AZ) where the Exadata infrastructure is
    /// located.
    availability_zone: ?[]const u8,

    /// The AZ ID of the AZ where the Exadata infrastructure is located.
    availability_zone_id: ?[]const u8,

    /// The amount of available storage, in gigabytes (GB), for the Exadata
    /// infrastructure.
    available_storage_size_in_g_bs: ?i32,

    /// The Amazon Resource Name (ARN) for the Exadata infrastructure.
    cloud_exadata_infrastructure_arn: ?[]const u8,

    /// The unique identifier for the Exadata infrastructure.
    cloud_exadata_infrastructure_id: []const u8,

    /// The number of database servers for the Exadata infrastructure.
    compute_count: ?i32,

    /// The OCI model compute model used when you create or clone an instance: ECPU
    /// or OCPU. An ECPU is an abstracted measure of compute resources. ECPUs are
    /// based on the number of cores elastically allocated from a pool of compute
    /// and storage servers. An OCPU is a legacy physical measure of compute
    /// resources. OCPUs are based on the physical core of a processor with
    /// hyper-threading enabled.
    compute_model: ?ComputeModel,

    /// The total number of CPU cores that are allocated to the Exadata
    /// infrastructure.
    cpu_count: ?i32,

    /// The date and time when the Exadata infrastructure was created.
    created_at: ?i64,

    /// The email addresses of contacts to receive notification from Oracle about
    /// maintenance updates for the Exadata infrastructure.
    customer_contacts_to_send_to_oci: ?[]const CustomerContact,

    /// The database server model type of the Exadata infrastructure. For the list
    /// of valid model names, use the `ListDbSystemShapes` operation.
    database_server_type: ?[]const u8,

    /// The size of the Exadata infrastructure's data disk group, in terabytes (TB).
    data_storage_size_in_t_bs: ?f64,

    /// The size of the Exadata infrastructure's local node storage, in gigabytes
    /// (GB).
    db_node_storage_size_in_g_bs: ?i32,

    /// The software version of the database servers (dom0) in the Exadata
    /// infrastructure.
    db_server_version: ?[]const u8,

    /// The user-friendly name for the Exadata infrastructure.
    display_name: ?[]const u8,

    /// The Oracle Cloud Identifier (OCID) of the last maintenance run for the
    /// Exadata infrastructure.
    last_maintenance_run_id: ?[]const u8,

    /// The scheduling details for the maintenance window. Patching and system
    /// updates take place during the maintenance window.
    maintenance_window: ?MaintenanceWindow,

    /// The total number of CPU cores available on the Exadata infrastructure.
    max_cpu_count: ?i32,

    /// The total amount of data disk group storage, in terabytes (TB), that's
    /// available on the Exadata infrastructure.
    max_data_storage_in_t_bs: ?f64,

    /// The total amount of local node storage, in gigabytes (GB), that's available
    /// on the Exadata infrastructure.
    max_db_node_storage_size_in_g_bs: ?i32,

    /// The total amount of memory, in gigabytes (GB), that's available on the
    /// Exadata infrastructure.
    max_memory_in_g_bs: ?i32,

    /// The amount of memory, in gigabytes (GB), that's allocated on the Exadata
    /// infrastructure.
    memory_size_in_g_bs: ?i32,

    /// The monthly software version of the database servers installed on the
    /// Exadata infrastructure.
    monthly_db_server_version: ?[]const u8,

    /// The monthly software version of the storage servers installed on the Exadata
    /// infrastructure.
    monthly_storage_server_version: ?[]const u8,

    /// The OCID of the next maintenance run for the Exadata infrastructure.
    next_maintenance_run_id: ?[]const u8,

    /// The OCID of the Exadata infrastructure.
    ocid: ?[]const u8,

    /// The name of the OCI resource anchor for the Exadata infrastructure.
    oci_resource_anchor_name: ?[]const u8,

    /// The HTTPS link to the Exadata infrastructure in OCI.
    oci_url: ?[]const u8,

    /// The amount of progress made on the current operation on the Exadata
    /// infrastructure, expressed as a percentage.
    percent_progress: ?f32,

    /// The model name of the Exadata infrastructure.
    shape: ?[]const u8,

    /// The current status of the Exadata infrastructure.
    status: ?ResourceStatus,

    /// Additional information about the status of the Exadata infrastructure.
    status_reason: ?[]const u8,

    /// The number of storage servers that are activated for the Exadata
    /// infrastructure.
    storage_count: ?i32,

    /// The storage server model type of the Exadata infrastructure. For the list of
    /// valid model names, use the `ListDbSystemShapes` operation.
    storage_server_type: ?[]const u8,

    /// The software version of the storage servers on the Exadata infrastructure.
    storage_server_version: ?[]const u8,

    /// The total amount of storage, in gigabytes (GB), on the the Exadata
    /// infrastructure.
    total_storage_size_in_g_bs: ?i32,

    pub const json_field_names = .{
        .activated_storage_count = "activatedStorageCount",
        .additional_storage_count = "additionalStorageCount",
        .availability_zone = "availabilityZone",
        .availability_zone_id = "availabilityZoneId",
        .available_storage_size_in_g_bs = "availableStorageSizeInGBs",
        .cloud_exadata_infrastructure_arn = "cloudExadataInfrastructureArn",
        .cloud_exadata_infrastructure_id = "cloudExadataInfrastructureId",
        .compute_count = "computeCount",
        .compute_model = "computeModel",
        .cpu_count = "cpuCount",
        .created_at = "createdAt",
        .customer_contacts_to_send_to_oci = "customerContactsToSendToOCI",
        .database_server_type = "databaseServerType",
        .data_storage_size_in_t_bs = "dataStorageSizeInTBs",
        .db_node_storage_size_in_g_bs = "dbNodeStorageSizeInGBs",
        .db_server_version = "dbServerVersion",
        .display_name = "displayName",
        .last_maintenance_run_id = "lastMaintenanceRunId",
        .maintenance_window = "maintenanceWindow",
        .max_cpu_count = "maxCpuCount",
        .max_data_storage_in_t_bs = "maxDataStorageInTBs",
        .max_db_node_storage_size_in_g_bs = "maxDbNodeStorageSizeInGBs",
        .max_memory_in_g_bs = "maxMemoryInGBs",
        .memory_size_in_g_bs = "memorySizeInGBs",
        .monthly_db_server_version = "monthlyDbServerVersion",
        .monthly_storage_server_version = "monthlyStorageServerVersion",
        .next_maintenance_run_id = "nextMaintenanceRunId",
        .ocid = "ocid",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .oci_url = "ociUrl",
        .percent_progress = "percentProgress",
        .shape = "shape",
        .status = "status",
        .status_reason = "statusReason",
        .storage_count = "storageCount",
        .storage_server_type = "storageServerType",
        .storage_server_version = "storageServerVersion",
        .total_storage_size_in_g_bs = "totalStorageSizeInGBs",
    };
};
