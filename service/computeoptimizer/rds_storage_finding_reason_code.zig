const std = @import("std");

pub const RDSStorageFindingReasonCode = enum {
    ebs_volume_allocated_storage_under_provisioned,
    ebs_volume_throughput_under_provisioned,
    ebs_volume_iops_over_provisioned,
    ebs_volume_throughput_over_provisioned,
    new_generation_storage_type_available,
    db_cluster_storage_option_available,
    db_cluster_storage_savings_available,

    pub const json_field_names = .{
        .ebs_volume_allocated_storage_under_provisioned = "EBSVolumeAllocatedStorageUnderprovisioned",
        .ebs_volume_throughput_under_provisioned = "EBSVolumeThroughputUnderprovisioned",
        .ebs_volume_iops_over_provisioned = "EBSVolumeIOPSOverprovisioned",
        .ebs_volume_throughput_over_provisioned = "EBSVolumeThroughputOverprovisioned",
        .new_generation_storage_type_available = "NewGenerationStorageTypeAvailable",
        .db_cluster_storage_option_available = "DBClusterStorageOptionAvailable",
        .db_cluster_storage_savings_available = "DBClusterStorageSavingsAvailable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ebs_volume_allocated_storage_under_provisioned => "EBSVolumeAllocatedStorageUnderprovisioned",
            .ebs_volume_throughput_under_provisioned => "EBSVolumeThroughputUnderprovisioned",
            .ebs_volume_iops_over_provisioned => "EBSVolumeIOPSOverprovisioned",
            .ebs_volume_throughput_over_provisioned => "EBSVolumeThroughputOverprovisioned",
            .new_generation_storage_type_available => "NewGenerationStorageTypeAvailable",
            .db_cluster_storage_option_available => "DBClusterStorageOptionAvailable",
            .db_cluster_storage_savings_available => "DBClusterStorageSavingsAvailable",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
