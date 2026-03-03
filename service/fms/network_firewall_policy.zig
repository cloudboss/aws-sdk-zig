const FirewallDeploymentModel = @import("firewall_deployment_model.zig").FirewallDeploymentModel;

/// Configures the firewall policy deployment model of Network Firewall. For
/// information about
/// Network Firewall deployment models, see [Network Firewall example
/// architectures with
/// routing](https://docs.aws.amazon.com/network-firewall/latest/developerguide/architectures.html) in the *Network Firewall Developer
/// Guide*.
pub const NetworkFirewallPolicy = struct {
    /// Defines the deployment model to use for the firewall policy. To use a
    /// distributed model,
    /// set
    /// [PolicyOption](https://docs.aws.amazon.com/fms/2018-01-01/APIReference/API_PolicyOption.html) to `NULL`.
    firewall_deployment_model: ?FirewallDeploymentModel = null,

    pub const json_field_names = .{
        .firewall_deployment_model = "FirewallDeploymentModel",
    };
};
