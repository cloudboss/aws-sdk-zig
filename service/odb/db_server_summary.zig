const ComputeModel = @import("compute_model.zig").ComputeModel;
const DbServerPatchingDetails = @import("db_server_patching_details.zig").DbServerPatchingDetails;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Information about a database server.
pub const DbServerSummary = struct {
    /// A list of unique identifiers for the Autonomous VMs.
    autonomous_virtual_machine_ids: ?[]const []const u8,

    /// A list of identifiers for the Autonomous VM clusters.
    autonomous_vm_cluster_ids: ?[]const []const u8,

    /// The OCI model compute model used when you create or clone an instance: ECPU
    /// or OCPU. An ECPU is an abstracted measure of compute resources. ECPUs are
    /// based on the number of cores elastically allocated from a pool of compute
    /// and storage servers. An OCPU is a legacy physical measure of compute
    /// resources. OCPUs are based on the physical core of a processor with
    /// hyper-threading enabled.
    compute_model: ?ComputeModel,

    /// The number of CPU cores enabled on the database server.
    cpu_core_count: ?i32,

    /// The date and time when the database server was created.
    created_at: ?i64,

    /// The amount of local node storage, in gigabytes (GB), that's allocated on the
    /// database server.
    db_node_storage_size_in_g_bs: ?i32,

    /// The unique identifier of the database server.
    db_server_id: ?[]const u8,

    db_server_patching_details: ?DbServerPatchingDetails,

    /// The user-friendly name of the database server. The name doesn't need to be
    /// unique.
    display_name: ?[]const u8,

    /// The ID of the Exadata infrastructure that hosts the database server.
    exadata_infrastructure_id: ?[]const u8,

    /// The total number of CPU cores available on the database server.
    max_cpu_count: ?i32,

    /// The total amount of local node storage, in gigabytes (GB), that's available
    /// on the database server.
    max_db_node_storage_in_g_bs: ?i32,

    /// The total amount of memory, in gigabytes (GB), that's available on the
    /// database server.
    max_memory_in_g_bs: ?i32,

    /// The amount of memory, in gigabytes (GB), that's allocated on the database
    /// server.
    memory_size_in_g_bs: ?i32,

    /// The OCID of the database server.
    ocid: ?[]const u8,

    /// The name of the OCI resource anchor for the database server.
    oci_resource_anchor_name: ?[]const u8,

    /// The hardware system model of the Exadata infrastructure that the database
    /// server is hosted on. The shape determines the amount of CPU, storage, and
    /// memory resources available.
    shape: ?[]const u8,

    /// The current status of the database server.
    status: ?ResourceStatus,

    /// Additional information about the status of the database server.
    status_reason: ?[]const u8,

    /// The IDs of the VM clusters that are associated with the database server.
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
