const NodeResourcesFitVersionConfig = @import("node_resources_fit_version_config.zig").NodeResourcesFitVersionConfig;

/// The Kubernetes scheduler version-specific configuration defaults and
/// constraints.
pub const KubeSchedulerVersionConfig = struct {
    /// The NodeResourcesFit configuration with default value and constraints.
    node_resources_fit: ?NodeResourcesFitVersionConfig = null,

    pub const json_field_names = .{
        .node_resources_fit = "nodeResourcesFit",
    };
};
