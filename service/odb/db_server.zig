const ComputeModel = @import("compute_model.zig").ComputeModel;
const DbServerPatchingDetails = @import("db_server_patching_details.zig").DbServerPatchingDetails;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Information about a database server.
pub const DbServer = struct {
    /// The list of unique identifiers for the Autonomous VMs associated with this
    /// database server.
    autonomous_virtual_machine_ids: ?[]const []const u8,

    /// The list of identifiers for the Autonomous VM clusters associated with this
    /// database server.
    autonomous_vm_cluster_ids: ?[]const []const u8,

    /// The compute model of the database server (ECPU or OCPU).
    compute_model: ?ComputeModel,

    /// The number of CPU cores enabled on the database server.
    cpu_core_count: ?i32,

    /// The date and time when the database server was created.
    created_at: ?i64,

    /// The allocated local node storage in GBs on the database server.
    db_node_storage_size_in_g_bs: ?i32,

    /// The unique identifier for the database server.
    db_server_id: ?[]const u8,

    /// The scheduling details for the quarterly maintenance window. Patching and
    /// system updates take place during the maintenance window.
    db_server_patching_details: ?DbServerPatchingDetails,

    /// The user-friendly name of the database server.
    display_name: ?[]const u8,

    /// The ID of the Exadata infrastructure the database server belongs to.
    exadata_infrastructure_id: ?[]const u8,

    /// The total number of CPU cores available.
    max_cpu_count: ?i32,

    /// The total local node storage available in GBs.
    max_db_node_storage_in_g_bs: ?i32,

    /// The total memory available in GBs.
    max_memory_in_g_bs: ?i32,

    /// The allocated memory in GBs on the database server.
    memory_size_in_g_bs: ?i32,

    /// The OCID of the database server.
    ocid: ?[]const u8,

    /// The name of the OCI resource anchor for the database server.
    oci_resource_anchor_name: ?[]const u8,

    /// The shape of the database server. The shape determines the amount of CPU,
    /// storage, and memory resources available.
    shape: ?[]const u8,

    /// The current status of the database server.
    status: ?ResourceStatus,

    /// Additional information about the current status of the database server.
    status_reason: ?[]const u8,

    /// The OCID of the VM clusters that are associated with the database server.
    vm_cluster_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .autonomous_virtual_machine_ids = "autonomousVirtualMachineIds",
        .autonomous_vm_cluster_ids = "autonomousVmClusterIds",
        .compute_model = "computeModel",
        .cpu_core_count = "cpuCoreCount",
        .created_at = "createdAt",
        .db_node_storage_size_in_g_bs = "dbNodeStorageSizeInGBs",
        .db_server_id = "dbServerId",
        .db_server_patching_details = "dbServerPatchingDetails",
        .display_name = "displayName",
        .exadata_infrastructure_id = "exadataInfrastructureId",
        .max_cpu_count = "maxCpuCount",
        .max_db_node_storage_in_g_bs = "maxDbNodeStorageInGBs",
        .max_memory_in_g_bs = "maxMemoryInGBs",
        .memory_size_in_g_bs = "memorySizeInGBs",
        .ocid = "ocid",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .shape = "shape",
        .status = "status",
        .status_reason = "statusReason",
        .vm_cluster_ids = "vmClusterIds",
    };
};
