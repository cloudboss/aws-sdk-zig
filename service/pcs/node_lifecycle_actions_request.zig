const ScriptCachingPolicy = @import("script_caching_policy.zig").ScriptCachingPolicy;
const NodeLifecycleStages = @import("node_lifecycle_stages.zig").NodeLifecycleStages;

/// The lifecycle actions to configure on a compute node group when you create
/// it. Lifecycle actions define scripts that PCS runs on compute nodes at
/// specific stages of their lifecycle.
pub const NodeLifecycleActionsRequest = struct {
    /// The caching policy for node lifecycle scripts. The default value is
    /// `CACHE_ONCE`. Valid values:
    ///
    /// * `CACHE_ONCE` – Downloads each script once and reuses it on subsequent
    ///   boots.
    /// * `REFRESH_ON_REBOOT` – Downloads each script on every boot.
    script_caching_policy: ScriptCachingPolicy = .cache_once,

    /// The lifecycle stages where you configure scripts to run.
    stages: NodeLifecycleStages,

    pub const json_field_names = .{
        .script_caching_policy = "scriptCachingPolicy",
        .stages = "stages",
    };
};
