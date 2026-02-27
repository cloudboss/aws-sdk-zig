const Tier = @import("tier.zig").Tier;

/// The configuration of the workload.
pub const WorkloadConfiguration = struct {
    /// The configuration settings of the workload.
    configuration: ?[]const u8,

    /// The configuration of the workload tier.
    tier: ?Tier,

    /// The name of the workload.
    workload_name: ?[]const u8,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .tier = "Tier",
        .workload_name = "WorkloadName",
    };
};
