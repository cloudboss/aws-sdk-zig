const ControlPlaneConfigInfo = @import("control_plane_config_info.zig").ControlPlaneConfigInfo;

/// Information about a provisioned control plane scaling tier.
pub const ControlPlaneScalingTierInfo = struct {
    /// The maximum API request concurrency supported by this tier.
    api_request_concurrency: ?i32 = null,

    /// The maximum cluster database size in GB supported by this tier.
    cluster_database_size_gb: ?i32 = null,

    /// The control plane component configuration overrides specific to this scaling
    /// tier.
    control_plane_component_config_overrides: ?ControlPlaneConfigInfo = null,

    /// The maximum pod scheduling rate per second supported by this tier.
    pod_scheduling_rate_per_second: ?i32 = null,

    /// The name of the scaling tier.
    tier_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_request_concurrency = "apiRequestConcurrency",
        .cluster_database_size_gb = "clusterDatabaseSizeGb",
        .control_plane_component_config_overrides = "controlPlaneComponentConfigOverrides",
        .pod_scheduling_rate_per_second = "podSchedulingRatePerSecond",
        .tier_name = "tierName",
    };
};
