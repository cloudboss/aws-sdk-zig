const DiskResourceUtilization = @import("disk_resource_utilization.zig").DiskResourceUtilization;
const EBSResourceUtilization = @import("ebs_resource_utilization.zig").EBSResourceUtilization;
const NetworkResourceUtilization = @import("network_resource_utilization.zig").NetworkResourceUtilization;

/// Utilization metrics for the instance.
pub const EC2ResourceUtilization = struct {
    /// The field that contains a list of disk (local storage) metrics that are
    /// associated
    /// with the current instance.
    disk_resource_utilization: ?DiskResourceUtilization,

    /// The EBS field that contains a list of EBS metrics that are associated with
    /// the current
    /// instance.
    ebs_resource_utilization: ?EBSResourceUtilization,

    /// The maximum observed or expected CPU utilization of the instance.
    max_cpu_utilization_percentage: ?[]const u8,

    /// The maximum observed or expected memory utilization of the instance.
    max_memory_utilization_percentage: ?[]const u8,

    /// The maximum observed or expected storage utilization of the instance. This
    /// doesn't
    /// include EBS storage.
    max_storage_utilization_percentage: ?[]const u8,

    /// The network field that contains a list of network metrics that are
    /// associated with the
    /// current instance.
    network_resource_utilization: ?NetworkResourceUtilization,

    pub const json_field_names = .{
        .disk_resource_utilization = "DiskResourceUtilization",
        .ebs_resource_utilization = "EBSResourceUtilization",
        .max_cpu_utilization_percentage = "MaxCpuUtilizationPercentage",
        .max_memory_utilization_percentage = "MaxMemoryUtilizationPercentage",
        .max_storage_utilization_percentage = "MaxStorageUtilizationPercentage",
        .network_resource_utilization = "NetworkResourceUtilization",
    };
};
