const CloudAutonomousVmClusterResourceDetails = @import("cloud_autonomous_vm_cluster_resource_details.zig").CloudAutonomousVmClusterResourceDetails;

/// Information about unallocated resources in the Cloud Exadata infrastructure.
pub const CloudExadataInfrastructureUnallocatedResources = struct {
    /// A list of Autonomous VM clusters associated with this Cloud Exadata
    /// Infrastructure.
    cloud_autonomous_vm_clusters: ?[]const CloudAutonomousVmClusterResourceDetails,

    /// The display name of the Cloud Exadata infrastructure.
    cloud_exadata_infrastructure_display_name: ?[]const u8,

    /// The unique identifier of the Cloud Exadata infrastructure.
    cloud_exadata_infrastructure_id: ?[]const u8,

    /// The amount of unallocated Exadata storage available, in terabytes (TB).
    exadata_storage_in_t_bs: ?f64,

    /// The amount of unallocated local storage available, in gigabytes (GB).
    local_storage_in_g_bs: ?i32,

    /// The amount of unallocated memory available, in gigabytes (GB).
    memory_in_g_bs: ?i32,

    /// The number of unallocated Oracle CPU Units (OCPUs) available.
    ocpus: ?i32,

    pub const json_field_names = .{
        .cloud_autonomous_vm_clusters = "cloudAutonomousVmClusters",
        .cloud_exadata_infrastructure_display_name = "cloudExadataInfrastructureDisplayName",
        .cloud_exadata_infrastructure_id = "cloudExadataInfrastructureId",
        .exadata_storage_in_t_bs = "exadataStorageInTBs",
        .local_storage_in_g_bs = "localStorageInGBs",
        .memory_in_g_bs = "memoryInGBs",
        .ocpus = "ocpus",
    };
};
