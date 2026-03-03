const FirewallDeploymentModel = @import("firewall_deployment_model.zig").FirewallDeploymentModel;

/// Configures the deployment model for the third-party firewall.
pub const ThirdPartyFirewallPolicy = struct {
    /// Defines the deployment model to use for the third-party firewall policy.
    firewall_deployment_model: ?FirewallDeploymentModel = null,

    pub const json_field_names = .{
        .firewall_deployment_model = "FirewallDeploymentModel",
    };
};
