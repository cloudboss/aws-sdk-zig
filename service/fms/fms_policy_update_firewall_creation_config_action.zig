/// Contains information about the actions that you can take to remediate scope
/// violations
/// caused by your policy's `FirewallCreationConfig`.
/// `FirewallCreationConfig` is an optional configuration that you can use to
/// choose which Availability Zones Firewall Manager creates Network Firewall
/// endpoints in.
pub const FMSPolicyUpdateFirewallCreationConfigAction = struct {
    /// Describes the remedial action.
    description: ?[]const u8 = null,

    /// A `FirewallCreationConfig` that you can copy into your current policy's
    /// [SecurityServiceData](https://docs.aws.amazon.com/fms/2018-01-01/APIReference/API_SecurityServicePolicyData.html) in order to remedy scope violations.
    firewall_creation_config: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .firewall_creation_config = "FirewallCreationConfig",
    };
};
