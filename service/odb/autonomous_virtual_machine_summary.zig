const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// A summary of an Autonomous Virtual Machine (VM) within an Autonomous VM
/// cluster.
pub const AutonomousVirtualMachineSummary = struct {
    /// The unique identifier of the Autonomous VM.
    autonomous_virtual_machine_id: ?[]const u8,

    /// The IP address used by clients to connect to this Autonomous VM.
    client_ip_address: ?[]const u8,

    /// The unique identifier of the Autonomous VM cluster containing this
    /// Autonomous VM.
    cloud_autonomous_vm_cluster_id: ?[]const u8,

    /// The number of CPU cores allocated to this Autonomous VM.
    cpu_core_count: ?i32,

    /// The amount of storage allocated to this Autonomous Virtual Machine, in
    /// gigabytes (GB).
    db_node_storage_size_in_g_bs: ?i32,

    /// The display name of the database server hosting this Autonomous VM.
    db_server_display_name: ?[]const u8,

    /// The unique identifier of the database server hosting this Autonomous VM.
    db_server_id: ?[]const u8,

    /// The amount of memory allocated to this Autonomous VM, in gigabytes (GB).
    memory_size_in_g_bs: ?i32,

    /// The Oracle Cloud Identifier (OCID) of the Autonomous VM.
    ocid: ?[]const u8,

    /// The name of the Oracle Cloud Infrastructure (OCI) resource anchor associated
    /// with this Autonomous VM.
    oci_resource_anchor_name: ?[]const u8,

    /// The current status of the Autonomous VM.
    status: ?ResourceStatus,

    /// Additional information about the current status of the Autonomous VM, if
    /// applicable.
    status_reason: ?[]const u8,

    /// The name of the Autonomous VM.
    vm_name: ?[]const u8,

    pub const json_field_names = .{
        .autonomous_virtual_machine_id = "autonomousVirtualMachineId",
        .client_ip_address = "clientIpAddress",
        .cloud_autonomous_vm_cluster_id = "cloudAutonomousVmClusterId",
        .cpu_core_count = "cpuCoreCount",
        .db_node_storage_size_in_g_bs = "dbNodeStorageSizeInGBs",
        .db_server_display_name = "dbServerDisplayName",
        .db_server_id = "dbServerId",
        .memory_size_in_g_bs = "memorySizeInGBs",
        .ocid = "ocid",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .status = "status",
        .status_reason = "statusReason",
        .vm_name = "vmName",
    };
};
