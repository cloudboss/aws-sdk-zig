const Tier = @import("tier.zig").Tier;

/// Describes the workloads on a component.
pub const Workload = struct {
    /// The name of the component.
    component_name: ?[]const u8,

    /// Indicates whether all of the component configurations required to monitor a
    /// workload were provided.
    missing_workload_config: ?bool,

    /// The tier of the workload.
    tier: ?Tier,

    /// The ID of the workload.
    workload_id: ?[]const u8,

    /// The name of the workload.
    workload_name: ?[]const u8,

    /// If logging is supported for the resource type, shows whether the component
    /// has configured logs to be monitored.
    workload_remarks: ?[]const u8,

    pub const json_field_names = .{
        .component_name = "ComponentName",
        .missing_workload_config = "MissingWorkloadConfig",
        .tier = "Tier",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
        .workload_remarks = "WorkloadRemarks",
    };
};
