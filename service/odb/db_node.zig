const DbNodeMaintenanceType = @import("db_node_maintenance_type.zig").DbNodeMaintenanceType;
const DbNodeResourceStatus = @import("db_node_resource_status.zig").DbNodeResourceStatus;

/// Information about a DB node.
pub const DbNode = struct {
    /// Additional information about the planned maintenance.
    additional_details: ?[]const u8 = null,

    /// The Oracle Cloud ID (OCID) of the backup IP address that's associated with
    /// the DB node.
    backup_ip_id: ?[]const u8 = null,

    /// The OCID of the second backup VNIC.
    backup_vnic_2_id: ?[]const u8 = null,

    /// The OCID of the backup VNIC.
    backup_vnic_id: ?[]const u8 = null,

    /// Number of CPU cores enabled on the DB node.
    cpu_core_count: ?i32 = null,

    /// The date and time when the DB node was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the DB node.
    db_node_arn: ?[]const u8 = null,

    /// The unique identifier of the DB node.
    db_node_id: ?[]const u8 = null,

    /// The amount of local node storage, in gigabytes (GBs), that's allocated on
    /// the DB node.
    db_node_storage_size_in_g_bs: ?i32 = null,

    /// The unique identifier of the Db server that is associated with the DB node.
    db_server_id: ?[]const u8 = null,

    /// The OCID of the DB system.
    db_system_id: ?[]const u8 = null,

    /// The name of the fault domain the instance is contained in.
    fault_domain: ?[]const u8 = null,

    /// The floating IP address assigned to the DB node.
    floating_ip_address: ?[]const u8 = null,

    /// The OCID of the host IP address that's associated with the DB node.
    host_ip_id: ?[]const u8 = null,

    /// The host name for the DB node.
    hostname: ?[]const u8 = null,

    /// The type of database node maintenance. Either `VMDB_REBOOT_MIGRATION` or
    /// `EXADBXS_REBOOT_MIGRATION`.
    maintenance_type: ?DbNodeMaintenanceType = null,

    /// The allocated memory in GBs on the DB node.
    memory_size_in_g_bs: ?i32 = null,

    /// The OCID of the DB node.
    ocid: ?[]const u8 = null,

    /// The name of the OCI resource anchor for the DB node.
    oci_resource_anchor_name: ?[]const u8 = null,

    /// The private IP address assigned to the DB node.
    private_ip_address: ?[]const u8 = null,

    /// The size (in GB) of the block storage volume allocation for the DB system.
    software_storage_size_in_gb: ?i32 = null,

    /// The current status of the DB node.
    status: ?DbNodeResourceStatus = null,

    /// Additional information about the status of the DB node.
    status_reason: ?[]const u8 = null,

    /// End date and time of maintenance window.
    time_maintenance_window_end: ?[]const u8 = null,

    /// Start date and time of maintenance window.
    time_maintenance_window_start: ?[]const u8 = null,

    /// The total number of CPU cores reserved on the DB node.
    total_cpu_core_count: ?i32 = null,

    /// The OCID of the second VNIC.
    vnic_2_id: ?[]const u8 = null,

    /// The OCID of the VNIC.
    vnic_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_details = "additionalDetails",
        .backup_ip_id = "backupIpId",
        .backup_vnic_2_id = "backupVnic2Id",
        .backup_vnic_id = "backupVnicId",
        .cpu_core_count = "cpuCoreCount",
        .created_at = "createdAt",
        .db_node_arn = "dbNodeArn",
        .db_node_id = "dbNodeId",
        .db_node_storage_size_in_g_bs = "dbNodeStorageSizeInGBs",
        .db_server_id = "dbServerId",
        .db_system_id = "dbSystemId",
        .fault_domain = "faultDomain",
        .floating_ip_address = "floatingIpAddress",
        .host_ip_id = "hostIpId",
        .hostname = "hostname",
        .maintenance_type = "maintenanceType",
        .memory_size_in_g_bs = "memorySizeInGBs",
        .ocid = "ocid",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .private_ip_address = "privateIpAddress",
        .software_storage_size_in_gb = "softwareStorageSizeInGB",
        .status = "status",
        .status_reason = "statusReason",
        .time_maintenance_window_end = "timeMaintenanceWindowEnd",
        .time_maintenance_window_start = "timeMaintenanceWindowStart",
        .total_cpu_core_count = "totalCpuCoreCount",
        .vnic_2_id = "vnic2Id",
        .vnic_id = "vnicId",
    };
};
