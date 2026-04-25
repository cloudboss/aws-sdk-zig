const DeploymentStrategyOptions = @import("deployment_strategy_options.zig").DeploymentStrategyOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of deployment strategy options for the domain.
pub const DeploymentStrategyOptionsStatus = struct {
    /// Deployment strategy options for the domain.
    options: DeploymentStrategyOptions,

    /// The current status of the deployment strategy options for the domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
