const Tier = @import("tier.zig").Tier;

/// The configuration of the workload.
pub const WorkloadConfiguration = struct {
    /// The configuration settings of the workload.
    configuration: ?[]const u8 = null,

    /// The configuration of the workload tier.
    tier: ?Tier = null,

    /// The name of the workload.
    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .tier = "Tier",
        .workload_name = "WorkloadName",
    };
};
