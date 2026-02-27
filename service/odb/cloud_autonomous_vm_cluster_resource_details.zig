/// Resource details of an Autonomous VM cluster.
pub const CloudAutonomousVmClusterResourceDetails = struct {
    /// The unique identifier of the Autonomous VM cluster.
    cloud_autonomous_vm_cluster_id: ?[]const u8,

    /// The amount of unallocated Autonomous Database storage in the Autonomous VM
    /// cluster, in terabytes.
    unallocated_adb_storage_in_t_bs: ?f64,

    pub const json_field_names = .{
        .cloud_autonomous_vm_cluster_id = "cloudAutonomousVmClusterId",
        .unallocated_adb_storage_in_t_bs = "unallocatedAdbStorageInTBs",
    };
};
