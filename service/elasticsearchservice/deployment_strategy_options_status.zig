const DeploymentStrategyOptions = @import("deployment_strategy_options.zig").DeploymentStrategyOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Specifies the status of deployment strategy options for the specified
/// Elasticsearch domain.
pub const DeploymentStrategyOptionsStatus = struct {
    /// Specifies deployment strategy options for the specified Elasticsearch
    /// domain.
    options: DeploymentStrategyOptions,

    /// Specifies the status of the deployment strategy options for the specified
    /// Elasticsearch domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
