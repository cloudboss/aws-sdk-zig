pub const RDSStorageFindingReasonCode = enum {
    ebs_volume_allocated_storage_under_provisioned,
    ebs_volume_throughput_under_provisioned,
    ebs_volume_iops_over_provisioned,
    ebs_volume_throughput_over_provisioned,
    new_generation_storage_type_available,
    db_cluster_storage_option_available,
    db_cluster_storage_savings_available,

    pub const json_field_names = .{
        .ebs_volume_allocated_storage_under_provisioned = "EBS_VOLUME_ALLOCATED_STORAGE_UNDER_PROVISIONED",
        .ebs_volume_throughput_under_provisioned = "EBS_VOLUME_THROUGHPUT_UNDER_PROVISIONED",
        .ebs_volume_iops_over_provisioned = "EBS_VOLUME_IOPS_OVER_PROVISIONED",
        .ebs_volume_throughput_over_provisioned = "EBS_VOLUME_THROUGHPUT_OVER_PROVISIONED",
        .new_generation_storage_type_available = "NEW_GENERATION_STORAGE_TYPE_AVAILABLE",
        .db_cluster_storage_option_available = "DB_CLUSTER_STORAGE_OPTION_AVAILABLE",
        .db_cluster_storage_savings_available = "DB_CLUSTER_STORAGE_SAVINGS_AVAILABLE",
    };
};
